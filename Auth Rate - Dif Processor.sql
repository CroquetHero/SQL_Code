select count(division_order_id)units

from
(
select division_order_id
,Prev_Order_ID
,division_site_id
,Subscription_id
,payment_service_id Processor
,(select payment_service_id from rcn_payment_transaction where data1.Prev_Order_ID = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)Prev_Processor
,payment_method_id
,status

from
(
select division_order_id
,substr(ref_field_1,0,instr(ref_field_1,';',1,1) - 1)Subscription_id
,payment_service_id
,(select distinct first_value(platform_order_id) over (order by src_create_dttm desc) from sub_seg_expiring_sfact where substr(ref_field_1,0,instr(rat.ref_field_1,';',1,1) - 1) = subscription_id and platform_order_id <> division_order_id)Prev_Order_ID
,(select distinct first_value(platform_order_id) over (order by src_create_dttm) from sub_seg_expiring_sfact where substr(ref_field_1,0,instr(rat.ref_field_1,';',1,1) - 1) = subscription_id and platform_order_id <> division_order_id)Orig_Order_ID
,payment_method_id
,status
,division_site_id
,(select min(renewattnum) from ereport.cpg_transactions where divisionorderid = rat.division_order_id)Auth_Try_attempt

--select *
from rcn_auth_trans rat

where creation_date > '4/1/2018'
and cpg_creation_date between '4/1/2018' and '4/2/2018'
and payment_method_id in ('Visa','MasterCard')
and payment_service_id in ('litle','mes','firstdata')
and division_id = 'pacific'
and status in ('Declined','Completed')
--and division_site_id = 'kasperus'
and ref_field_1 is not null
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_auth_trans where division_order_id = rat.division_order_id and status in ('Declined','Completed'))

)data1
where auth_try_attempt = '1'

)

group by Processor
,prev_processor
,(case when processor = prev_processor then 'Same' else 'Different' end)
,payment_method_id
,status
,division_site_id
