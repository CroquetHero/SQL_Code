select trunc(creation_date)day
        ,count(transaction_ID)UNITS
     --   select *
from cpg_payment_transaction rpt

where creation_date > sysdate - 50
and transaction_type = 'ChargeBack'
and status in ('Completed')--,'Pending', 'New', 'Cancelled')
--and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'RFI' and status = 'New' and rownum < 2) is null
and payment_method_id in ('AmericanExpress')
and payment_service_id in ('mes','firstdata','litle','adyen')
--and response_message = 'Account is restricted'
--and bank_code like '%InternetPin%'
--and bank_code like '%%'
--and to_char(creation_date, 'D') = '3'
--and division_id = 'pacific'
--and division_site_id = 'avast'
--and division_id = 'fatfoogoo'

group by  trunc(creation_date)

order by day