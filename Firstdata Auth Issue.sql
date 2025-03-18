select trunc(cpg_creation_date)auth_date
        ,division_id
        ,count(cpg_transaction_id)units

from rcn_auth_trans rpt

where creation_date between sysdate - 60 and  sysdate
and transaction_type = 'Authorize'
and status = 'Declined'
and payment_processor_name = 'firstdata'
and payment_method_id in ('MasterCard')
and division_id not in ('sap' ,'directresponse','netgiro')
and cpg_creation_date = (select min(cpg_creation_date) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Declined')
and payment_id = (select min(payment_id) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Declined')

group by trunc(cpg_creation_date),division_id

order by division_id,auth_date