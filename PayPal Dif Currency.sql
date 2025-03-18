select *

from
(
select divisionorderid
,auth_date
,subscriptionid
,First_Order_ID
,(select distinct first_value(payment_processor_name) over (order by cpg_transaction_id) from rcn_payment_transaction where division_order_id = First_Order_ID and transaction_type = 'Settle' and status = 'Completed')first_processor
,paymentcurrency Current_Currency
,(select distinct first_value(transaction_currency) over (order by cpg_transaction_id) from rcn_payment_transaction where division_order_id = First_Order_ID and transaction_type = 'Settle' and status = 'Completed')first_currency

from
(
select distinct divisionorderid
,trunc(creationdate)auth_date
,subscriptionid
,paymentcurrency
,(select distinct first_value(platform_order_id) over (order by src_create_dttm) from sub_seg_expire_dnorm where subscriptionid = subscription_id)First_Order_ID
--select *
from ereport.cpg_transactions

where creationdate > sysdate - 10
and paymentserviceid = 'paypalExpress'
and subscriptionid is not null

)

)

where Current_Currency <> first_currency
