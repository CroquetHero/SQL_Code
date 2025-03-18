select to_char(creation_date,'MM/DD/YYYY HH24:MI')time
,payment_service_id
,count(transaction_id)units

from cpg_payment_transaction

where creation_date > trunc(sysdate) - 1
and transaction_type = 'Authorize'
--and payment_service_id in ('netgiro-bnp','adyen','netgiro-bms')
and billing_address_country_id = 'FR'
and request_money_currency = 'EUR'
and payment_method_id in ('Visa','MasterCard')
and division_site_id = 'avast'

group by to_char(creation_date,'MM/DD/YYYY HH24:MI')
,payment_service_id

order by time
