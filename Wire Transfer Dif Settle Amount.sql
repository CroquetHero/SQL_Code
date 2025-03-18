select *

from
(
select division_order_id
,merchant_order_id
,date(cpg_creation_date)settle_date
,division_site_id
,payment_amount settle_amount
,(select distinct payment_amount from eq2admin.rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and payment_method_id = 'WireTransfer')auth_amount
,transaction_currency

from eq2admin.rcn_payment_transaction rpt

where cpg_creation_date > '2024-04-01'
and transaction_type = 'Settle'
and status = 'Completed'
and payment_method_id = 'WireTransfer'
and merchant_order_id is not null

)BD

where auth_amount <> settle_amount