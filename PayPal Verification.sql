select substr(custom_data,instr(custom_data,'payerStatus=')+12,instr(custom_data,'verified') - instr(custom_data,'payerStatus=') - 4)verification
      ,count(division_order_id)units
      ,sum(request_money_amount)amount
      ,request_money_currency

from cpg_payment_transaction rpt

where transaction_type = 'Authorize'
and status = 'Completed'
and division_order_id in 

(
select distinct division_order_id

from cpg_payment_transaction rpt

where creation_date > '01-jan-15'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id in ('paypalExpress', 'paypalAdaptive')
and response_code_1 = 'Unauthorized'

)

and cid is not null

group by 
substr(custom_data,instr(custom_data,'payerStatus=')+12,instr(custom_data,'verified') - instr(custom_data,'payerStatus=') - 4)
,request_money_currency
