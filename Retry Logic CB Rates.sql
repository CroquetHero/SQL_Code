select Bad_Auth.month
--,Bad_Auth.sub_id subscription_id
--,Bad_Auth.division_order_id Start_Order_ID
--,Comp_Auth.division_order_id End_Order_ID
,Comp_Auth.payment_service_id processor
,Comp_Auth.payment_method_id Card_Type
,distinct_order_count
,auth_count
,cb_status
,refund_status
,count(Comp_Auth.division_order_id)units

from
(
select payment_method_id
,payment_service_id
,distinct_order_count
,to_char(cpg_creation_date,'MM/YYYY')month
,substr(ref_field_1,0,instr(ref_field_1,';',1) - 1)sub_id
,division_order_id

from auth_parent_dfact apd

where creation_date > '1/1/2017'
and payment_service_id in ('mes','litle','firstdata')
and payment_method_id in ('Visa','MasterCard','AmericanExpress','Discover')
and recurring_flag = 'Sub - Auto Renewal'
--and status = 'Completed'
and first_attempt_success_flag = '0'
and recovered_flag = '1'
--and (select status from rcn_auth_trans where division_order_id = apd.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) is not null
 
 )Bad_Auth
 
left join

(
select division_order_id
,division_site_id
,payment_method_id
,payment_service_id
,substr(ref_field_1,0,instr(ref_field_1,';',1) - 1)sub_id
,(select count(cpg_transaction_id) from rcn_auth_trans where rat.division_order_id = division_order_id and transaction_type = 'Authorize' and status <> 'Completed')Auth_Count
,(case when (select status from rcn_payment_transaction where rat.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)CB_Status
,(case when (select status from rcn_payment_transaction where rat.division_order_id = division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is not null then 'Refund' else 'No Refund' end)Refund_Status

from rcn_auth_trans rat

where creation_date > sysdate - 365
and payment_service_id in ('mes','litle','firstdata')
and payment_method_id in ('Visa','MasterCard','AmericanExpress','Discover')
and status = 'Completed'

)Comp_Auth

on Comp_Auth.sub_id = Bad_Auth.sub_id

group by Bad_Auth.month
--,Bad_Auth.sub_id 
,Comp_Auth.payment_service_id 
,Comp_Auth.payment_method_id 
,distinct_order_count
,auth_count
,cb_status
,refund_status
