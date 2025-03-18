select day
,transaction_type
,payment_processor_name
,payment_method_id
,division_site_id
,count(division_order_id)units
,sum(payment_amount)amount
,transaction_currency

from
(
select trunc(settlement_date)day
,transaction_type
,payment_processor_name
,payment_method_id
,division_site_id
,(case when transaction_type = 'ChargeBack' and creation_date = (select min(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack') then 'Good'
when transaction_type = 'ChargeBack' and creation_date > (select min(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack') then 'Ignore'
else 'Good' end)trans_type
,division_order_id
,payment_amount
,transaction_currency


from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type in ('Settle','ChargeBack')
and status = 'Completed'

)

where trans_type <> 'Ignore' 

group by day
,transaction_type
,payment_processor_name
,payment_method_id
,division_site_id
,transaction_currency