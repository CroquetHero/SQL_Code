select *

from
(
select division_order_id
,trunc(creation_date)cb_date
,payment_service_id
,payment_method_id
,response_code_1
,reference_number
,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
,dbms_random.value(1,10000000)sample_number

from cpg_payment_transaction

where creation_date > sysdate - 30
and transaction_type ='ChargeBack'
and status = 'Completed'
and division_site_id = '44687'
and payment_service_id not in ('netgiro-bms','netgiro-amex')
and response_code_1 not in ('83', '4837', 'Unauthorized','Unauthorized payment','FR4','75', '4863','F29','4841', '41','UA02')

order by sample_number

)

where rownum < 31