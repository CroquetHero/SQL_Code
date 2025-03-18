select first_order_id
,subscription_id
,sub_length
,renewal_num
--,Current_sub_status
,(case when (select status from pmt_payment_transaction where Last_Order_ID = requisition_id and transaction_type = 'Credit' and status = 'Completed' and rownum < 2) is not null then 'Refund'
when (select status from frd_dispute_order_activity where Last_Order_ID = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then 'CB'
when Current_sub_status = 'Declined' then 'Declined'
when Current_sub_status = 'Pending Activation' then 'Manual Sub'
else 'Good' end)Last_Order_Status

from
(
select distinct first_order_id
,(select requisition_id from req_line_item where line_item_id = Last_req_line_item_id)Last_Order_ID
,subscription_id
,renewal_num
,Current_sub_status
,(end_date - start_date)sub_length

from
(
select rli.requisition_id first_order_id
,(select distinct first_value(req_line_item_id) over (order by  sub_line_item_id desc) from SUB_SUBSCRIPTION_LI_ITEM where  subscription_id = ssli.subscription_id)Last_req_line_item_id
,subscription_id
,initial_is_automatic
,(select count(line_item_type) from SUB_SUBSCRIPTION_LI_ITEM where subscription_id = ssli.subscription_id)renewal_num
,(case when (select action from SUB_subscription_log where subscription_id = ssli.subscription_id and action = 'ACTION_CANCEL_SUBSCRIPTION' and rownum < 2) is not null then 'Declined' 
when (select action from SUB_subscription_log where subscription_id = ssli.subscription_id and action = 'ACTION_CREATE_SUBSCRIPTION' and description = 'PendingActivation' and rownum< 2) is not null then 'Pending Activation' 
else 'Other' end)Current_sub_status
,(select distinct first_value(activation_date) over (order by creation_date) from SUB_SUBSCRIPTION_LI_ITEM where subscription_id = ssli.subscription_id)Start_Date
,(select distinct first_value(next_renewal_date) over (order by creation_date) from SUB_SUBSCRIPTION_LI_ITEM where subscription_id = ssli.subscription_id)End_Date

from req_line_item rli, SUB_SUBSCRIPTION_LI_ITEM ssli

where req_line_item_id = line_item_id
--and rli.requisition_id in 
and subscription_id = '2107689909'
and line_item_type = 'ORIGINAL'

)BD

)
