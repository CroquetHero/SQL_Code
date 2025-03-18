select day
        ,count(transaction_id)units
        
        from 
        (
        
      select trunc(creation_date) + 1 day
      ,transaction_id
      ,division_order_id
      ,payment_service_id
      ,transaction_type
      ,request_money_amount
      ,request_money_currency
      ,(case when payment_service_id = 'microsoftDirect' then 'Skip' when transaction_type = 'ChargeBack' and creation_date > (select min(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Skip' else 'Good' end)cb_status

from cpg_payment_transaction rpt

where creation_date > sysdate - 20
and trunc(creation_date) + 1 = '7/19/2015'
and transaction_type in ('RFI', 'ChargeBackNotice', 'ChargeBack')
and status in ('New', 'Completed', 'Pending')
and division_id = 'pacific'

)

where cb_status = 'Good'

group by day

order by day