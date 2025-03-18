select lag
      ,count(division_order_id)units
      
      from
(
select (select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed') - trunc(creation_date) lag
      ,trunc(creation_date)cbn_date
      ,division_order_id
      ,status

from cpg_payment_transaction rpt

where creation_date > sysdate - 180
and transaction_type = 'ChargeBackNotice'
and response_code_2 = 'CB Credit Notice'
and payment_service_id = 'netgiro-bnp'
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackNotice' and response_code_2 = 'CB Credit Notice')

)

group by lag

order by lag