select auth_date
,status
,division_site_id
,round(usd_payment_amount/last_amount,1)Rate_of_Change
,contract_term_code
,renewal_num
,count(division_order_id)units
--select *
from
(
select distinct division_order_id
,auth_date
,subscription_id
,status
,usd_payment_amount
,transaction_currency
,contract_term_code
, renewal_num
,last_order_id
,division_site_id
,(select bin from ereport.cpg_transactions where Big_Data.last_order_id = divisionorderid and rownum < 2)bin
,(select bank_name from rcn_payment_transaction rpt where rpt.division_order_id = last_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)bank_name
,(select distinct first_value(usd_ful_sales_amt) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where subscription_id = Big_Data.subscription_id and platform_order_id <> Big_Data.division_order_id)last_Amount

from
(
select division_order_id
,trunc(cpg_creation_date)auth_date
,subscription_id
,status
,division_site_id
,usd_payment_amount
,(select usd_ful_sales_amt from SUB_SEG_EXPIRE_DNORM where subscription_id = asf.subscription_id and platform_order_id = asf.division_order_id)payment_amount
,transaction_currency
,contract_term_code
,subscription_segment_count renewal_num
,(select min(renewattnum) from ereport.cpg_transactions where divisionorderid = asf.division_order_id)Auth_Try_attempt
,(select distinct first_value(platform_order_id) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where subscription_id = asf.subscription_id and platform_order_id <> asf.division_order_id)last_order_id

--select *

from AUTH_STAGING_DFACT asf

where row_created_dttm between '1/27/2018' and '2/1/2018'
and division_id = 'pacific'
and ref_field_1 is not null
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_auth_trans where division_order_id = asf.division_order_id)

)Big_Data

where Auth_Try_attempt = '1'

)
where last_amount is not null
and last_amount > 0
--and subscription_id = '9710109801'

group by auth_date
,status
,division_site_id
,round(usd_payment_amount/last_amount,1)
,contract_term_code
,renewal_num
