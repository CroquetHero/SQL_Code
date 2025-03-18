select trans_date
,settle_date
,transaction_type
,status
,payment_service_id
,payment_method_id
,count(transaction_id)units

from
(
select trunc(creation_date)trans_date
,trunc(order_date)settle_date
,transaction_type
,status
,payment_service_id
,payment_method_id
,transaction_id
,(case when transaction_type = 'Settle' then 'Good'
when transaction_type in ('ChargeBackNotice','ChargeBack') and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice','ChargeBack')) then 'Good'
else 'Ignore' end)trans_status

from cpg_payment_transaction rpt

where creation_date > '12/12/2018'
and order_date > '12/12/2018'
and transaction_type in ('Settle','ChargeBackNotice','ChargeBack')
and status in ('Completed','New','Cancelled','Pending')
and payment_service_id in ('adyen','netgiro-bms')
and payment_method_id in ('MasterCard','Visa')
and billing_address_country_id <> 'FR'
and request_money_currency = 'EUR'
and division_site_id in ('avast','kasper','kasperde')

)

where trans_status <> 'Ignore'

group by trans_date
,settle_date
,transaction_type
,status
,payment_service_id
,payment_method_id