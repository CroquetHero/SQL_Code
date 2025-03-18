select day
,transaction_type
,payment_method_id
,payment_processor_name
,division_site_id
,recurring_flag
,recent_order_type
,count(division_order_id)units

from
(
select day
,transaction_type
,payment_method_id
,payment_processor_name
,division_site_id
,recurring_flag
,(select distinct first_value(subscription_type_code) over (order by src_create_dttm) from SUB_SEG_EXPIRE_DNORM where BD.sub_ID = subscription_id)recent_order_type
,division_order_id

from
(
select trunc(cpg_creation_date)day
,transaction_type
,payment_method_id
,payment_processor_name
,division_site_id
,recurring_flag
,(select min(subscription_id) from SUB_SEG_EXPIRE_DNORM where rpt.division_order_id = platform_order_id)sub_ID
,division_order_id

from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type in ('Settle','ChargeBack')
and status = 'Completed'
and division_site_id in ('avast','avgstore','avastjp','avastbr','nds_avst','avgbr','avgb2b')

)BD

)

group by day
,transaction_type
,payment_method_id
,payment_processor_name
,division_site_id
,recurring_flag
,recent_order_type
