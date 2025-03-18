select *

from 
(
select LM.payment_service_id
        ,LM.payment_method_id
        ,LM.rev_code
        ,n
        ,LM.units
        ,past1.mean
        ,past1.sigma
        ,(case when sigma > 0 then round((LM.units - mean)/sigma,3) else 0 end)Control_Limit
        
        from
(
select payment_service_id
        ,payment_method_id
        ,rev_code
        ,months n
        ,round(mean, 3)mean
        ,round(sigma, 3)sigma

        
        from
(
select payment_service_id
        ,payment_method_id
        ,rev_code
        ,avg(units)mean
      ,stddev(units)sigma
      ,count(units)months

from
(

select payment_service_id
        ,payment_method_id
        ,rev_code
        ,month
        ,count(transaction_id)units
        
        from

(
select payment_service_id
        ,payment_method_id
        ,(select response_code_1 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2)rev_code
        ,to_char(creation_date, 'MM/YYYY')month
        ,transaction_id
        
        from cpg_payment_transaction rpt
        
        where creation_date between '1/1/2018' and '8/1/2018'
        and transaction_type = 'ChargeBackRevrs'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        )
        
        
        group by payment_service_id
        ,payment_method_id
        ,rev_code
        ,month
        
        )
        
        group by payment_service_id
        ,payment_method_id
        ,rev_code
        
        order by payment_service_id
        ,payment_method_id
        ,rev_code
        
        )
        
        )past1
        
        full join

 (
 
 select payment_service_id
        ,payment_method_id
        ,rev_code
        ,count(transaction_id)units
        
        from
     
     (   
        select payment_service_id
        ,payment_method_id
        ,(select response_code_1 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2)rev_code
        ,transaction_id
        
        from cpg_payment_transaction rpt
        
        where creation_date between '8/1/2018' and '9/1/2018'
        and transaction_type = 'ChargeBackRevrs'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        )
        
        
        group by payment_service_id
        ,payment_method_id
        ,rev_code
        
        )LM
        
        on LM.rev_code = past1.rev_code
        and LM.payment_method_id = past1.payment_method_id
        and LM.payment_service_id = past1.payment_service_id
        
        where mean > 10
        
         order by Control_Limit desc
        
        )
        where abs(Control_Limit) > 3
        
        order by Control_Limit desc
        