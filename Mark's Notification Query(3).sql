select distinct subscription_id
,Prev_Requisition_id
,Prev_Auth_Date
,Renewed_Requisition_id
,(select min(trunc(creation_date)) from req_line_item where Renewed_Requisition_id = Requisition_id)Renewed_Date
,site_id
,locale
--,Thirty_Notification_Flag
--,Seven_Notification_Flag
,Next_Renewal_Status
,Prev_Renewal_Type
,(case when Renewed_Requisition_id is null then 'Cancelled'
when substr(Renewed_Requisition_id,length(Renewed_Requisition_id) - 1,2) <> '00' then 'Self-Renewal' 
when substr(Renewed_Requisition_id,length(Renewed_Requisition_id) - 1,2) = '00' then 'Auto-Renewal' 
else 'Other' end)Self_Renewal
,(case when Renewed_Requisition_id is null then 'N/A'
when (select status from frd_dispute_order_activity where requisition_id = Renewed_Requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then 'CB' 
else 'No CB' end)cb_status

from
(
select subscription_id
,Prev_Requisition_id
,Prev_Auth_Date
,(select requisition_id from req_line_item where line_item_id = Next_line_Item)Renewed_Requisition_id
,site_id
,locale
--,Thirty_Notification_Flag
--,Seven_Notification_Flag
,Next_Renewal_Status
,Prev_Renewal_Type
,sub_length
,(case when Prev_Renewal_Type = 'Manual' then 'Good'
when sub_length between 355 and 375 then 'Good'
else 'Bad' end)sub_status

--select *
from
(
select ssli.subscription_id
,rli.site_id
,rr.locale
,trunc(rli.creation_date)Prev_Auth_Date
,(purchased_duration_date-purchase_date)sub_length
--,(case when (select event_name from ntf_notification where rr.requisition_id = requisition_id and event_name = 'User Subscription Expired Credit Card Event 30day' and rownum< 2) is not null then 'Yes' else 'No' end)Thirty_Notification_Flag
--,(case when (select event_name from ntf_notification where rr.requisition_id = requisition_id and event_name = 'User Subscription Expired Credit Card Event 7day' and rownum< 2) is not null then 'Yes' else 'No' end)Seven_Notification_Flag
,(case when trunc(rli.creation_date) = (select distinct first_value(trunc(creation_date)) over (order by creation_date desc) from SUB_SUBSCRIPTION_LI_ITEM where ssli.subscription_id = subscription_id) then 'Cancelled' else 'Renewed' end)Next_Renewal_Status
,(case when trunc(rli.creation_date) = (select distinct first_value(trunc(creation_date)) over (order by creation_date desc) from SUB_SUBSCRIPTION_LI_ITEM where ssli.subscription_id = subscription_id) then 'Cancelled' else (select distinct first_value(req_line_item_id) over (order by creation_date) from SUB_SUBSCRIPTION_LI_ITEM where ssli.subscription_id = subscription_id and trunc(rli.creation_date) < trunc(creation_date)) end)Next_line_Item
,rli.requisition_id Prev_Requisition_id
,(case when initial_is_automatic = '1' then 'Auto' else 'Manual' end) Prev_Renewal_Type

from req_requisition rr,req_line_item rli,SUB_SUBSCRIPTION_LI_ITEM ssli

where rr.requisition_id = rli.requisition_id
and rli.line_item_id = ssli.req_line_item_id
and rli.site_id in ('tmemea','tmecon')
and rr.locale = 'en_GB'
and rli.requisition_id in ('8728056859')

)

)BD

where sub_status = 'Good'
