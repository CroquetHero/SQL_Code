select Sub_Start_Type
,division_site_id
,payment_method_id
,Auth_Date
,contract_term_code
,refund_status
,CB_status
,count(division_order_id)units

from
(
select division_order_id
,division_site_id
,payment_method_id
,Auth_Date
,contract_term_code
,subscription_id
,Sub_Start_Type
,(case when (select status from rcn_payment_transaction where division_order_id = Big_Data.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2)is not null then 'Refund' else 'No Refund'end)refund_status
,(case when (select status from rcn_payment_transaction where division_order_id = Big_Data.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2)is not null then 'CB' else 'No CB'end)CB_status

from 
(
select division_order_id
,division_site_id
,payment_method_id
,trunc(cpg_creation_date)Auth_Date
,contract_term_code
,subscription_id
,(select distinct first_value(subscription_type_code) over (order by row_FIRST_etl_dttm) from SUB_SEG_EXPIRE_DNORM where subscription_id = asf.subscription_id)Sub_Start_Type

from AUTH_STAGING_DFACT asf

where row_created_dttm between '9/1/2017' and '10/1/2017'
and division_id = 'pacific'
and ref_field_1 is not null
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_auth_trans where division_order_id = asf.division_order_id)
and subscription_type_code = 'RENEWED'
and status = 'Completed'
and subscription_segment_count = '2'

)Big_Data

)

group by Sub_Start_Type
,division_site_id
,payment_method_id
,Auth_Date
,contract_term_code
,refund_status
,CB_status
