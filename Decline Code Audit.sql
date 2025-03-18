select (case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end) || '-' || response_code_1 || '-' || response_message Proc_code_Message
,count(transaction_id)units

from cpg_payment_transaction

where creation_date between '3/1/2018' and '4/1/2018'
and transaction_type = 'Authorize'
and status = 'Declined'

group by (case when payment_service_id like '%-%' then substr(payment_service_id,0,instr(payment_service_id,'-',1,1)-1) else payment_service_id end) || '-' || response_code_1 || '-' || response_message
