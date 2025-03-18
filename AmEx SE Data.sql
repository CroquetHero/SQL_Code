select (case when division_id in ('regnow', 'esellerate', 'swreg') then '1266706589'
                  when division_id = 'pacific' and payment_service_id = 'litle' then '3220254916'
                  when division_id in ('pacific', 'fatfoogoo') and payment_service_id = 'mes' and merchant_number = '941000108071_00000001' then '3220254916'
                  when division_id in ('pacific', 'fatfoogoo','commerce5') and payment_service_id = 'firstdata' and merchant_number = '311009012882' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'firstdata' and merchant_number = '311009017881' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number in ('7236117','7236084') then '3220523815'
                  when division_id in ('pacific', 'fatfoogoo','commerce5') and payment_service_id = 'mes' and merchant_number = '941000108063_00000001' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'mes' and merchant_number = '941000108064_00000001' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number = '7236110' then '3221116924'
                  when division_id = 'pacific' and payment_service_id = 'mes' and merchant_number = '941000108062_00000001' then '3221116924'
                  when division_id = 'fatfoogoo' and payment_service_id = 'firstdata' and merchant_number = '311009023889' then '3221162399'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number = '7236099' then '3221162399'
                  when division_id = 'fatfoogoo' and payment_service_id = 'mes' and merchant_number = '941000108065_00000001' then '3221162399'
                  else 'Other' end)SE
                  ,to_char(creation_date,'MM/YYYY')month
                  ,transaction_type
                  ,count(transaction_id)units
                  

from cpg_payment_transaction

where creation_date between '1/1/2016' and '3/1/2016'
and transaction_type in ('ChargeBack','Settle')
and status = 'Completed'
and payment_service_id in ('mes', 'litle', 'firstdata')
and payment_method_id = 'AmericanExpress'
--and response_code_1 = 'Special'

group by (case when division_id in ('regnow', 'esellerate', 'swreg') then '1266706589'
                  when division_id = 'pacific' and payment_service_id = 'litle' then '3220254916'
                  when division_id in ('pacific', 'fatfoogoo') and payment_service_id = 'mes' and merchant_number = '941000108071_00000001' then '3220254916'
                  when division_id in ('pacific', 'fatfoogoo','commerce5') and payment_service_id = 'firstdata' and merchant_number = '311009012882' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'firstdata' and merchant_number = '311009017881' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number in ('7236117','7236084') then '3220523815'
                  when division_id in ('pacific', 'fatfoogoo','commerce5') and payment_service_id = 'mes' and merchant_number = '941000108063_00000001' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'mes' and merchant_number = '941000108064_00000001' then '3220523815'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number = '7236110' then '3221116924'
                  when division_id = 'pacific' and payment_service_id = 'mes' and merchant_number = '941000108062_00000001' then '3221116924'
                  when division_id = 'fatfoogoo' and payment_service_id = 'firstdata' and merchant_number = '311009023889' then '3221162399'
                  when division_id = 'pacific' and payment_service_id = 'litle' and merchant_number = '7236099' then '3221162399'
                  when division_id = 'fatfoogoo' and payment_service_id = 'mes' and merchant_number = '941000108065_00000001' then '3221162399'
                  else 'Other' end)
                  ,to_char(creation_date,'MM/YYYY')
                  ,transaction_type