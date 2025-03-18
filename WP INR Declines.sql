select distinct date(cpg_creation_date)auth_date
,division_order_id
,merchant_order_id
,cpg_transaction_id
,division_site_id
,recurring_flag
,response_message

from eq2admin.rcn_auth_trans rpt

where cpg_creation_date > '2024-03-10'
and transaction_type = 'Authorize'
and status = 'Declined'
and payment_service_id in ('worldpay')
and transaction_currency = 'INR'
and (select distinct status from eq2admin.rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and payment_service_id = 'adyen') is not null
