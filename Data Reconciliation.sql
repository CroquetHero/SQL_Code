select division_order_id
      ,trunc(cpg_creation_date)cb_date
      ,(case when payment_service_id = 'paypalExpress' then 'PayPal' else payment_method_id end)payment_type
      ,(case when division_id = 'pacific' then 'GC' when division_id = 'commerce5' then 'GT' else division_id end)platform
      ,(case when customer_ip is null then 'recurring' 
        when recurring_flag = 'recurring' then 'recurring' 
        when (select recurring_flag from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) = 'recurring' then 'recurring'
        else 'No' end)recurring_flag
      ,'','',''
      ,(case when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and rownum < 2) is not null and rpt.settlement_date > (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount) then 'Refund and 2nd CB'
      when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and division_id = 'pacific' and rownum < 2) is not null then 'GC Refund'
      when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Failed' and division_id = 'pacific' and rownum < 2) is not null then 'Failed Refund'
      when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and rownum < 2) is not null then 'Refund'
      when rpt.settlement_date > (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount) and (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null  then '2nd Time CB'
      when rpt.settlement_date > (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice', 'RFI') and status in ('New', 'Completed') and rownum < 2) then 'Ticket Retrieval Dif'
      when rpt.settlement_date = (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice', 'RFI') and status in ('New', 'Completed') and rownum < 2) then 'Ticket Retrieval Same'
      else 'Nothing' end)type
      ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
      
      
      from rcn_payment_transaction rpt
      
      where division_order_id in ('34646167262')
      and transaction_type = 'ChargeBack'
      and status = 'Completed'
      and settlement_date between '3/20/2018' and sysdate
      order by division_order_id
      