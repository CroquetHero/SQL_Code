select requisition_id
,date_performed
,(select site_id from req_requisition where requisition_id = rrl.requisition_id and rownum < 2)site
,(case when (select site_id from pmt_payment_transaction where requisition_id = rrl.requisition_id and transaction_type = 'RequestFunds' and rownum < 2) is not null then  (select CARD_TYPE from pmt_payment_transaction where requisition_id = rrl.requisition_id and transaction_type = 'RequestFunds' and rownum < 2)
when (select CARD_TYPE from pmt_payment_transaction where requisition_id = rrl.requisition_id and transaction_type = 'Authorize' and rownum < 2) is not null then (select CARD_TYPE from pmt_payment_transaction where requisition_id = rrl.requisition_id and transaction_type = 'Authorize' and rownum < 2)
else 'Other' end)payment_type

from req_requisition_log rrl

where action_performed = 'PREORDER_AUTHORIZED_ORDER_PLACEMENT'
and date_performed between '1/1/2018' and sysdate
--and (select site_id from req_requisition where requisition_id = rrl.requisition_id and rownum < 2) = 'nvidia'

order by date_performed