select *

from
(
select trunc(creation_date)cb_date
      ,transaction_type
      ,payment_service_id processor
      ,payment_method_id card_type
      ,response_code_1 cb_code
      ,division_site_id site_id
      ,count(transaction_id)units
      ,round(sum(decode(request_money_currency,'USD','1','EUR','1.114358893','GBP','1.571548039','INR','0.015722638','AUD','0.770089672','CAD','0.801086827','SGD','0.742221342','CHF','1.06712029','MYR','0.2664727','JPY','0.008188589','CNY','0.161276283','NZD','0.676886379','THB','0.02955472','HUF','0.003538299','AED','0.27226074','HKD','0.128993645','MXN','0.063669337','ZAR','0.082238596','PHP','0.022181716','SEK','0.120490775','IDR','7.48281E-05','SAR','0.266644556','BRL','0.321807447','TRY','0.373155453','KES','0.010081073','KRW','0.00089465','EGP','0.131085665','IQD','0.000839932','NOK','0.127273091','KWD','3.310159356','RUB','0.018057375','DKK','0.149372602','PKR','0.009824831','ILS','0.265481227','PLN','0.26585656','QAR','0.274630833','XAU','1176.478315','OMR','2.59774001','COP','0.000384785','CLP','0.001564651','TWD','0.032380232','ARS','0.110054274','CZK','0.040922174','VND','4.59044E-05','MAD','0.102774331','JOD','1.41073588','BHD','2.65224277','XOF','0.001698829','LKR','0.00747208','UAH','0.0475964','NGN','0.005023995','TND','0.512626792','UGX','0.00030271','RON','0.248774883','BDT','0.012854291','PEN','0.314812057','GEL','0.44543651','XAF','0.001698829','FJD','0.479507109','VEF','0.158351007','BYR','0.00006532','HRK','0.146796886','UZS','0.000391416','BGN','0.569733114','DZD','0.01011609','IRR','3.40219E-05','DOP','0.02227174','ISK','0.0075772','XAG','15.76600665','CRC','0.00187388','SYP','0.005296','LYD','0.731632523','JMD','0.008573403','MUR','0.028608441','GHS','0.22936263','AOA','0.009093554','UYU','0.037092','AFN','0.01646366','LBP','0.000662706','XPF','0.009338328','TTD','0.15741619','TZS','0.00045784','ALL','0.007983898','XCD','0.37037037','GTQ','0.13112175','NPR','0.009814699','BOB','0.14514553','ZWD','0.002763194','BBD','0.5','CUC','1','LAK','0.00012329','BND','0.742221342','BWP','0.100921081','HNL','0.04564376','PYG','0.00019261','ETB','0.048313837','NAD','0.082238596','PGK','0.364936994','SDG','0.16736402','MOP','0.125236548','NIO','0.037082849','BMD','1','KZT','0.005370282','PAB','1','BAM','0.569762655','GYD','0.00482619','YER','0.004652126','MGA','0.00033091','KYD','1.2195122','MZN','0.026113842','RSD','0.00927301','SCR','0.076289974','AMD','0.0021139','SBD','0.126930413','AZN','0.952598935','SLL','0.000232817','TOP','0.48235','BZD','0.49630542','MWK','0.002273018','GMD','0.025261589','BIF','0.00063711','SOS','0.001439846','HTG','0.021190931','GNF','0.000142197','MVR','0.065042934','MNT','0.00051244','CDF','0.00107787','STD','4.56715E-05','TJS','0.15973931','KPW','0.007802775','MMK','0.00089446','LSL','0.082238596','LRD','0.01081082','KGS','0.01610856','GIP','1.571548039','XPT','1083.182863','MDL','0.052751758','CUP','0.037735849','KHR','0.00024326','MKD','0.018113129','VUV','0.009205069','MRO','0.003418803','ANG','0.55865922','SZL','0.082238596','CVE','0.010236468','SRD','0.30309989','XPD','671.7925231','SVC','0.114285714','BSD','1','XDR','1.40538263','RWF','0.001406552','AWG','0.558659218','DJF','0.00564562','BTN','0.015722638','KMF','0.002265106','WST','0.3912','SPL','6','ERN','0.09551101','FKP','1.571548039','SHP','1.571548039','JEP','1.571548039','TMT','0.285714286','TVD','0.770089672','IMP','1.571548039','GGP','1.571548039',1)*request_money_amount),2)usd
      ,account_token
      

from cpg_payment_transaction

where creation_date > trunc(sysdate) - 1
and transaction_type in ('ChargeBackNotice', 'RFI','ChargeBack')
and status in ('New','Completed','Pending')
and payment_method_id <> 'MicrosoftPayment'

group by transaction_type
      ,payment_service_id
      ,payment_method_id
      ,division_site_id
      ,trunc(creation_date)
      ,response_code_1
      ,account_token
      
      order by units desc
      
      )
      
      where units > 5 
      or usd > 500 and units > 1