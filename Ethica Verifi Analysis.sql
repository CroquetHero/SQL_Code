select month
,payment_method_id
,payment_service_id
,division_site_id
,transaction_type
,(case when bank_name like '%CAPITAL ONE BANK%' then 'Capital One Bank'
when bank_name like '%Capital One%' then 'Capital One Bank'
else 'Other' end)bank_name
,count(transaction_ID)units
,sum(request_money_amount)USD

from
(
select to_char(creation_date,'MM/YYYY')month
,payment_method_id
,payment_service_id
,division_site_id
,transaction_type
,(case when transaction_type in ('Settle') then 'Good'
when transaction_type in ('ChargeBackRevrs','ChargeBack') and (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Chargeback' and status = 'Completed') < (select max(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Chargeback' and status = 'Completed') then 'Bad'
else 'Good' end)PreArb_status
,(case when bank_name like '%bankName=%' then substr(bank_name, instr(bank_name, 'bankName=',1) + 9, instr(bank_name, 'len=',1) - (instr(bank_name, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' and custom_data like '%len=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, instr(custom_data, 'len=',1) - (instr(custom_data, 'bankName=',1)+ 10))
when custom_data like '%bankName=%' then substr(custom_data, instr(custom_data, 'bankName=',1) + 9, length(custom_data) - (instr(custom_data, 'bankName=',1)+ 10))
else 'No Bank' end)bank_name
,transaction_ID
        ,request_money_amount
       -- select *
from cpg_payment_transaction rpt

where creation_date > '1/1/2017'
and transaction_type in ('Settle','ChargeBack','ChargeBackRevrs')
and status in ('Completed')--,'Pending', 'New', 'Cancelled')
--and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'RFI' and payment_service_id in ('paypalExpress', 'paypalAdaptive') and status = 'New' and rownum < 2) is null
and payment_method_id in ('MasterCard', 'Visa')
and payment_service_id in ('mes','firstdata', 'litle')
and division_site_id in ('avast', 'tmamer', 'kasperus')

)
where PreArb_status = 'Good'

group by  month
,payment_method_id
,payment_service_id
,division_site_id
,transaction_type
,(case when bank_name like '%CAPITAL ONE BANK%' then 'Capital One Bank'
when bank_name like '%Capital One%' then 'Capital One Bank'
else 'Other' end)