select *

from 
(
select LM.payment_service_id
        ,LM.payment_method_id
        ,LM.response_code_1
        ,n
        ,LM.units
        ,past1.mean
        ,past1.sigma
        ,(case when sigma > 0 then round((LM.units - mean)/sigma,3) else 0 end)Control_Limit
        
        from
(
select payment_service_id
        ,payment_method_id
        ,response_code_1
        ,months n
        ,round(mean, 3)mean
        ,round(sigma, 3)sigma

        
        from
(
select payment_service_id
        ,payment_method_id
        ,response_code_1
        ,avg(units)mean
      ,stddev(units)sigma
      ,count(units)months

from
(
select payment_service_id
        ,payment_method_id
        ,response_code_1
        ,to_char(creation_date, 'MM/YYYY')month
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '12/1/2018' and '5/1/2019'
        and transaction_type = 'ChargeBack'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by payment_service_id
        ,payment_method_id
        ,response_code_1
        ,to_char(creation_date, 'MM/YYYY')
        
        )
        
        group by payment_service_id
        ,payment_method_id
        ,response_code_1
        
        order by payment_service_id
        ,payment_method_id
        ,response_code_1
        
        )
        
        )past1
        
        full join

 (
        
        select payment_service_id
        ,payment_method_id
        ,response_code_1
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '5/1/2019' and '6/1/2019'
        and transaction_type = 'ChargeBack'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by payment_service_id
        ,payment_method_id
        ,response_code_1
        
        )LM
        
        on LM.response_code_1 = past1.response_code_1
        and LM.payment_method_id = past1.payment_method_id
        and LM.payment_service_id = past1.payment_service_id
        
        where mean > 10
        
         order by Control_Limit desc
        
        )
        where abs(Control_Limit) > 3
        
        order by Control_Limit desc
        