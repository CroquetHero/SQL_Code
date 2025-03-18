select payment_service_id
        ,payment_method_id
        ,division_site_id
     --   ,division_order_id
    --    ,(select min(creation_date) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') - creation_date difference
        ,((select min(creation_date) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') - creation_date)hours
        ,transaction_id

from cpg_payment_transaction cpt

where creation_date > '8/1/2017'
and transaction_type = 'Authorize'
and status = 'Completed'
and division_id = 'pacific'
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed')
and (select status from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is not null

group by payment_service_id
        ,payment_method_id
        ,division_site_id
        