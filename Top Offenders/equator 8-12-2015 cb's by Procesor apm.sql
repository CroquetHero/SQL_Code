select division_id
        ,division_site_id
        ,merchant_descriptor
        ,payment_processor_name
        ,sum(decode(transaction_type, 'Settle', units))sales_units
        ,sum(decode(transaction_type, 'ChargeBack', units))cb_units
        ,sum(decode(transaction_type, 'ChargeBack', units))/sum(decode(transaction_type, 'Settle', units))unit_CBR
        ,sum(decode(transaction_type, 'Settle', usd))sales_usd
        ,sum(decode(transaction_type, 'ChargeBack', usd))cb_usd
        ,sum(decode(transaction_type, 'ChargeBack', usd))/sum(decode(transaction_type, 'Settle', usd))usd_CBR
        
        from
(

select division_id
        ,division_site_id
        ,merchant_descriptor
        ,transaction_type
        ,payment_processor_name
        ,count(cpg_transaction_id)units
        ,sum(usd)usd
        
        from

(
select division_id
        ,division_site_id
        ,merchant_descriptor
        ,transaction_type
        ,payment_processor_name
        ,(case when transaction_type = 'Settle' then 'Good'
                  when creation_date = (select min(creation_date) from rcn_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Good'
                  else 'Bad' end)case_status
        ,cpg_transaction_id
        ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
        
        from rcn_payment_transaction rpt
        
        where creation_date > sysdate - 45
        and settlement_date between &&date1 and &&date2
        and transaction_type in ('Settle', 'ChargeBack')
        and status = 'Completed'
        and division_id in ('element5', 'esellerate', 'regnow', 'swreg')
        
        )
        where case_status = 'Good'
        
        group by division_id
        ,transaction_type
        ,payment_processor_name
        ,merchant_descriptor
        ,division_site_id
        
        )
        
        
        group by division_id
        ,payment_processor_name
        ,merchant_descriptor
        ,division_site_id
   
   union all
   
   select division_id
        ,'Platform Total'
        ,'null'
        ,payment_processor_name
        ,sum(decode(transaction_type, 'Settle', units))sales_units
        ,sum(decode(transaction_type, 'ChargeBack', units))cb_units
        ,sum(decode(transaction_type, 'ChargeBack', units))/sum(decode(transaction_type, 'Settle', units))unit_CBR
        ,sum(decode(transaction_type, 'Settle', usd))sales_usd
        ,sum(decode(transaction_type, 'ChargeBack', usd))cb_usd
        ,sum(decode(transaction_type, 'ChargeBack', usd))/sum(decode(transaction_type, 'Settle', usd))usd_CBR
        
        from
(

select division_id
        ,transaction_type
        ,payment_processor_name
        ,count(cpg_transaction_id)units
        ,sum(usd)usd
        
        from

(
select division_id
        ,transaction_type
        ,payment_processor_name
        ,(case when transaction_type = 'Settle' then 'Good'
                  when creation_date = (select min(creation_date) from rcn_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Good'
                  else 'Bad' end)case_status
        ,cpg_transaction_id
        ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
        
        from rcn_payment_transaction rpt
        
        where creation_date > sysdate - 45
        and settlement_date between &&date1 and &&date2
        and transaction_type in ('Settle', 'ChargeBack')
        and status = 'Completed'
        and division_id in ('element5', 'esellerate', 'regnow', 'swreg')
        
        )
        where case_status = 'Good'
        
        group by division_id
        ,transaction_type
        ,payment_processor_name
        
        )
        
        
        group by division_id
        ,payment_processor_name