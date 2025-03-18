select *

from
(
select division_order_id
      ,trunc(creation_date)cb_date
      ,payment_service_id
      ,(case when transaction_type = 'RFI' and payment_service_id = 'paypalExpress' then 'paypal-RFI'
                when transaction_type = 'ChargeBack' and payment_service_id = 'paypalExpress' then 'paypal-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('MasterCard', 'Visa') then 'firstdata'
                when payment_service_id = 'adyen' and payment_method_id in ('MasterCard', 'Visa') then 'adyen'
                when payment_service_id = 'adyen' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'adyen-CB'
                when payment_service_id = 'adyen' and payment_method_id in ('Discover','JCB') and transaction_type = 'ChargeBack' then 'adyen-disc-CB'
                when payment_service_id = 'adyen' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'adyen-RFI'
                when payment_service_id = 'adyen' and payment_method_id in ('Discover','JCB') and transaction_type = 'RFI' then 'adyen-disc-RFI'
                when payment_service_id = 'litle' and payment_method_id in ('MasterCard', 'Visa') then 'litle'
                when payment_service_id = 'litle' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'litle-CB'
                when payment_service_id = 'litle' and payment_method_id in ('Discover','JCB') and transaction_type = 'ChargeBack' then 'litle-disc-CB'
                when payment_service_id = 'litle' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'litle-RFI'
                when payment_service_id = 'litle' and payment_method_id in ('Discover','JCB') and transaction_type = 'RFI' then 'litle-disc-RFI'
                when payment_service_id = 'mes' and payment_method_id in ('Discover','JCB') and transaction_type = 'RFI' then 'mes-disc-RFI'
                when payment_service_id = 'mes' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'mes-CB'
                when payment_service_id = 'mes' and payment_method_id in ('Discover','JCB') and transaction_type = 'ChargeBack' then 'mes-disc-CB'
                when payment_service_id = 'mes' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'mes-RFI'
                when payment_service_id = 'mes' and payment_method_id in ('Discover','JCB') and transaction_type = 'RFI' then 'mes-disc-RFI'
                when payment_service_id = 'firstdata' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'firstdata-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('Discover') and transaction_type = 'ChargeBack' then 'firstdata-disc-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'firstdata-RFI'
                when payment_service_id = 'firstdata' and payment_method_id in ('Discover') and transaction_type = 'RFI' then 'firstdata-disc-RFI'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'RFI' then 'netgiro-seb-RFI'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'RFI' then 'netgiro-bms-RFI'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'ChargeBack' then 'netgiro-seb'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'ChargeBack' then 'netgiro-bms'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'ChargeBackNotice' then 'netgiro-seb-CBNotice'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'ChargeBackNotice' then 'netgiro-bms-CBNotice'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBack' then 'netgiro-amex-CB'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBackNotice' then 'netgiro-amex-CBNotice'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'RFI' then 'netgiro-amex-RFI'
                else payment_service_id end)processor
             
      ,payment_method_id
      ,division_id
      ,response_code_1
      ,(case when payment_service_id in ('netgiro-eft','netgiro-seb', 'drwp-eft','netgiro-br', 'netgiro-bms') and transaction_type = 'ChargeBack' then 'Ignore'
             when payment_service_id in ('firstdata', 'mes') and payment_method_id in ('AmericanExpress','Discover') then 'Ignore'
             when payment_service_id in ('netgiro-bms','netgiro-bnp','netgiro-eft','netgiro-seb') then bank_code
             when payment_service_id = 'firstdata' and response_code_1 in ('41','72') then 'Ignore'
             when payment_service_id in ('firstdata','litle','mes') and division_id <> 'pacific' and response_code_1 in ('53','4853') then 'Ignore'
             when payment_service_id = 'mes' and response_code_1 in ('41','4841','4860') and division_site_id not in ('lominger') then 'Ignore'
             when payment_service_id in ('litle','firstdata') and response_code_1 in ('4860','85') and division_site_id in ('10045','100843','101865','102117','102370','102645','104239','10610','109373','109911','113595','115801','11619','11802','12096','123931','126142','126526','127240','13095','13181','132312','132323','134442','13446','13456','13545','136596','136605','138632','138657','139406','139540','139869','14091','14114','14198','143131','14332','14426','14438','144768','145433','145452','145908','146097','146140','146193','146273','146277','15733','15767','15935','1602','16339','17774','18084','1824','18620','18764','18993','19535','19796','200007715','200010851','200025254','200027224','200029983','200040652','200054552','200059286','200064422','200081144','200088848','200091689','200093943','200095708','200101767','200102185','200122328','200148789','200149662','200168193','200181287','200188948','200225780','200250387','200250782','200251588','200251598','200251714','200252026','200252397','200253716','200254188','200254824','200254871','200256641','20309','20406','20651','20667','21346','23046','23655','25140','2547','26239','2658','26655','26872','27127','27453','2795','28092','28911','28982','29857','29877','29936','30090','30253','30351','3043','30566','30589','30666','30911','30945','31021','31712','32183','32239','32711','33128','33219','33232','33423','35152','3560','36197','3631','36395','36873','37211','37480','38102','39492','39924','40461','4081','40871','42359','4258','42630','4298','44299','44838','4538','45748','46202','46304','47158','48357','48768','50315','50379','50683','50899','51881','52650','52680','53529','5388','54114','54342','54705','54944','55103','55374','55396','55979','56122','5630','56513','5833','6201','6417','8167','8353','9011','9388','9891','airmusic','bobjamer','bufftech','ciscoctg','citrix','cppro','descl','digitalextremes.com','endnote','eyefiinc','fartech','izotope','mixmeist','nvsubs','pinnsys','plt','ptc','PUB11003:STR41701','PUB11003:STR42741','PUB11003:STR46684','PUB11003:STR48895','PUB11003:STR49604','PUB11745:STR39930','PUB15161:STR34944','PUB15738:STR36295','PUB18748:STR44449','PUB21167:STR47887','PUB21334:STR50087','PUB25313:STR55860','PUB25313:STR55892','PUB26425:STR57038','PUB3253:STR4480','PUB3610:STR22964','PUB4081:STR31217','PUB5345:STR8693','PUB5419:STR8896','PUB6835:STR12357','PUB7222:STR13077','PUB9058:STR35574','rockstar.com','sanus','Tk22k') then 'Ignore'
             when payment_service_id in ('paypalExpress','paypalAdaptive') then 'Ignore'
             when payment_service_id = 'nab' and response_code_1 in ('83', '41', '4841') then 'Ignore'
             when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBack' then 'Ignore'
             when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBackNotice' then reference_number
             --when payment_service_id = 'netgiro-amex' then bank_code
             when division_site_id = '139869' then 'Ignore'
             when payment_method_id in ('Visa','MasterCard', 'Discover') and transaction_type = 'ChargeBack' and creation_date > (select min(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Ignore'
             else reference_number end)case_number
      ,(case when (select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like'%recurring%' then 'Recurring' else 'Non-Recurring' end) recurring_flag
      ,dbms_random.value(1,10000000)sample_number
      
    --  select *
      from cpg_payment_transaction rpt
      
      where creation_date between '12/31/2017' and '1/31/2018'
and transaction_type in ('ChargeBack', 'ChargeBackNotice','RFI')
and status in ('New', 'Requested','Completed')
and payment_method_id not in ('MicrosoftPayment')
and payment_service_id not in ('braspag','drwp-ebanx','pagador','ncldirect','drwp-dlocal')
and division_id in ('pacific','swreg','regnow','esellerate','element5','fatfoogoo')
--and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')

order by sample_number
)
where case_number <> 'Ignore'
and rownum < 101
order by sample_number