select division_order_id2 division_order_id
,auth_id
,''#,bank_code
,processor
,reference_number
,response_code_1
,transaction_type
,bank_code1
--,order_date
,(select distinct first_value(trunc(creation_date)) over (order by transaction_id) from cpg_payment_transaction where division_order_id = BD.division_order_id and transaction_type = 'Settle' and status = 'Completed')Order_date
,division_id
,first_name
,last_name
,billing_address_line_1
,billing_address_line_2
,billing_address_city
,billing_address_state
,billing_address_postal_code
,billing_address_country_id
,billing_address_email_address
,customer_ip
,null
,payment_method_id
,recurring_flag
,fraud_rev
,merchant_descriptor
,refund_amount
,division_site_id
,refund_status
,request_money_amount

from 
(
select division_order_id
,custom_data
      ,merchant_order_id
      ,(select max(cpg_transaction_id) from eq2admin.rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed')auth_id
      /*,(case when payment_service_id = 'paypalExpress' then (select bank_code from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed' and rownum < 2) 
                else merchant_number end)bank_code*/
      ,(case when transaction_type = 'RFI' and payment_service_id = 'paypalExpress' then 'paypal-RFI'
                when transaction_type = 'ChargeBack' and payment_service_id = 'paypalExpress' then 'paypal-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('MasterCard', 'Visa') then 'firstdata'
                when payment_service_id = 'firstdata' and payment_method_id in ('MasterCard', 'Visa') and transaction_type = 'RFI' then 'firstdata-skip'
                when payment_service_id = 'adyen' and payment_method_id in ('MasterCard', 'Visa') then 'adyen'
                when payment_service_id = 'adyen' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'adyen-CB'
                when payment_service_id = 'adyen' and payment_method_id in ('Discover') and transaction_type = 'ChargeBack' then 'adyen-disc-CB'
                when payment_service_id = 'adyen' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'adyen-RFI'
                when payment_service_id = 'adyen' and payment_method_id in ('Discover') and transaction_type = 'RFI' then 'adyen-disc-RFI'
                when payment_service_id = 'litle' and payment_method_id in ('MasterCard', 'Visa') then 'litle'
                when payment_service_id = 'litle' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'litle-CB'
                when payment_service_id = 'litle' and payment_method_id in ('Discover') and transaction_type = 'ChargeBack' then 'litle-disc-CB'
                when payment_service_id = 'litle' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'litle-RFI'
                when payment_service_id = 'litle' and payment_method_id in ('Discover') and transaction_type = 'RFI' then 'litle-disc-RFI'
                when payment_service_id = 'firstdata' and payment_method_id in ('AmericanExpress') and transaction_type = 'ChargeBack' then 'firstdata-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('Discover') and transaction_type = 'ChargeBack' then 'firstdata-disc-CB'
                when payment_service_id = 'firstdata' and payment_method_id in ('AmericanExpress') and transaction_type = 'RFI' then 'firstdata-RFI'
                when payment_service_id = 'firstdata' and payment_method_id in ('Discover') and transaction_type = 'RFI' then 'firstdata-disc-RFI'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'RFI' then 'netgiro-seb-RFI'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'RFI' then 'drwp-bms-RFI'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'ChargeBack' then 'netgiro-seb'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'ChargeBack' then 'drwp-bms'
                when payment_service_id = 'netgiro-seb' and transaction_type = 'ChargeBackNotice' then 'netgiro-seb-CBNotice'
                when payment_service_id = 'netgiro-bms' and transaction_type = 'ChargeBackNotice' then 'drwp-bms-CBNotice'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBack' then 'drwp-amex-CB'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'ChargeBackNotice' then 'drwp-amex-CBNotice'
                when payment_service_id = 'netgiro-amex' and transaction_type = 'RFI' then 'drwp-amex-RFI'
                else payment_service_id end)processor
      ,(case when reference_number is null and payment_service_id = 'paypalExpress' then substr(custom_data, instr(custom_data, 'CaseID=') + length('CaseID='), (locate('~~',custom_data, instr(custom_data, 'CaseID='))) - (instr(custom_data, 'CaseID=') + length('CaseID=')))
      when reference_number is null and payment_service_id in ('netgiro-jcb','drwp-bms') then bank_code
      else reference_number end)reference_number
      ,response_code_1
      ,transaction_type
      ,(case when payment_service_id = 'paypalExpress' then authorization_code
                when payment_service_id in ('drwp-bms','netgiro-seb','netgiro-bms','netgiro-amex','netgiro-bnp','drwp-eft','mes','firstdata') and bank_code like '%InternetPin=0%' then null
                when payment_service_id in ('drwp-bms','netgiro-seb','netgiro-bms','netgiro-amex','netgiro-bnp','drwp-eft','mes','firstdata') and bank_code like '%\x1a%' then substr(bank_code,0,8)|| substr(bank_code,10,15)
                when payment_service_id in ('drwp-bms','netgiro-seb','netgiro-bms','netgiro-amex','netgiro-bnp','drwp-eft','mes','firstdata') then bank_code
                else authorization_code end)bank_code1
      ,trunc(order_date)order_date
      ,division_id
      ,first_name
      ,last_name
      ,billing_address_line_1
      ,billing_address_line_2
      ,billing_address_city
      ,billing_address_state
      ,billing_address_postal_code
      ,billing_address_country_id
      ,billing_address_email_address
      ,(select distinct customer_ip from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2)customer_ip
      ,null
      ,payment_method_id
      ,(case when (select custom_data from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) like'%recurring%' then 'Recurring' else 'Non-Recurring' end) recurring_flag
      ,(case when payment_service_id = 'paypalExpress' and custom_data not like '%protectEligible=true%' then 'verify_eci=FALSE'
      when payment_service_id = 'litle' then 'Avs='||(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) ||' CID='||(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)||' 3ds='||(select verify_en_status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2)|| ' ARN='||(select reference_number from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed' and rownum < 2)
      when payment_service_id = 'mes' and payment_method_id in ('Visa', 'MasterCard') then 'Avs='||(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) ||' CID='||(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)||' 3ds='||(select verify_en_status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2)|| ' ARN='||response_code_3
      when payment_service_id = 'worldpay' and payment_method_id in ('Visa', 'MasterCard') then 'Avs='||(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) ||' CID='||(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)||' 3ds='||(select verify_en_status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2)|| ' ARN='||(select distinct substr(custom_data, instr(custom_data, 'ARN=',1,1) + length('ARN='), (instr(custom_data, chr(10),instr(custom_data, 'ARN=',1,1),1)) - (instr(custom_data, 'ARN=',1,1) + length('ARN='))) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed' and request_money_amount > 0 and rownum < 2)
      when payment_service_id = 'firstdata' and payment_method_id in ('Visa', 'MasterCard') then 'Avs='||(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) ||' CID='||(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)||' 3ds='||(select verify_en_status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2)|| ' ARN='||substr(custom_data, instr(custom_data, 'Transaction Reference=',1)+22, 23)
      else 'Avs='||(select response_code_2 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) ||' CID='||(select response_code_3 from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2)||' 3ds='||(select verify_en_status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and rownum < 2) end)fraud_rev
      ,merchant_descriptor
      ,(select request_money_amount from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2)refund_amount
      ,division_site_id
      ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is not null then 'Refunded' else 'Not Refunded' end)refund_status
      ,request_money_amount
      ,(case when transaction_type = 'ChargeBack' and payment_service_id = 'litle' and response_code_3 = 'ARBITRATION_CHARGEBACK' then 'Bad'
      when transaction_type = 'ChargeBack' and payment_service_id = 'mes' and payment_method_id in ('Visa','MasterCard') and secondary_number = 'N' then 'Bad'
      when transaction_type = 'ChargeBack' and payment_service_id = 'firstdata' and payment_method_id in ('Visa','MasterCard') and substr(custom_data, instr(custom_data, 'Second Chargeback Date=',1,1) + 23,(instr(custom_data, 'Record Type=',1,1) - (24 + instr(custom_data, 'Second Chargeback Date=',1,1)))) is not null then 'Bad'
      when transaction_type = 'ChargeBack' and payment_service_id not in ('litle','firstdata','mes') and creation_date > (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Bad'
      when transaction_type = 'RFI' and payment_service_id = 'firstdata' and payment_method_id in ('MasterCard','Visa') then 'Bad'
      when transaction_type = 'RFI' and status = 'Completed' and payment_service_id = 'paypalExpress' then 'Bad'
      when transaction_type = 'ChargeBackNotice' and payment_service_id = 'worldpay' then 'Bad'
      else 'Good' end)PreArb_Status
#select *
from eq2admin.rcn_payment_transaction rpt

where cpg_creation_date between '2024-02-25' and '2024-02-26'
and transaction_type in ('ChargeBack','RFI', 'ChargeBackNotice')
and status in ('New', 'Completed','Pending','Requested')
and division_id = 'element5'
and response_code not in  ('Fraud','71')

order by processor

)BD

where PreArb_Status = 'Good'
