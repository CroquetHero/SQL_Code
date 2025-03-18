select lag
,count(transaction_id)units

from
(
select (trunc(creation_date) - (select trunc(min(creation_date))  from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed'))lag
,transaction_id

from cpg_payment_transaction rpt

where creation_date > '1/1/2017'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and division_site_id in ('samsung','samsung2')
--and payment_service_id = 'nab'
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')

)

group by lag

order by lag