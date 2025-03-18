select Lag
      ,count(cpg_transaction_id)units
      
      from
(
select   round(settlement_date - (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')) as Lag
        ,cpg_transaction_id

from rcn_payment_transaction rpt

where settlement_date between '01-jan-13' and sysdate
and division_site_id in ('100271','135966','141129','140002','133253','135673','131089','139637','139235','134968','114070','138205','128668','100593','139975','130142','126096','104704','134442','140236','138170','141745')
--and division_id = 'pacific'
and status = 'Completed'
and transaction_type = 'Refund'
--and payment_method_id in ('Visa', 'MasterCard')


)

group by lag

order by lag