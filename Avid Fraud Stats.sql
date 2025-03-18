select day
,order_attempts
,holds
,round(holds/nullif(order_attempts,0),5) Hold_Percentage
,fraud_blocks
,round(fraud_blocks/nullif(order_attempts,0),5) fraud_block_Percentage
,fraud_rejects
,round(fraud_rejects/nullif(order_attempts,0),5) fraud_reject_rate_Overall
,round(fraud_rejects/nullif(holds,0),5) fraud_reject_rate_Held_Orders

from
(
select day
,sum(attempts)order_attempts
,sum(hold_count)holds
,sum(fraud_block)fraud_blocks
,sum(fraud_reject)fraud_rejects

from
(
select trunc(platform_order_date)day
,(select distinct first_value(return_code) over (order by platform_order_date desc) from order_attempt where order_id = oa.order_id and return_code <> '0')Disposition
,return_code
--,attempt_key
,order_id
,1 Attempts
,(case when return_code = '2018' then 1 else 0 end)hold_count
,(case when (select distinct first_value(return_code) over (order by platform_order_date desc) from order_attempt where order_id = oa.order_id and return_code <> '0') <> '4073' and (select distinct first_value(return_code) over (order by platform_order_date desc) from order_attempt where order_id = oa.order_id and return_code <> '0') between 4000 and 5000 then 1 else 0 end)fraud_block
,(case when (select distinct first_value(return_code) over (order by platform_order_date desc) from order_attempt where order_id = oa.order_id and return_code <> '0') = '4073' then 1 else 0 end)fraud_reject

from order_attempt oa

where platform_order_date > '01-sep-19'
and site_id = 'avid'
and platform_order_date = (select min(platform_order_date) from order_attempt where oa.attempt_key = attempt_key)
--and return_code = '2018'
--and order_id = '15059717910'

)

group by day

order by day

)


