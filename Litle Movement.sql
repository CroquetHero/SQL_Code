select day
        ,payment_service_id
        ,payment_method_id
        ,division_site_id
        ,cb_status
        ,count(transaction_id)units
        ,sum(request_money_amount)usd
        
        from
        
(
select payment_service_id
        ,payment_method_id
        ,division_site_id
        ,trunc(creation_date)day
        ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
        ,transaction_id
        ,request_money_amount

from cpg_payment_transaction rpt

where creation_date between '3/21/2016' and '4/1/2016'
and transaction_type = 'Settle'
and status = 'Completed'
and payment_method_id in ('MasterCard','Visa')
and payment_service_id in ('mes', 'firstdata')
and division_id = 'pacific'

)

group by payment_service_id
        ,payment_method_id
        ,division_site_id
        ,cb_status
        ,day
        
        order by division_site_id