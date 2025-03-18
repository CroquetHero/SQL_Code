select division_order_id
,account_token
,sub_ID
,payment_method_id
,division_site_id
,Orig_ID
,subscription_type_code
,(case when (select count(cpg_transaction_id) from rcn_auth_trans where account_token = BD.account_token and transaction_type = 'Authorize' and status not in ('Declined','Failed') and cpg_creation_date between Orig_Auth_Date and Orig_Auth_DatePlus) > 1 then 'UpSell' 
when (select count(cpg_transaction_id) from rcn_auth_trans where account_token = BD.account_token and transaction_type = 'Authorize' and status not in ('Declined','Failed') and cpg_creation_date between Orig_Auth_DateMinus and Orig_Auth_Date) > 1 then 'UpSell'
else 'Single Order' end)order_type

from
(
select division_order_id
,account_token
,sub_ID
,payment_method_id
,division_site_id
,Orig_ID
,subscription_type_code
,Orig_Auth_Date 
,Orig_Auth_Date + interval '5' minute Orig_Auth_DatePlus
,Orig_Auth_Date - interval '5' minute Orig_Auth_DateMinus

from
(
select division_order_id
,account_token
,sub_ID
,payment_method_id
,division_site_id
,Orig_ID
,subscription_type_code
,(select distinct first_value(cpg_creation_date) over (order by cpg_transaction_id) from rcn_auth_trans where division_order_id = Orig_ID)Orig_Auth_Date

from

(
select division_order_id
,account_token
,sub_ID
,payment_method_id
,division_site_id
,(select distinct first_value(platform_order_id) over (order by src_create_dttm) from SUB_SEG_EXPIRE_DNORM where sub_id = subscription_id and subscription_type_code in ('ORIGINAL','TRIAL'))Orig_ID
,(select distinct first_value(subscription_type_code) over (order by src_create_dttm) from SUB_SEG_EXPIRE_DNORM where sub_id = subscription_id and subscription_type_code in ('ORIGINAL','TRIAL'))subscription_type_code

from
(
select division_order_id
,account_token
,substr(ref_field_1,0,instr(ref_field_1,';',1,1)-1)sub_ID
,payment_method_id
,division_site_id
,dbms_random.value(1,10000000)sample_number

--select *
from rcn_payment_transaction rpt

where creation_date > '11/1/2018'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and division_site_id in ('avast','avastbr','avgstore')
and ref_field_1 is not null

order by sample_number
)

where rownum < 2001

)

)

where Orig_Auth_Date is not null

)BD

where rownum < 1001
