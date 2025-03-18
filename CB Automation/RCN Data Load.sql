select trunc(creation_date)day,transaction_type, count(cpg_transaction_id) as Units

from rcn_payment_transaction

where creation_date between sysdate - 7 and sysdate
--and settlement_date = '12/13/2018'
and transaction_type in ('Settle','ChargeBack')
and status = 'Completed'
--and division_site_id = 'flickr'
--and recurring_flag = 'firstRecurring'
--and payment_method_id in ('AmericanExpress')
--and payment_processor_name in ('paymentech', 'firstdata', 'mes')
--and to_char(creation_date, 'D') = '1'

group by trunc(creation_date),transaction_type

order by transaction_type,day