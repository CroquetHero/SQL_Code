select *

from
(
select division_order_id
        ,settle_date
        ,site_id
        ,processor
        ,card_type
        ,amount
        ,currency
        ,(case when substr(replace(bank_country,  ' ', ''),length(bank_country), 1) = 'b' then 'Blank'
                  when substr(bank_name, 0, 3) = 'cor' then 'Blank'
                  when substr(bank_name, 0, 3) = 'len' then 'Blank'
                  when bank_name = 'JPMorgan' then 'Blank'
                  when billing_address_country_id <> bank_country then 'MissMatch' 
                  when billing_address_country_id = bank_country then 'Match'
                  else 'Other' end)country_Match
                  
                  from
(
select division_order_id
        ,division_site_id site_id
        ,trunc(creation_date)settle_date
        ,payment_service_id processor
        ,payment_method_id card_type
        ,request_money_amount amount
        ,request_money_currency currency
        ,billing_address_country_id
        ,substr(bank_name,instr(bank_name, 'countryID=', 1) + 10 , 2)bank_country
        ,bank_name

from cpg_payment_transaction

where creation_date > sysdate - 5
and transaction_type = 'Settle'
and status = 'Completed'
and division_id <> 'netgiro'
and payment_service_id not in ('paypalExpress')
and payment_method_id not in ('OnlineBanking')
and bank_name is not null
and custom_data not like '%recurring%' 
and custom_data not like '%Recurring%'

)

)

where country_Match <> 'Match'


