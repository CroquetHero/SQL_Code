select (case when LM.payment_service_id is null then past1.payment_service_id else LM.payment_service_id end)processor
        ,(case when LM.MID is null then past1.MID else LM.MID end)MID
        ,n
        ,LM.units
        ,past1.mean
        ,past1.sigma
        ,(case when sigma > 0 then round((LM.units - mean)/sigma,3) else 0 end)ratio
        
        from
(
select payment_service_id
        ,MID
        ,months n
        ,round(mean, 3)mean
        ,round(sigma, 3)sigma

        
        from
(
select payment_service_id
        ,MID
        ,avg(units)mean
      ,stddev(units)sigma
      ,count(units)months

from
(
select payment_service_id
        ,(case when payment_service_id in ('netgiro-fd','netgiro-seb', 'netgiro-bms', 'netgiro-amex', 'drwp-eft','netgiro-eft', 'netgiro-br','netgiro-jcb','netgiro-bnp','drwp-klarna','drwp-fd') then substr(merchant_number, 0, 10) else merchant_number end)MID
        ,to_char(creation_date, 'MM/YYYY')month
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '1/1/2018' and sysdate
        and transaction_type = 'Settle'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer','OnlineBanking','IBP')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by payment_service_id
        ,(case when payment_service_id in ('netgiro-fd','netgiro-seb', 'netgiro-bms', 'netgiro-amex', 'drwp-eft','netgiro-eft', 'netgiro-br','netgiro-jcb','netgiro-bnp','drwp-klarna','drwp-fd') then substr(merchant_number, 0, 10) else merchant_number end)
        ,to_char(creation_date, 'MM/YYYY')
        
        )
        
        group by payment_service_id
        ,MID
        
        order by payment_service_id
        ,MID
        
        )
        
        )past1
        
        full join

 (
        
        select payment_service_id
        ,(case when payment_service_id in ('netgiro-fd','netgiro-seb', 'netgiro-bms', 'netgiro-amex', 'drwp-eft','netgiro-eft', 'netgiro-br','netgiro-jcb','netgiro-bnp','drwp-klarna','drwp-fd') then substr(merchant_number, 0, 10) else merchant_number end)MID
        ,count(transaction_id)units
        
        from cpg_payment_transaction
        
        where creation_date between '4/1/2018' and sysdate
        and transaction_type = 'ChargeBack'
        and status = 'Completed'
        and payment_method_id not in ('MicrosoftPayment','WireTransfer','OnlineBanking','IBP')
        and division_id not in ('netgiro')
        and division_site_id not in ('rimerow', 'rimeus', 'rimeca')
        
        
        group by payment_service_id
        ,(case when payment_service_id in ('netgiro-fd','netgiro-seb', 'netgiro-bms', 'netgiro-amex', 'drwp-eft','netgiro-eft', 'netgiro-br','netgiro-jcb','netgiro-bnp','drwp-klarna','drwp-fd') then substr(merchant_number, 0, 10) else merchant_number end)
        
        )LM
        
        on LM.MID = past1.MID
        where units is null
        and mean > 1000
        
        order by mean desc