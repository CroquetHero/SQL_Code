select division_order_id
,auth_date
,status
,division_site_id
,payment_method_id
,merchant_descriptor
,merchant_contact
,second_processor
,(select payment_service_id from cpg_payment_transaction where min_transaction_id = transaction_id)first_processor
,recurring_flag
,AVS second_AVS
,CVV2 second_CVV2
,(select response_code_2 from cpg_payment_transaction where min_transaction_id = transaction_id)first_AVS
,(select response_code_3 from cpg_payment_transaction where min_transaction_id = transaction_id)first_CVV2
,(case when (exp_date - auth_date) < 0 and substr(exp_date,0,2) <> substr(auth_date,0,2) then 'Expired' else 'Valid' end)card_status
,(case when Samsung_auth_status = 'Non_Samsung' then 'Non_Samsung'
when Samsung_auth_status = 'Validation Auth' then 'Both Validation Auths'
when (select request_money_amount from cpg_payment_transaction where min_transaction_id = transaction_id) = '0' then 'First Validation/Second Real Auth'
else 'Both Real Auths' end)Samsung_auth_status
,bank_name
,sample_number

from 
(
select division_order_id
,transaction_id
,(select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize')min_transaction_id
,trunc(creation_date)auth_date
,status
,division_site_id
,payment_method_id
,merchant_descriptor
,merchant_contact
,payment_service_id second_processor
,substr(custom_data, instr(custom_data,'midCategory=',1,1)+12,instr(custom_data,chr(10),instr(custom_data,'midCategory=',1,1),1) - (instr(custom_data,'midCategory=',1,1)+12))recurring_flag
,response_code_2 AVS
,response_code_3 CVV2
,to_date((case when substr(expiration_date,0,1) = '0' then substr(expiration_date,2,1) else substr(expiration_date,0,2) end) || '/1/' || '20' || substr(expiration_date,3,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')exp_date
,(case when division_site_id not in ('samsung','samsung2') then 'Non_Samsung'
when division_site_id in ('samsung','samsung2') and request_money_amount = '0' then 'Validation Auth'
else 'Real Auth' end)Samsung_auth_status
,rank() over (partition by division_order_id order by transaction_id)cpg_attempt
,substr(custom_data, instr(custom_data,'bankName=',1,1)+9,instr(custom_data,chr(10),instr(custom_data,'bankName=',1,1),1) - (instr(custom_data,'bankName=',1,1)+9))bank_name
,dbms_random.value(1,10000000)sample_number
--select *
from cpg_payment_transaction rpt

where creation_date > '12/10/2018'
and transaction_type = 'Authorize'
and status in ('Declined','Completed','Failed')
and division_id = 'pacific'
and payment_method_id in ('MasterCard','Visa')
and payment_service_id in ('pagador')
and expiration_date is not null
and expiration_date not in ('0000')
--and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize')
--and division_site_id = 'samsung2'
and division_order_id not like '%OrderID%'
and division_order_id not like '%-%'

order by sample_number
)BD

where rownum < 1001
and cpg_attempt = 1
and payment_method_id = (select payment_method_id from cpg_payment_transaction where min_transaction_id = transaction_id)
--and (select payment_service_id from cpg_payment_transaction where min_transaction_id = transaction_id) in ('mes','litle','firstdata')
