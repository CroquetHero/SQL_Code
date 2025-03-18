select division_order_id
,cb_amount
,refund_date
,bank_code

--select *
from
(
select division_order_id
,request_money_amount cb_amount
,(select sum(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')chargeback_amount
,(select sum(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')settle_amount
,(select sum(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed')rev_amount
,(select sum(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')refund_amount
,(select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')refund_date
,bank_code

from cpg_payment_transaction rpt

where creation_date > '9/1/2016'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id = 'netgiro-bnp'

)

where (nvl(settle_amount,0) + nvl(rev_amount,0) - nvl(chargeback_amount,0) - nvl(refund_amount,0)) < 0
and refund_date is not null


