select month
,payment_method_id
,transaction_type
,country_code
,Checkout_status
,tenure
,count(division_order_id)units

from
(
select month
,payment_method_id
,transaction_type
,country_code
,Checkout_status
,division_order_id
,(select count(subscription_type_code) from SUB_SEG_EXPIRE_DNORM_VW where subscription_id = BD.subscription_id)Tenure

from
(
select to_char(cpg_creation_date, 'MM/YYYY')month
,payment_method_id
,transaction_type
,country_code
,division_order_id
--,substr(ref_field_1,0,instr(ref_field_1,';',1,1)-1)subscription_id
,(select min(subscription_id) from SUB_SEG_EXPIRE_DNORM_VW where division_order_id = platform_order_id)subscription_id
,(case when (select bill_to_address_line1_text from CUSTOMER_DIM_VW where division_order_id = order_number and bill_to_address_line1_text = '.') is not null then 'Limited' else 'Other' end)Checkout_status
,(case when transaction_type = 'Settle' then 'Good'
when transaction_type = 'ChargeBack' and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Good'
else 'Ignore' end)trans_status

from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type in ('Settle','ChargeBack')
and status = 'Completed'
and division_site_id = 'avast'
and payment_method_id in ('MasterCard','Visa','Discover','AmericanExpress')

)BD

where trans_status <> 'Ignore'

)

where tenure in ('1','2')

group by month
,payment_method_id
,transaction_type
,country_code
,Checkout_status
,tenure