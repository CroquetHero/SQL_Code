select division_order_id
      ,trunc(creation_date)day
      ,(case when payment_service_id = 'paypalExpress' then 'PayPal' else payment_method_id end)payment_type
      ,(case when division_id = 'pacific' then 'GC' when division_id = 'commerce5' then 'GT' else division_id end)platform
      ,(case when customer_ip is null then 'recurring' 
        when custom_data like '%recurring%' then 'recurring'
        when (select custom_data from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like '%recurring%' then 'recurring'
        else 'No' end)recurring_flag
      ,'','','',''
      ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and rownum < 2) is not null and rpt.creation_date > (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.request_money_amount between .95*request_money_amount and 1.05*request_money_amount) then 'Refund and 2nd CB'
      when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and division_id = 'pacific' and rownum < 2) is not null then 'GC Refund'
      when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Failed' and division_id = 'pacific' and rownum < 2) is not null then 'Failed Refund'
      when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and rownum < 2) is not null then 'Refund'
      when rpt.creation_date > (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.request_money_amount between .95*request_money_amount and 1.05*request_money_amount) then '2nd Time CB'
      when rpt.creation_date > (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice', 'RFI') and status in ('New', 'Completed') and rownum < 2) then 'Ticket Retrieval Dif'
      when rpt.creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice', 'RFI') and status in ('New', 'Completed') and rownum < 2) then 'Ticket Retrieval Same'
      else 'Nothing' end)type
      ,request_money_amount amount
      
      from cpg_payment_transaction rpt
      
      where division_order_id in ('36558606400')
      and transaction_type = 'ChargeBack'
      and status = 'Completed'
      and creation_date between '1/20/2017' and sysdate
      order by division_order_id