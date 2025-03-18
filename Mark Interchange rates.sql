select division_order_id
,substr(custom_data, instr(custom_data,'midCategory=',1,1)+length('midCategory='),(instr(custom_data,chr(10),instr(custom_data,'midCategory=',1,1),1)) - (instr(custom_data,'midCategory=',1,1)+length('midCategory=')))MIdCategory
,substr(custom_data, instr(custom_data,'cardUsage=',1,1)+length('cardUsage='),(instr(custom_data,chr(10),instr(custom_data,'cardUsage=',1,1),1)) - (instr(custom_data,'cardUsage=',1,1)+length('cardUsage=')))cardUsage
,substr(custom_data, instr(custom_data,'cardCategory=',1,1)+length('cardCategory='),(instr(custom_data,chr(10),instr(custom_data,'cardCategory=',1,1),1)) - (instr(custom_data,'cardCategory=',1,1)+length('cardCategory=')))cardCategory
,substr(custom_data, instr(custom_data,'fundingSource=',1,1)+length('fundingSource='),(instr(custom_data,chr(10),instr(custom_data,'fundingSource=',1,1),1)) - (instr(custom_data,'fundingSource=',1,1)+length('fundingSource=')))fundingSource
,substr(custom_data, instr(custom_data,'bankName=',1,1)+length('bankName='),(instr(custom_data,chr(10),instr(custom_data,'bankName=',1,1),1)) - (instr(custom_data,'bankName=',1,1)+length('bankName=')))bankName
,expiration_date
,(case when cast(substr(expiration_date,3,2) as int) > cast(substr(trunc(creation_date),9,2) as int) then 'Valid'
when cast(substr(expiration_date,3,2) as int) < cast(substr(trunc(creation_date),9,2) as int) then 'Expired'
when cast(substr(trunc(creation_date),0,2) as int) < cast((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) as int) then 'Valid'
when cast(substr(trunc(creation_date),0,2) as int) > cast((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) as int) then 'Expired'
when cast(substr(trunc(creation_date),0,2) as int) = cast((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) as int) then 'Valid'
else 'Other' end)Expired_Bool
,request_money_currency
,division_site_id
,status
,(case when (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and request_money_amount > 1) is not null then 'Completed' else 'Not Completed' end)Comp_Bool
,payment_service_id
,substr(custom_data, instr(custom_data,'countryID=',1,1)+length('countryID='),(instr(custom_data,chr(10),instr(custom_data,'countryID=',1,1),1)) - (instr(custom_data,'countryID=',1,1)+length('countryID=')))Issuer_Country
,billing_address_country_id BillingCountry
,request_money_amount
,'USD'
,trunc(creation_date)creation_date
,response_code_2 AVS
,billing_address_line_1
,billing_address_line_2
,billing_address_city
,billing_address_state
,billing_address_postal_code
,round(((select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') - creation_date),3)days_to_settle
--select *
from cpg_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type = 'Authorize'
and payment_service_id = 'adyen'
and request_money_amount > 1
and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and request_money_amount > 1)
