select division_order_id
,Bin
,Update_Date
,(case when bank_name like '%bankName=%' and bank_name like '%len=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when bank_name like '%bankName=%' and bank_name like '%authExp=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'authExp=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, length(bank_name) - (instr(bank_name, 'bankName=',1)+ 8))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%sock.location=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'sock.location=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%authExp=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'authExp=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 8))
else null end)bank_name
,response_message
,status
,payment_method_id
,division_id
,(case when secondary_date is not null then (substr(old_expired_month,0,2)) + (substr(old_expired_month,3,2)*12) - (substr(update_month,0,2) + (substr(update_month,3,2)*12))
else (substr(expired_month,0,2)) + (substr(expired_month,3,2)*12) - (substr(update_month,0,2) + (substr(update_month,3,2)*12)) end)Expired_Duration
,expiration_date
,secondary_date
,Comp_Bool
,difference

from

(
select division_order_id
,(select distinct first_value(account_bin) over (order by creation_date desc) from cpg_customer_account where account_token = rpt.account_token)Bin
,trunc(creation_date)Update_Date
,to_char(creation_date,'MMYY')Update_month
,substr(expiration_date,0,2) | | substr(expiration_date,3,2)expired_month
,substr(secondary_date,0,2) | | substr(secondary_date,3,2)Old_expired_month
,(select distinct first_value(bank_name) over (order by creation_date desc) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'Authorize' and bank_name is not null)bank_name
,(select distinct first_value(custom_data) over (order by creation_date desc) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'Authorize' and custom_data is not null)custom_data
,response_message
,status
,payment_method_id
,division_id
,expiration_date
,secondary_date
,(case when status = 'Completed' then '1' else '0' end)Comp_Bool
,(case when secondary_date is null then 'N/A'
else TO_CHAR((substr(expiration_date,0,2)) + (substr(expiration_date,3,2)*12) - (substr(secondary_date,0,2) + (substr(secondary_date,3,2)*12))) end)difference


from cpg_payment_transaction rpt

where creation_date between trunc(sysdate) - 4 and trunc(sysdate) - 3
and transaction_type = 'AccountUpdate'

)

