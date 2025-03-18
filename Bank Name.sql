select cb_date
,bank_name
,Vertical
,rec_flag
,rev_status
,prearb_status
,count(division_order_id)units


from
(
select division_order_id
,trunc(creation_date)cb_date
,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
--,(select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')refund_date
--,payment_service_id processor
,(case when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 10))
else 'No Bank' end)bank_name
,(case when division_id in ('swreg', 'esellerate', 'regnow', 'element5') then 'MyCommerce'
when division_id = 'fatfoogoo' then 'FFG'
else 'GC' end)Vertical
,(case when (select status from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null then 'Reversal' else 'No Reversal' end)rev_status
,(case when creation_date < (select max(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'PreArb' else 'No PreArb' end)PreArb_status


from cpg_payment_transaction rpt

where creation_date between '7/1/2016' and '11/1/2016'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_method_id in ('Visa')
and payment_service_id = 'firstdata'
and response_code_1 = '83'
and creation_date = (select min(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is null
--and creation_date > (select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')

)

group by cb_date
,bank_name
,Vertical
,rev_status
,prearb_status
,rec_flag
