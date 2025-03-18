select to_char(settlement_date, 'MM/YYYY')month
        ,division_id
        ,sum(decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))))usd

from rcn_payment_transaction rpt

where creation_date > '1/1/2015'
and settlement_date between '5/1/2015' and '5/31/2015'
and transaction_type = 'Settle'
and status = 'Completed'
and division_id in ('element5','regnow', 'swreg','esellerate')
--and payment_method_id in ('MasterCard', 'Visa')
--and payment_service_id in ('firstdata', 'mes')
and (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null

group by to_char(settlement_date, 'MM/YYYY')
        ,division_id
        
        order by division_id