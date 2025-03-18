select to_char(creation_date,'MM/YYYY')month
,transaction_type
,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
,payment_service_id
,division_site_id
,count(transaction_id)units

from cpg_payment_transaction rpt

where creation_date between '8/1/2015' and '1/1/2016'
and transaction_type in ('ChargeBack')
and status = 'Completed'
and payment_method_id = 'MasterCard'
and payment_service_id in ('mes', 'firstdata', 'litle')
and division_site_id in ('tmamer', 'kasperus')
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBack') and status = 'Completed')

group by to_char(creation_date,'MM/YYYY')
,transaction_type
,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)
,payment_service_id
,division_site_id