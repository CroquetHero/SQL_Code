select cb_date
        ,division_site_id
        ,merchant_number
        ,payment_plan_code
        ,payments_made
        ,transaction_type
        ,count(division_order_id)units
        
        from
(
select division_order_id
        ,trunc(cpg_creation_date)cb_date
        ,trunc(order_date)settle_date
        ,division_site_id
        ,payment_plan_code
        ,merchant_number
        ,transaction_type
      --  ,bank_name
     --   ,(case when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
        ,(select count(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed')Payments_Made
        ,payment_amount
      --  ,(select sum(payment_amount) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed')fund_amount
        
from rcn_payment_transaction rpt

where creation_date > '1/1/2016'
and cpg_creation_date between '1/1/2016' and  '9/1/2016'
--and settlement_date = '10/30/2015'
and transaction_type in ('ChargeBack','Settle')
and status = 'Completed'
--and division_site_id = 'avastbr'
--and payment_method_id in ('AmericanExpress')
and payment_processor_name in ('netgiro-br')
--and division_order_id = '9820528106'
--and recurring_flag <> 'recurring'

)

group by cb_date
        ,division_site_id
        ,payment_plan_code
        ,payments_made
        ,transaction_type
        ,merchant_number