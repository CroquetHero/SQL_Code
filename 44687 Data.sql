select day
,payment_service_id
,payment_method_id
,rec_flag
,cb_status
,merchant_descriptor
,count(division_order_id)units

from
(
select payment_service_id
,payment_method_id
,division_order_id
,trunc(creation_date)day
,merchant_descriptor
--,substr(custom_data,instr(custom_data,'originalOrder=',1) + 14,14)order_id
,(case when custom_data like '%recurring%' then 'Recurring'
when substr(custom_data,instr(custom_data,'originalOrder=',1) + 14,14) like '%Curren%' then 'Non-Recurring'
when substr(custom_data,instr(custom_data,'originalOrder=',1) + 14,14) <> division_order_id then 'Recurring'
else 'Non-Recurring' end)Rec_Flag
,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
,(select distinct first_value(division_order_id) over (order by creation_date) dup_order from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = '44687' and transaction_type = 'Settle' and status = 'Completed')orig_order

from cpg_payment_transaction rpt

where creation_date between '9/1/2016' and '10/1/2016'
and transaction_type = 'Settle'
and status = 'Completed'
and division_site_id = '44687'
and merchant_descriptor like '%OSpeedy%'

)

group by day
,payment_service_id
,payment_method_id
,rec_flag
,cb_status
,merchant_descriptor
