select day
      ,transaction_type
      ,order_date
      ,recurring_flag
      ,Auth_Fail_Num
      ,count(transaction_id)units
      ,sum(usd)usd
      
      from
(
select trunc(creation_date)day
      ,transaction_type
      ,(select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')order_Date
      ,(select count(transaction_id) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Authorize' and status in ('Declined', 'Failed'))Auth_Fail_Num
      ,request_money_amount usd
      ,(case when custom_data like '%recurring%' then 'Recurring' else 'non-recurring' end)recurring_flag
      ,transaction_id
      ,division_order_id


from cpg_payment_transaction cpt

where creation_date > sysdate - 10
and transaction_type in ('ChargeBack', 'Settle')
and status = 'Completed'
and (select status from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Authorize' and status in ('Declined', 'Failed') and rownum < 2) is not null
and payment_method_id = 'Visa'
and payment_service_id in ('mes', 'firstdata')


)

group by day
      ,transaction_type
      ,order_date
      ,Auth_Fail_Num
      ,recurring_flag