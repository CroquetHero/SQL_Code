define num = 1

select yesterday
    --  ,db_site_id
      ,Yest_platform
      ,yest_site_id
      ,days n
      ,round(Yest_usd,3)Yest_usd
      ,round(mean,3)mean
      ,round(sigma,3)sigma
      ,round((Yest_usd - mean)/sigma,3)ratio
              
from
(
select DB_site_ID
      ,DB_Platform
      ,avg(DB_usd)mean
      ,stddev(DB_usd)sigma
      ,count(DB_usd)days

from
(
select division_site_id DB_site_ID
      ,division_id DB_Platform
    --  ,'Day_Before'
      ,settlement_date
      ,sum(decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2)))) as DB_usd

from rcn_auth_trans rpt

where creation_date > trunc(sysdate) - '&num' - 40 
and settlement_date between trunc(sysdate) - '&num' - 31 and trunc(sysdate) - '&num' - 2
and transaction_type = 'Authorize'
and status = 'Completed'
and payment_service_id <> 'microsoftDirect'
and division_id <> 'netgiro'
--and division_site_id = 'sqenixus'
and division_site_id not in ('rimerow', 'rimeca','rimeus')
--and division_id = 'regnow'

group by division_site_id,division_id,settlement_date

order by division_site_id, settlement_date

)

group by DB_site_ID,DB_Platform
order by days desc
)Yest

right join

(
select *

from
(
select division_site_id Yest_site_ID
      ,division_id Yest_Platform
      ,trunc(sysdate) - '&num' - 1 Yesterday
     -- ,'Yesterday'
     ,count(cpg_transaction_id)units
      ,sum(decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2)))) as Yest_usd

from rcn_auth_trans rpt

where creation_date > trunc(sysdate) - '&num' - 5
and settlement_date = trunc(sysdate) - '&num' - 1
and transaction_type = 'Authorize'
and status = 'Completed'
and payment_service_id <> 'microsoftDirect'
and division_id <> 'netgiro'
--and division_site_id = 'sqenixus'
and division_site_id not in ('rimerow', 'rimeca','rimeus')
--and division_id = 'regnow'

group by division_site_id,division_id, settlement_date - '&num'

order by division_site_id

)

where Yest_usd > 10000
and units > 9
)two_day

on DB_site_ID = Yest_site_ID

where  (3*sigma + mean) < Yest_usd
and days > 5

order by Yest_usd desc