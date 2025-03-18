select authorization_code
      ,division_order_id
      --,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')cb_date

from cpg_payment_transaction rpt

where creation_date > '2/1/2017'
and transaction_type = 'ChargeBack'
and status in ('Completed')
and payment_service_id in ('firstdata', 'mes')
and payment_method_id in ('Discover')
and authorization_code in ('5592954710')
