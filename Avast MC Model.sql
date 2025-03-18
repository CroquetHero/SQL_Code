select day
,transaction_type
,payment_service_id
,payment_method_id
,Site_ID
,count(transaction_id)units

from
(
select trunc(creation_date)day
,transaction_type
,payment_service_id
,payment_method_id
,(case when division_site_id = 'avast' then 'Avast' else 'Other' end)Site_ID
,(case when transaction_type = 'Settle' then 'Good'
when transaction_type = 'ChargeBack' and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Good'
else 'Ignore' end)status
,transaction_id

from cpg_payment_transaction rpt

where creation_date between '10/1/2018' and '10/10/2018'
and transaction_type in ('ChargeBack','Settle')
and status = 'Completed'
and payment_service_id in ('firstdata','adyen','mes','litle')--,'litle','mes')
and payment_method_id in ('Visa','MasterCard')

)

where status <> 'Ignore'

group by day
,transaction_type
,payment_service_id
,payment_method_id
,Site_ID