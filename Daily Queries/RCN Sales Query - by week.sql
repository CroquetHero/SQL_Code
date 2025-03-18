select yesterday
    --  ,db_site_id
      ,Yest_platform
      ,yest_site_id
     -- ,days n
      ,Yest_usd
      ,DB_usd
      ,Yest_usd/DB_usd ratio
              
from

(
select division_site_id DB_site_ID
      ,division_id DB_Platform
    --  ,'Day_Before'
      ,trunc(creation_date)day
      ,sum(decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2)))) as DB_usd

from rcn_payment_transaction rpt

where creation_date between trunc(sysdate) - &&num - 8 and trunc(sysdate) - &&num - 7
and transaction_type = 'Settle'
and status = 'Completed'
and payment_service_id <> 'microsoftDirect'
and division_site_id not in ('rimerow', 'rimeca','rimeus')
and division_id not in ('netgiro')

group by division_site_id,division_id,trunc(creation_date)

)Yest

right join

(
select *

from
(
select division_site_id Yest_site_ID
      ,division_id Yest_Platform
      ,trunc(sysdate) - &&num - 1 Yesterday
      ,count(cpg_transaction_id)Yest_units
     -- ,'Yesterday'
      ,sum(decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2)))) as Yest_usd

from rcn_payment_transaction rpt

where creation_date between trunc(sysdate) - &&num - 1 and trunc(sysdate) - &&num
and transaction_type = 'Settle'
and status = 'Completed'
and payment_service_id <> 'microsoftDirect'
and division_site_id not in ('rimerow', 'rimeca','rimeus')
--and division_id = 'regnow'

group by division_site_id,division_id

)

where Yest_usd > 1000
)two_day

on DB_site_ID = Yest_site_ID

where  Yest_usd > 10000
and (Yest_usd/DB_usd) > 2
and Yest_units > 10
--and days > 5

order by Yest_usd desc