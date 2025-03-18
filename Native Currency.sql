select request_money_currency
        ,count(transaction_id)units
        ,sum(request_money_amount)amount
        ,round(sum(decode(request_money_currency, 'USD', request_money_amount,(request_money_amount/(select rate from cpg_currency_rate ccr where trunc(ccr.effective_date) = trunc(cpt.creation_date) and to_currency = request_money_currency and base_currency = 'USD' and ccr.division_id is null and rownum < 2)))),3)usd

from cpg_payment_transaction cpt

where creation_date > sysdate - 90
and transaction_type = 'Settle'
and status = 'Completed'
and billing_address_country_id = 'NG'

group by request_money_currency

order by units desc, amount