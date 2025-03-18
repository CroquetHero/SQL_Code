select trunc(creation_date)day
,division_order_id
,transaction_type
,payment_method_id
,payment_service_id
,request_money_amount
,request_money_currency

from cpg_payment_transaction

where creation_date between '9/1/2017' and '10/1/2017'
and transaction_type in ('Refund', 'ChargeBack')
and status = 'Completed'
and division_site_id = 'adbehbr'