select payment_method_id
,payment_service_id
,settle_status
,division_site_id
--,bank_name
,(exp_date - auth_date) difference
,count(division_order_id)units

from
(
select division_order_id
,trunc(creation_date)auth_date
,payment_method_id
,payment_service_id
,division_site_id
,expiration_date
--,custom_data
--,(select count(transaction_id) from cpg_payment_transaction cpt where account_token = rpt.account_token and transaction_type = 'AccountUpdate' and status = 'Completed' and creation_date between (select max(creation_date) from cpg_payment_transaction where cpt.account_token = account_token and rpt.division_order_id <> division_order_id and transaction_type = 'Settle' and status = 'Completed') and rpt.creation_date) AccountUpdate_Count_Comp
--,(select count(transaction_id) from cpg_payment_transaction cpt where account_token = rpt.account_token and transaction_type = 'AccountUpdate' and creation_date between (select max(creation_date) from cpg_payment_transaction where cpt.account_token = account_token and rpt.division_order_id <> division_order_id and transaction_type = 'Settle' and status = 'Completed') and rpt.creation_date)AccountUpdate_Count_Total
,(case when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 10))
else 'No Bank' end)bank_name
,(case when (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') is not null then 'Settled' else 'Not Settled' end)settle_status
,to_date((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) || '/1/' || '20' || substr(expiration_date,3,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')exp_date

from cpg_payment_transaction rpt

where creation_date between '4/1/2016' and '3/25/2017'
and transaction_type = 'Authorize'
--and status = 'Completed'
and payment_method_id in ('MasterCard', 'Visa')
and payment_service_id in ('litle', 'mes', 'firstdata')
and division_site_id in ('tmamer', 'kasperus', 'avast')
and custom_data like '%recurring%'
and length(expiration_date) = 4
and creation_date = (select distinct first_value(creation_date) over (order by creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and division_site_id = rpt.division_site_id and transaction_type = 'Authorize')
and payment_service_id = (select distinct first_value(payment_service_id) over (order by creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and division_site_id = rpt.division_site_id and transaction_type = 'Authorize')

order by expiration_date

)

where /*(exp_date - auth_date) between 0 and 150
 */bank_name = 'Wells Fargo Bank, National Association'

group by payment_method_id
,payment_service_id
,division_site_id
--,bank_name
--,(floor((exp_date - auth_date)/100)*100)
,(exp_date - auth_date)
,settle_status