select (case when settle_month > expired_month then 'Expired'
                   when settle_month = expired_month then 'Expiring'
                   else 'Good' end)card_status
         ,settle_month
         ,expired_month
         ,site_ID
          ,payment_method_id
          ,payment_service_id
          ,status
          ,count(request_money_amount)units
      --    ,sum(request_money_amount)usd
        --  ,request_money_currency
         
         from
(
select division_site_id
          ,(select distinct first_value(division_site_id) over (order by creation_date desc) from cpg_payment_transaction where account_token = cpt.account_token and transaction_type <> 'AccountUpdate')site_ID
          ,payment_method_id
          ,payment_service_id
          ,request_money_amount
          ,request_money_currency
          ,to_char(creation_date,'MM/YYYY')settle_month
          ,status
          ,account_token
          ,division_order_id
          ,substr(expiration_date,0,2)month
          ,substr(expiration_date,3,2)year
          ,substr(expiration_date,0,2) | | '/'| | '20' | | substr(expiration_date,3,2) expired_month

from cpg_payment_transaction cpt

where creation_date between '5/3/2015' and '5/5/2015'
and transaction_type = 'AccountUpdate'

)

group by  (case when settle_month > expired_month then 'Expired'
                   when settle_month = expired_month then 'Expiring'
                   else 'Good' end)
         ,settle_month
         ,expired_month
         ,site_ID
          ,payment_method_id
          ,payment_service_id
          ,status
        --  ,request_money_currency