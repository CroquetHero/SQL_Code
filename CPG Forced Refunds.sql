select trunc(creation_date)refund_date
,payment_method_id
,payment_service_id
,division_site_id
,billing_address_country_id BillCountry
,count(transaction_id)units

from cpg_payment_transaction

where creation_date > '1/1/2018'
and transaction_type = 'Refund'
and status = 'Completed'
and substr(division_transaction_id,0,3) = 'gui'

group by trunc(creation_date)
,payment_method_id
,payment_service_id
,division_site_id
,billing_address_country_id