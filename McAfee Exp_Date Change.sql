select bank_Name
,(New_exp_date - exp_date)Exp_Day_Change
,AccountUpdate_Result
,sum(units)units

from
(
select bank_name
,to_date((case when substr(Updated_EXP_Date,0,1) = '0' then substr(Updated_EXP_Date,2,1) else substr(Updated_EXP_Date,0,2) end) || '/1/' || '20' || substr(Updated_EXP_Date,3,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')New_exp_date
,exp_date
,AccountUpdate_Result
,count(division_order_id)units

from
(
select (case when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 10))
else 'No Bank' end)bank_name
,division_order_id
,to_date((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) || '/1/' || '20' || substr(expiration_date,3,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')exp_date
,(select distinct first_value(expiration_date) over (order by creation_date) from cpg_payment_transaction where account_token = cpt.account_token and transaction_type = 'AccountUpdate')Updated_EXP_Date
,(select distinct first_value(status) over (order by creation_date) from cpg_payment_transaction where account_token = cpt.account_token and transaction_type = 'AccountUpdate')AccountUpdate_Result

from cpg_payment_transaction cpt

where creation_date > sysdate - 40
and transaction_type = 'Authorize'
and status in ('Declined', 'Completed')
and transaction_type = 'Authorize'
and division_site_id in ('mfeus','mfeap','mfejp','mfeeu')
and test_mode = 12
and (select status from cpg_payment_transaction where account_token = cpt.account_token and transaction_type = 'AccountUpdate' and rownum < 2) is not null
and length(expiration_date) = 4
and creation_date = (select distinct first_value(creation_date) over (order by transaction_id) from cpg_payment_transaction where division_order_id = cpt.division_order_id and division_site_id = cpt.division_site_id)

)

group by bank_name
,to_date((case when substr(Updated_EXP_Date,0,1) = '0' then substr(Updated_EXP_Date,2,1) else substr(Updated_EXP_Date,0,2) end) || '/1/' || '20' || substr(Updated_EXP_Date,3,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')
,exp_date
,AccountUpdate_Result

)

group by bank_Name
,(New_exp_date - exp_date)
,AccountUpdate_Result