select division_order_id
,trunc(creation_date)day
,trunc(order_date)order_date
,(case when division_id <> 'pacific' then division_id else division_site_id end)division_site_id
,payment_method_id
,request_money_amount amount
,request_money_currency Currency
,billing_address_country_id Bill_Country
,substr(custom_data, instr(custom_data, 'midCategory=',1,1) + length('midCategory='), (instr(custom_data, chr(10),instr(custom_data, 'midCategory=',1,1),1)) - (instr(custom_data, 'midCategory=',1,1) + length('midCategory=')))midCategory
,substr(custom_data, instr(custom_data, 'subscriptionID=',1,1) + length('subscriptionID='), (instr(custom_data, chr(10),instr(custom_data, 'subscriptionID=',1,1),1)) - (instr(custom_data, 'subscriptionID=',1,1) + length('subscriptionID=')))subscriptionID
,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)CB_Status
,(select min(trunc(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')CB_Date
,(select count(status) from cpg_payment_transaction cpt where account_token = rpt.account_token and division_order_id <> rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and division_site_id = rpt.division_site_id and creation_date between rpt.creation_date - 120 and rpt.creation_date)Sub_Count
,(select count(status) from cpg_payment_transaction cpt where account_token = rpt.account_token and division_order_id <> rpt.division_order_id and transaction_type = 'ChargeBackNotice' and status = 'Completed' and division_site_id = rpt.division_site_id and creation_date > rpt.creation_date and response_code_1 = 'Fraud' and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'ChargeBackNotice' and status = 'Completed' and response_code_1 = 'Fraud'))Fraud_Sub_Count
,(select count(status) from cpg_payment_transaction cpt where account_token = rpt.account_token and division_order_id <> rpt.division_order_id and transaction_type = 'ChargeBackNotice' and status = 'Completed' and division_site_id = rpt.division_site_id and creation_date > rpt.creation_date and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'ChargeBackNotice' and status = 'Completed'))CBN_Sub_Count
,(select count(status) from cpg_payment_transaction cpt where account_token = rpt.account_token and division_order_id <> rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and division_site_id = rpt.division_site_id and creation_date > rpt.creation_date and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed'))CB_Sub_Count
,(select count(status) from cpg_payment_transaction cpt where account_token = rpt.account_token and division_order_id <> rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and division_site_id = rpt.division_site_id and creation_date > rpt.creation_date)Refund_Sub_Count

from cpg_payment_transaction rpt

where creation_date > '10/1/2019'
and transaction_type = 'ChargeBackNotice'
and status = 'Completed'
and payment_service_id = 'adyen'
and response_code_1 = 'Fraud'
and transaction_id = (select min(transaction_id) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'ChargeBackNotice' and status = 'Completed')
