select day
      ,transaction_type
      ,payment_method_id
      ,division_id
      ,recurring_flag
      ,count(transaction_id)units
      ,sum(amount)amount
      ,request_money_currency
      
      from
(
select to_char(creation_date)day
      ,transaction_type
      ,request_money_amount amount
      ,request_money_currency
      ,(case when custom_data like '%recurring%' then 'Recurring' else 'non-recurring' end)recurring_flag
      ,transaction_id
      ,division_order_id
      ,division_id
      ,payment_method_id


from cpg_payment_transaction cpt

where creation_date > '3/1/2016'
and transaction_type in ('ChargeBack', 'Settle')
and status = 'Completed'
and payment_method_id in ('Visa', 'MasterCard')
and merchant_number like '%1941392348%'
and payment_service_id = 'netgiro-bms'


)

group by day
      ,transaction_type
      ,payment_method_id
      ,division_id
      ,recurring_flag
      ,request_money_currency