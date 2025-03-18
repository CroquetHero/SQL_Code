select to_char(creation_date, 'MM/YYYY')cb_month
      ,payment_service_id
      ,payment_method_id
      ,count(transaction_id)units
      
      from cpg_payment_transaction
      
      where creation_date between '9/1/2019' and '10/1/2019'
      and transaction_type = 'Settle'
      and status = 'Completed'
      and division_id <> 'netgiro'
      
      group by payment_service_id
      ,payment_method_id
      ,to_char(creation_date, 'MM/YYYY')