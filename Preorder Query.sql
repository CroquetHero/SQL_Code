select *

from cpg_payment_transaction rpt

where creation_date > '1/1/2017'
and transaction_type = 'Authorize'
and status = 'Completed'
and division_id = 'pacific'
and request_money_amount = 0
and division_order_id not like '%OrderID%'
and payment_method_id <> 'MicrosoftPayment'
and (select transaction_id from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null
and rownum < 201