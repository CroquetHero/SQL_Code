select month
,payment_method_id
,country_code
,status
,Tenure
,count(cpg_transaction_id)units
--select *
from
(
select month
,payment_method_id
,payment_service_id
,country_code
,status
,(select count(subscription_type_code) from SUB_SEG_EXPIRE_DNORM_VW where subscription_id = BD.subscription_id and purchase_dt < cpg_creation_date and subscription_type_code not in ('TRIAL'))Tenure
,cpg_transaction_id
,subscription_id
,division_order_id
--select *
from
(
select to_char(cpg_creation_date,'MM/YYYY')month
,cpg_creation_date
,payment_method_id
,payment_service_id
,country_code
,status
,rank() over (partition by division_order_id order by cpg_transaction_id)cpg_attempt
,cpg_transaction_id
,division_order_id
,(select min(subscription_id) from SUB_SEG_EXPIRE_DNORM_VW where division_order_id = platform_order_id)subscription_id

from rcn_auth_trans rpt

where creation_date > '11/1/2018'
and transaction_type = 'Authorize'
--and status in ('Declined','Completed')
and division_site_id = 'avast'
--and payment_service_id in ('mes','firstdata','litle')
and payment_method_id in ('MasterCard','Visa','Discover','AmericanExpress')

)BD

where cpg_attempt = '1'
and status in ('Completed','Declined')

)

where tenure between 0 and 2

group by month
,payment_method_id
,country_code
,status
,Tenure
