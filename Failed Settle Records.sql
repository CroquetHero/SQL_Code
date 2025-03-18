select division_order_id
,payment_service_id
,payment_method_id
,division_site_id
,response_code_1
,response_message

from cpg_payment_transaction rpt

where creation_date > '9/1/2018'
and transaction_type = 'Settle'
and status = 'Failed'
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) is not null
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is null
and payment_service_id <> 'paypalExpress'
and payment_method_id in ('MasterCard','Visa','AmericanExpress','Discover')
