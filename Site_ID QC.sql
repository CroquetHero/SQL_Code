select (case when LM.division_site_id is null then past1.division_site_id else LM.division_site_id end)Site_ID
        ,n
        ,LM.units
        ,past1.mean
        ,past1.sigma
        ,(case when sigma > 0 then round((LM.units - mean)/sigma,3) else 0 end)ratio
        
        from
(
select division_site_id
        ,months n
        ,round(mean, 3)mean
        ,round(sigma, 3)sigma

        
        from
(
select division_site_id
        ,avg(units)mean
      ,stddev(units)sigma
      ,count(units)months

from
(
select division_site_id
        ,to_char(creation_date, 'MM/YYYY')month
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '6/1/2018' and '12/1/2018'
        and transaction_type = 'Settle'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer','OnlineBanking','IBP')
        and division_id in ('pacific')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by division_site_id
        ,to_char(creation_date, 'MM/YYYY')
        
        )
        
        group by division_site_id
        
        order by division_site_id
        
        )
        
        )past1
        
        full join

 (
        
        select division_site_id
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '12/1/2018' and sysdate
        and transaction_type = 'Settle'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer','OnlineBanking','IBP')
        and division_id in ('pacific')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by division_site_id
        
        )LM
        
        on LM.division_site_id = past1.division_site_id
        where mean is null
        --and mean > 1000
        
        order by units desc