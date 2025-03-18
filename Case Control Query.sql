select reference_number
      ,division_order_id
      --,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')cb_date

from cpg_payment_transaction rpt

where creation_date > '2/1/2019'
and transaction_type = 'ChargeBack'
and status in ('Completed')
and payment_service_id in ('firstdata')--, 'adyen','litle','mes')
and payment_method_id in ('MasterCard','Visa')
and reference_number in ('5592954710')
