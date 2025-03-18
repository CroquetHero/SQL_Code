select day
--,auth_hour
--,PayPal_Adaptor
--,merchant_number
--,division_site_id site_id
,settle_status
,count(transaction_id)units
,sum(request_money_amount)amount
,request_money_currency currency

from
(
select trunc(creation_date)day
,to_char(creation_date, 'HH24')auth_hour
,merchant_number
,division_site_id
,(case when response_code_1 = 'Pending' then 'New Adaptor' else 'Old Adaptor' end)PayPal_Adaptor
,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is not null then 'Settled' else 'No Settle' end)settle_status
        ,transaction_ID
        ,request_money_amount
        ,request_money_currency
        ,division_order_id

      
from cpg_payment_transaction rpt

where creation_date > '10/7/2016'
and transaction_type = 'Authorize'
and status in ('Completed')
and payment_service_id in ('paypalExpress')
and payment_method_id = 'PayPalCredit'
--and response_code_1 = 'Pending'
--and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is null
and division_id = 'pacific'

)

group by  day
--,merchant_number
--,division_site_id
,settle_status
,request_money_currency
--,PayPal_Adaptor
--,auth_hour

order by day
,settle_status
