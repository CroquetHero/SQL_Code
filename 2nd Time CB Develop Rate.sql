select Lag
      ,count(cpg_transaction_id)units
      
      from
(
select   round(rpt.settlement_date - (select settlement_date from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount and rownum < 2) ) as Lag
        ,cpg_transaction_id
        ,division_order_id
        ,settlement_date
        ,creation_date
        ,(select settlement_date from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount and rownum < 2)Rev_date
        ,(select creation_date from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount and rownum < 2)Rev_creation_date


from rcn_payment_transaction rpt

where settlement_date between '01-oct-12' and '31-dec-12'
--and division_site_id = 'kasperus'
--and division_id = 'pacific'
and status = 'Completed'
and transaction_type in ('ChargeBack')
and payment_method_id = 'Visa'
and response_code = '30'
and (select max(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount) > (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.payment_amount between .95*payment_amount and 1.05*payment_amount)
--and division_order_id = 'U4762082101' 

order by lag
)

where lag > '-1'
and creation_date > rev_creation_date
group by Lag


order by lag