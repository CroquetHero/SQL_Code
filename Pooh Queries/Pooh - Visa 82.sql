select Orig_Order
      ,(case when payment_service_id = 'firstdata' then substr((select custom_data from cpg_payment_transaction where orig_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), instr((select custom_data from cpg_payment_transaction where orig_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), 'Tran ID=',200)+8, 15)
             when payment_service_id = 'litle' then (select reference_number from cpg_payment_transaction where orig_order = division_order_id and transaction_type = 'Fund' and status = 'Completed' and rownum < 2)
             when payment_service_id in ('netgiro-seb', 'netgiro-bms') then (select to_char(transaction_id) from cpg_payment_transaction where orig_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when payment_service_id = 'adyen' then (select authorization_code from cpg_payment_transaction where Orig_Order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when division_id = 'element5' then 'E5'||Orig_Order 
             when division_id = 'esellerate' then 'MV'||Orig_Order 
             when division_id = 'regnow' then 'RW'||replace(Orig_Order, '-', '')
             when division_id = 'swreg' then 'SW'||Orig_Order 
             else Orig_Order end)orig_identifier
      ,auth_date
      ,Order_date
      ,(select sum(request_money_amount) from cpg_payment_transaction where orig_order = division_order_id and transaction_type = 'Settle' and status = 'Completed')Orig_amount
      ,payment_service_id
      ,reference_number
      ,division_site_id
      ,recurring_flag
      ,account_token
      ,dup_order
      ,(case when payment_service_id = 'firstdata' then substr((select custom_data from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), instr((select custom_data from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and payment_service_id = 'firstdata' and rownum < 2), 'Tran ID=',200)+8, 15)
             when payment_service_id in ('netgiro-seb', 'netgiro-bms') then (select to_char(transaction_id) from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when payment_service_id = 'litle' then (select reference_number from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Fund' and status = 'Completed' and rownum < 2)
             when payment_service_id = 'adyen' then (select authorization_code from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)
             when division_id = 'pacific' then 'GC'||dup_order 
             when division_id = 'element5' then 'E5'||dup_order 
             when division_id = 'esellerate' then 'MV'||dup_order 
             when division_id = 'regnow' then 'RW'||replace(dup_order, '-', '')
             when division_id = 'swreg' then 'SW'||dup_order 
             else dup_order end)dup_identifier
      ,(select min(creation_date) from cpg_payment_transaction where division_order_id = dup_order and transaction_type = 'Authorize' and status = 'Completed')dup_auth_date
      ,(select max(creation_date) from cpg_payment_transaction where division_order_id = dup_order and transaction_type = 'Settle' and status = 'Completed')dup_settle_date
      ,(select sum(request_money_amount) from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed')dup_amount
      --,(case when (select custom_data from cpg_payment_transaction where dup_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like'%recurring%' then 'recurring' else 'non-recurring' end) dup_recurring_flag
      ,Dup_count
      ,billing_address_email_address
      ,creation_date
      
      from
      
(
select distinct division_order_id Orig_Order,'',''
      ,substr((select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), instr((select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2), 'Tran ID=',1)+8, 15)Visa_Transaction
      ,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')Order_date
      ,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed')Auth_date
   --   ,(select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)custom_data
      ,reference_number
      ,division_site_id
      ,division_id
      ,payment_service_id
      ,(case when (select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like'%recurring%' then 'Recurring' else 'Non-Recurring' end) recurring_flag
      ,(select distinct first_value(division_order_id) over (order by creation_date desc)dup_order from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id <> rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')dup_order,''space
     -- ,(select max(division_order_id) from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id <> rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')Dup_Order,''
      ,(select max(creation_date) from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id <> rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')Dup_Order_date 
      ,(select count(division_order_id) from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id <> rpt.division_order_id and creation_date between rpt.creation_date - 150 and rpt.creation_date and transaction_type = 'Settle' and status = 'Completed' )Dup_count 
      ,billing_address_email_address
      ,creation_date
      ,account_token
      ,(case when transaction_type in ('RFI', 'ChargeBackNotice') then 'Good'
            when transaction_type = 'ChargeBack' and payment_service_id in ('netgiro-amex','netgiro-bms','netgiro-seb') then 'Bad'
             when creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Good'
             else 'Bad' end)Trans_Status

from cpg_payment_transaction rpt

where creation_date between trunc(sysdate) - 1 and  trunc(sysdate)
and transaction_type in ('ChargeBackNotice', 'RFI','ChargeBack')
and status in ('New','Pending','Completed', 'Requested')
and payment_method_id in ('Visa', 'MasterCard','AmericanExpress')
and payment_service_id in ('adyen','mes','litle','firstdata', 'netgiro-seb', 'netgiro-bms', 'netgiro-amex', 'netgiro-bnp', 'netgiro-fd', 'netgiro-br', 'drwp-eft')
and response_code_1 in ('82', '4834', '34','173','12.6.1','12.6')--,'85')
--and division_order_id = '12588801200'
--and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is null
and division_site_id <> 'msstore'
--and division_id = 'pacific'

)BD

where Trans_Status = 'Good'

order by creation_date, orig_order