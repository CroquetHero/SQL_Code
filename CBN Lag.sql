select division_order_id
,merchant_order_id
,date(cpg_creation_date)cb_date
,date(order_date)settle_date
,(select min(date(cpg_creation_date)) from eq2admin.rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')Settle_date
,division_site_id
,division_id
,recurring_flag
,payment_method_id

from eq2admin.rcn_payment_transaction rpt

where cpg_creation_date > '2024-08-01'
and transaction_type = 'Refund'
and status = 'Failed'
and payment_service_id = 'slimpay'

LIMIT 99999;