select processor
,bank_name
,response_code_1
,(prearb_date - cb_date)lag
,count(division_order_id)units

from
(
select division_order_id
,payment_service_id processor
,division_site_id
,response_code_1
,(case when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 10))
else 'No Bank' end)bank_name
,trunc(creation_date)PreArb_Date
,(select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')cb_date
,(case when payment_service_id = 'mes' and secondary_number = 'N' then 'PreArb'
when payment_service_id = 'litle' and response_code_3 = 'ARBITRATION_CHARGEBACK' then 'PreArb'
when payment_service_id = 'firstdata' and (instr(custom_data,'Record Type=',1)) - (instr(custom_data,'Second Chargeback Date=',1)+23) > 1 then 'PreArb'
else '1st Time' end)PreArb_status

from cpg_payment_transaction rpt

where creation_date > '1/1/2016'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id in ('firstdata','litle','mes')
and payment_method_id in ('Visa','MasterCard')
--and response_code_1 = '4831'
and trunc(creation_date) > (select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
--and division_site_id in ('avast', 'kasperus', 'tmamer')

)

where PreArb_status = 'PreArb'

group by (prearb_date - cb_date)
,processor
,bank_name
,response_code_1

order by lag
