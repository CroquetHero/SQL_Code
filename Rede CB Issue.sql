select division_order_id
#,division_site_id
#,settle_amount
#,cb_amount
#,rev_amount
,round(settle_amount + coalesce(rev_amount,0) - cb_amount,2)amount
,transaction_currency currency 
,cb_code response_code_1
,(select distinct response_message from eq2admin.rcn_payment_transaction where division_order_id = BD2.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and response_code = cb_code)response_message

from
(
select division_order_id
#,cb_date
,division_site_id
,settle_amount
,cb_amount
,rev_amount
,transaction_currency
,min(response_code)cb_code
,payment_service_id

from
(
select division_order_id
,date(cpg_creation_date)cb_date
,division_site_id
,(select sum(payment_amount) from eq2admin.rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')settle_amount
,(select sum(payment_amount) from eq2admin.rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')CB_amount
,(select sum(payment_amount) from eq2admin.rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed')rev_amount
,transaction_currency
,response_code
,payment_service_id


from eq2admin.rcn_payment_transaction rpt

where cpg_creation_date > '2024-12-01'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id = 'drwp-rede'
#and division_order_id = '1133853644339'
and cpg_creation_date = (select min(cpg_creation_date) from eq2admin.rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')

)BD

group by division_order_id
#,cb_date
,division_site_id
,settle_amount
,transaction_currency
,rev_amount
,cb_amount
,payment_service_id

)BD2

where round(settle_amount + coalesce(rev_amount,0) - cb_amount,2) <> 0