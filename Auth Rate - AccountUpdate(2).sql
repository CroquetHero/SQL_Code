select auth_date
,division_site_id
,payment_service_id
,payment_method_id
,status
,Account_Update_message
,Account_Update_Status
,recurring_flag
,count(division_order_id)units

from
(
select division_order_id
,trunc(creation_date)auth_date
,division_site_id
,payment_service_id
,payment_method_id
,status
,substr(custom_data,instr(custom_data,'renewAttNum=',1,1) + length('renewAttNum='),(instr(custom_data,chr(10),instr(custom_data,'renewAttNum=',1,1),1)) - (instr(custom_data,'renewAttNum=',1,1) + length('renewAttNum=')))renewAttNum
,substr(custom_data,instr(custom_data,'midCategory=',1,1) + length('midCategory='),(instr(custom_data,chr(10),instr(custom_data,'midCategory=',1,1),1)) - (instr(custom_data,'midCategory=',1,1) + length('midCategory=')))recurring_flag
,substr(custom_data,instr(custom_data,'countryID=',1,1) + length('countryID='),(instr(custom_data,chr(10),instr(custom_data,'countryID=',1,1),1)) - (instr(custom_data,'countryID=',1,1) + length('countryID=')))Issuer_Country
,custom_data
,(select distinct first_value(response_message) over (order by transaction_id desc)AccountUpdate_Date from cpg_payment_transaction where account_token = rpt.account_token and transaction_id < rpt.transaction_id and transaction_type = 'AccountUpdate')Account_Update_message
,(select distinct first_value(status) over (order by transaction_id desc)AccountUpdate_Date from cpg_payment_transaction where account_token = rpt.account_token and transaction_id < rpt.transaction_id and transaction_type = 'AccountUpdate')Account_Update_Status
,(select distinct first_value(trunc(creation_date)) over (order by transaction_id desc)AccountUpdate_Date from cpg_payment_transaction where account_token = rpt.account_token and transaction_id < rpt.transaction_id and transaction_type = 'AccountUpdate')Account_Update_Date

from cpg_payment_transaction rpt

where creation_date between '9/15/2018' and '9/20/2018'
and transaction_type = 'Authorize'
and payment_method_id in ('Visa','MasterCard')
and division_id = 'pacific'
and division_site_id in ('avast','tmamer','kasperus','kasper','avgstore')
and division_order_id not like '%OrderID%'
and transaction_id = (select distinct first_value(transaction_id) over (order by transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize')

)

where renewAttNum = '1'
and recurring_flag is not null
and Issuer_Country = 'US'

group by auth_date
,division_site_id
,payment_service_id
,payment_method_id
,status
,Account_Update_message
,Account_Update_Status
,recurring_flag
