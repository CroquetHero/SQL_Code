select day
,cb_status
,Sub_Type
,payment_type
,count(requisition_id)units
from
(
select day
,cb_status
,requisition_id
,payment_type
,(case when (select action_performed from req_requisition_log where OLD_requisition_id= requisition_id and action_performed = 'ACTION_CREATE_HGOP2_LINE_ITEM' and rownum < 2) is not null then 'Import' else 'DR' end)Sub_Type


from
(
select day
,requisition_id
,subscription_id
--,line_item_type
,cb_status
,payment_type
,(select requisition_id from req_line_item where line_item_id = OLD_req_line_item)OLD_requisition_id

from
(
select trunc(ssli.creation_date)day
,rli.requisition_id
,subscription_id
,req_line_item_id
,line_item_type
,(select distinct first_value(req_line_item_id) over (order by creation_date) from sub_subscription_li_item where subscription_id = ssli.subscription_id)OLD_req_line_item
,(case when (select requisition_id from frd_dispute_order_activity where status = 'STATUS_DISPUTE_CHARGE_BACK' and requisition_id = rli.requisition_id and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
,(case when (select card_type from pmt_payment_transaction where requisition_id = rli.requisition_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is not null then (select card_type from pmt_payment_transaction where requisition_id = rli.requisition_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) 
when (select card_type from pmt_payment_transaction where requisition_id = rli.requisition_id and transaction_type = 'ClearFunds' and status = 'Completed' and rownum < 2) is not null then (select card_type from pmt_payment_transaction where requisition_id = rli.requisition_id and transaction_type = 'ClearFunds' and status = 'Completed' and rownum < 2) 
else 'Other' end)payment_type

--select *
from sub_subscription_li_item ssli
,req_line_item rli

where rli.line_item_id = ssli.req_line_item_id
and ssli.creation_date between '3/16/2018' and  '3/17/2018'
and site_id = 'avgstore'
and line_item_type in ('RENEWED')

)BD

)BD2

)

group by day
,cb_status
,Sub_Type
,payment_type

order by day