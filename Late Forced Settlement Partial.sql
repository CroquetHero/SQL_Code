select *

from
(
select requisition_id
,trunc(creation_date)ship_date
,shipment_notice_id
,((select request_amount from pmt_payment_transaction where requisition_id = ssn.requisition_id and shipment_notice_id = ssn.shipment_notice_id) + (select request_amount from pmt_payment_transaction ppt where requisition_id = ssn.requisition_id and transaction_id = (100 +(select transaction_id from pmt_payment_transaction where requisition_id = ppt.requisition_id and shipment_notice_id = ssn.shipment_notice_id))))Amount
,(select request_amount from pmt_payment_transaction where requisition_id = ssn.requisition_id and shipment_notice_id = ssn.shipment_notice_id) amount2
,total_settle
,(select card_type from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and rownum < 2)payment_Type

--select *
from shP_shipment_notice ssn

where creation_date > '1/1/2017'
and site_id in ('samsung2','samsung')
and status <> 'Shipped'
and total_settle > 0
and (select card_type from pmt_payment_transaction where requisition_id = ssn.requisition_id and transaction_type = 'Authorize' and rownum < 2) in ('visa','masterCard','americanExpress','discover','NCLCreditDirect')
and requisition_id = '14924958671'

)

where amount2 <> total_settle

