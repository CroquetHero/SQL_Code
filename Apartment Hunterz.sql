select day
,model_type
,cb_status
,count(transaction_id)units

from
(
select trunc(creation_date)day
,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
,transaction_id
,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
,merchant_descriptor
,(case when (select min(creation_date) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'Settle' and status = 'Completed' and division_site_id = '139869') < '7/14/2016' then 'Old Model' else 'New Model' end)model_type

from cpg_payment_transaction rpt

where creation_date between '4/1/2016' and '7/14/2016'
and transaction_type = 'Settle'
and status = 'Completed'
and division_site_id = '139869'

)

group by day
,model_type
,cb_status

order by day