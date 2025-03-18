select to_char(creation_date, 'MM/YYYY')Month
,billing_address_country_id
        ,count(transaction_ID)UNITS
        ,sum(request_money_amount)amount
        ,request_money_currency
     --   select *
from cpg_payment_transaction rpt

where creation_date between '12/1/2018' and '1/1/2019'
and transaction_type = 'ChargeBack'
and status in ('Completed')--,'Pending', 'New', 'Cancelled')
--and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'RFI' and status = 'New' and rownum < 2) is null
--and payment_method_id in ('AmericanExpress')
--and payment_service_id in ('mes','firstdata','litle','adyen')
--and response_message = 'Account is restricted'
and billing_address_country_id in ('FR','ES','IT','PT','RO','BE')
and response_code_1 in ('530','A02','F10','F24','F29','F30','M47','R06','F06','FR2','FR3','Fraud','M01','4','10','10.1','10.2','10.3','10.4','10.5','37','40','47','57','62','63','75','81','83','93','4804','4837','4840','4863','4870','U02','UA01','UA02','UANR','AA','UA11','UA12','UA21','UA23','UA32','UA99','UANR - Fraud','063','546','45','70','Charge not recognized','Unauthorized','Unauthorized payment','MD01','81014','C41','C42','4847','4857','4862','2031','2045','2067','23011','23038','23039','23084','92046','4527','4540','4798','4799','6006','8075','8083','14','7030','33','6321','8062')
--and bank_code like '%InternetPin%'
--and bank_code like '%%'
--and to_char(creation_date, 'D') = '3'
--and division_id = 'pacific'
--and division_site_id = 'avast'
--and division_id = 'fatfoogoo'

group by to_char(creation_date, 'MM/YYYY')
,request_money_currency
,billing_address_country_id
