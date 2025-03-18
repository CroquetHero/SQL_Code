select payment_service_id
        ,payment_method_id
        ,response_code_1,''
        ,count(transaction_id)units

from cpg_payment_transaction rpt

where creation_date between '7/1/2017' and '8/1/2017'
and transaction_type = 'ChargeBack'
and status in ('Completed')


group by  payment_service_id
        ,payment_method_id
        ,response_code_1

order by payment_method_id
              ,payment_service_id
              ,response_code_1