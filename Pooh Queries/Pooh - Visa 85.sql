select division_order_id
      ,reference_number
      ,division_site_id
     -- ,payment_service_id
      --,payment_method_id
      ,(case when division_site_id in ('slingbox','3mprint','90dsi','absolute','accelrys','acd','actiemea','activisi','acuproj','adsk','aliphcom','aspyr','atarius','avantsta','avery','bobjects','brdrmus','ca','canonb2c','canoncon','capcomus','citrixus','cyberdef','cyberscrub','defender','eeyeinc','ets','imatnus','kasperus','kmt','lenovoeu','lominger','matty','mcafeeus','media3d','mindjet','namcous','nordicga','novell','nuanceus','nvidia','promt','ptc','razerusa','samca','sennheus','sonic','sqenixus','threeda','tmamer','transpar','ubisoft','vmware','wdirus','wdus','webroot','winamp','trendoem','tmoemas') then 'TRUE'
        when division_id in ('swreg', 'regnow', 'esellerate') then 'TRUE'
        when division_id = 'element5' then 'Not Sure'
        when division_site_id = 'avast' then 'Check CS'
        else 'FALSE' end)CS_Status,''
      ,billing_address_email_address
      ,creation_date
      ,request_money_amount
    --  ,account_token

from cpg_payment_transaction rpt

where creation_date > trunc(sysdate)
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_method_id in ('MasterCard', 'Visa')
and payment_service_id in ('mes','firstdata','litle','adyen')
and response_code_1 in ('85','60', '4860','13.6','13.7')
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is null
and division_site_id <> 'msstore'
order by creation_date