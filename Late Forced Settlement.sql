select *

from
(
select requisition_id
,trunc(creation_date)ship_date
,tracking_number
,site_id
,(select min(request_amount) from pmt_payment_transaction where requisition_id = ssn.requisition_id and shipment_notice_id = ssn.shipment_notice_id)settle_amount
,(select sum(request_amount) from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Settle' and status = 'Completed')total_settle_amount
,(select sum(request_amount) from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and status = 'Completed')Auth_amount
,(select sum(request_amount) from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and status = 'Expired')Expired_Auth_amount
,total_settle
,(select card_type from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)payment_Type
,(select modification_date from pmt_payment_transaction where requisition_id = ssn.requisition_id and ssn.total_settle = request_amount and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)settle_date

--select *
from shP_shipment_notice ssn

where creation_date between trunc(sysdate) - 10 and trunc(sysdate) - 3
--and site_id in('samsung2', 'samsung')
and status <> 'Shipped'
and total_settle > 0
and (select card_type from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) in ('visa','masterCard','americanExpress','discover','NCLCreditDirect')
--and requisition_id = '14866314071'
and (select status from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Credit'  and status ='Completed' and rownum < 2) is null

)

where settle_amount is null
and settle_date is null
