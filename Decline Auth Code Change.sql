select payment_service_id
,payment_method_id
,first_auth_code
,first_auth_message
,second_auth_code
,second_auth_message
,count(division_order_id)units

from
(
select payment_service_id
,payment_method_id
,response_code_1 first_auth_code
,response_message first_auth_message
,substr(custom_data,instr(custom_data,'renewAttNum=',1,1) + 12,instr(custom_data,'cardBrand=',1,1) - (instr(custom_data,'renewAttNum=',1,1) + 14))renewAttNum
,substr(custom_data,instr(custom_data,'midCategory=',1,1) + 12,instr(custom_data,'subscriptionID=',1,1) - (instr(custom_data,'midCategory=',1,1) + 14))recurring_flag
,division_order_id
,(select distinct first_value(response_code_1) over (order by transaction_id) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_id <> rpt.transaction_id and transaction_type = 'Authorize' and status = 'Declined')second_auth_code
,(select distinct first_value(response_message) over (order by transaction_id) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_id <> rpt.transaction_id and transaction_type = 'Authorize' and status = 'Declined')second_auth_message

from cpg_payment_transaction rpt

where creation_date > '12/1/2017'
and transaction_type = 'Authorize'
and status = 'Declined'
and payment_service_id in ('litle','mes','firstdata')
and payment_method_id in ('MasterCard','Visa')

)
where renewAttNum = '1'
and recurring_flag = 'recurring'
and second_auth_code is not null

group by payment_service_id
,payment_method_id
,first_auth_code
,first_auth_message
,second_auth_code
,second_auth_message
