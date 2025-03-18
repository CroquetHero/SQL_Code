select trunc(cpg_creation_date)auth_date
        ,bank_name
        ,count(cpg_transaction_id)units
--select *
from rcn_auth_trans

where creation_date > sysdate - 120
and cpg_creation_date > sysdate - 120
and transaction_type = 'Authorize'
and status in ('Declined')
and division_site_id in ('kasperbr','avastbr')
and payment_plan_code = '3_months'
and payment_processor_name in ('netgiro-br')
--and payment_plan_code = '3_months'
and response_message like '%27033%'

group by trunc(cpg_creation_date)
        ,bank_name