select bank_name
,bin
,division_site_id
,payment_service_id
,payment_method_id
,Expired_Duration
,count(division_order_id)units
--select *
from
(
select division_order_id
,bank_name
,Bin
,division_site_id
,payment_service_id
,payment_method_id
,(substr(expired_month,0,2)) + (substr(expired_month,3,2)*12) - (substr(old_exp_date,0,2) + (substr(old_exp_date,3,2)*12))Expired_Duration

from
(
select division_order_id
,account_token
,division_site_id
,payment_service_id
,payment_method_id
,trunc(creation_date)day
,substr(expiration_date,0,2) | | substr(expiration_date,3,2)expired_month
,substr((select min(expiration_date) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'Authorize' and status = 'Completed'),0,2) | | substr((select min(expiration_date) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'Authorize' and status = 'Completed'),3,2)Old_expired_month
,expiration_date
,(case when bank_name like '%bankName=%' and bank_name like '%len=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when bank_name like '%bankName=%' and bank_name like '%authExp=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'authExp=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, length(bank_name) - (instr(bank_name, 'bankName=',1)+ 8))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%sock.location=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'sock.location=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%authExp=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'authExp=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 8))
else null end)bank_name
,(select distinct first_value(expiration_date) over (order by transaction_id desc) from cpg_payment_transaction where account_token = rpt.account_token and expiration_date <> rpt.expiration_date and transaction_type = 'Authorize' and status = 'Completed' and expiration_date not like '%/%')old_exp_date
,(select distinct first_value(account_bin) over (order by creation_date desc) from cpg_customer_account where account_token = rpt.account_token)Bin
,substr(custom_data,instr(custom_data,'renewAttNum=',1,1) + 12,instr(custom_data,'cardBrand=',1,1) - (instr(custom_data,'renewAttNum=',1,1) + 14))renewAttNum
,substr(custom_data,instr(custom_data,'midCategory=',1,1) + 12,instr(custom_data,'subscriptionID=',1,1) - (instr(custom_data,'midCategory=',1,1) + 14))recurring_flag

from cpg_payment_transaction rpt

where creation_date between trunc(sysdate) - 30 and trunc(sysdate) - 25
and transaction_type = 'Authorize'
and status = 'Completed'
and division_id = 'pacific'
and payment_method_id in ('MasterCard','Visa')
and division_order_id not like '%OrderID%'
and length(expiration_date) = 4
and transaction_id = (select distinct first_value(transaction_id) over (order by transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize')

)

where renewAttNum = '1'
and recurring_flag = 'recurring'
and old_exp_date is not null
and bin = 'tll8WRz5aj4bPqHlFU938Q=='

)

group by bin
,division_site_id
,payment_service_id
,payment_method_id
,Expired_Duration
,bank_name
