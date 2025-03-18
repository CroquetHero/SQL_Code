select *

from
(
select division_order_id
,payment_service_id
,payment_method_id
,division_site_id
,trunc(creation_date)cb_date
,(case when payment_service_id in ('mes', 'litle') then (select reference_number from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed' and request_money_amount > 0 and rownum < 2)
when payment_service_id = 'firstdata' then substr(custom_data, instr(custom_data,'Transaction Reference=',1)+22,23)
else '0' end)ARN
--,custom_data
,dbms_random.value(1,10000000)sample_number
--select *
from cpg_payment_transaction rpt

where creation_date > '1/1/2017'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and bank_name like '%CAPITAL%'
and payment_service_id in ('litle', 'mes', 'firstdata')

order by sample_number

)

where rownum < 31