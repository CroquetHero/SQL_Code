select day,site_id
,count(requisition_id)units
select *
from
(
select requisition_id
,reason
--,site_id
,trunc(creation_date)day
,shipping_currency
--,is_processed
,(select sum(total) from inv_cancel_request where requisition_id = icr.requisition_id)Cancel_total
,(select card_type from pmt_payment_transaction where requisition_id = icr.requisition_id and transaction_type = 'RequestFunds' and status = 'Completed' and rownum < 2)PayPal
,(select response_amount from pmt_payment_transaction where requisition_id = icr.requisition_id and transaction_type = 'BankPaymentCredit' and status = 'Completed' and rownum < 2)refund_amount

from inv_cancel_request icr

where icr.creation_date between '8/1/2016'  and sysdate
and icr.modification_date between '8/1/2016' and sysdate
and type not in ('EXPIRED_ORDER')
and total = 0
and site_id = 'samsung'
and is_processed = '1'
--and requisition_id = '9759364905'

)

where PayPal in ('PayPalExpress','PayPalExpressCheckout')
and refund_amount is null

group by day,site_id

order by site_id,day
