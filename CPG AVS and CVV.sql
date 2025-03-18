select reference_number
,division_order_id
,division_site_id
,trunc(creation_date)cb_date
,request_money_amount
,(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)AVS_Code
,(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)CVV2_Code
,(case when (select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null then 'Represented' else 'No Representment' end)rep_status

from cpg_payment_transaction rpt

where creation_date between '1/1/2017' and '4/1/2017'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id = 'mes'
and request_money_amount > 300
and division_site_id = 'samsung'
and response_code_1 = '4837'