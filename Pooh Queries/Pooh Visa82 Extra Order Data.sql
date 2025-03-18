select division_order_id
      ,payment_service_id
      ,(case when (select status from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'RFI' and status = 'Completed' and payment_method_id = 'Discover' and rownum < 2) is not null then (select distinct authorization_code from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'RFI' and status = 'Completed' and payment_method_id = 'Discover')
             when (select status from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then (select reference_number from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) 
             when (select status from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBackNotice' and rownum < 2) is not null then (select reference_number from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBackNotice' and rownum < 2) 
             else 'x' end)case_number
      ,(case when payment_method_id = 'Discover' then authorization_code
      when payment_service_id = 'litle' then (select reference_number from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Fund' and status = 'Completed' and rownum < 2)
             when payment_service_id = 'firstdata' then substr((select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), instr((select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and payment_service_id = 'firstdata' and rownum < 2), 'Tran ID=',200)+8, 15)
             when payment_service_id in ('netgiro-seb', 'netgiro-bms') then (select to_char(transaction_id) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when payment_service_id = 'adyen' then (select authorization_code from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when division_id = 'pacific' then 'GC'||rpt.division_order_id 
             when division_id = 'element5' then 'E5'||rpt.division_order_id 
             when division_id = 'esellerate' then 'MV'||rpt.division_order_id 
             when division_id = 'regnow' then 'RW'||replace(rpt.division_order_id, '-', '')
             when division_id = 'swreg' then 'SW'||rpt.division_order_id 
             else rpt.division_order_id end)dup_identifier
      ,(select min(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Authorize' and status = 'Completed')auth_date
      ,trunc(creation_date)order_date
      ,division_site_id
      ,(case when (select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like'%recurring%' then 'recurring' else 'non-recurring' end) recurring_flag
      ,request_money_amount
      
from cpg_payment_transaction rpt

where account_token = '18185941540000000000004646344606'
and transaction_type = 'Settle'
and status = 'Completed'
--and division_site_id = 'kasperus'
--and creation_date > sysdate - 240

order by auth_date