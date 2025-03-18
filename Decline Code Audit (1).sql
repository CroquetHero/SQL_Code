select (case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end)processor
,response_code_1
,response_message
,(case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end) || '-' || response_code_1 || '-' || response_message Proc_code_Message
,count(transaction_id)units
--select *
from cpg_payment_transaction

where creation_date between '9/1/2019' and '11/1/2019'
and transaction_type = 'Authorize'
and status = 'Declined'
and response_code_1 = '605'
and response_message = '22053: Expired card.[54] [] [000800] [000800]'

group by (case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end)
,response_code_1
,response_message
,(case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end) || '-' || response_code_1 || '-' || response_message
