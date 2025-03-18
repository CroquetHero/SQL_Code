select division_order_id
,substr(custom_data, instr(custom_data, 'fundingSource=',1,1) + length('fundingSource='), (instr(custom_data, chr(10),instr(custom_data, 'fundingSource=',1,1),1)) - (instr(custom_data, 'fundingSource=',1,1) + length('fundingSource=')))fundingSource
,substr(custom_data, instr(custom_data, 'fundingSource=',1,2) + length('fundingSource='), (instr(custom_data, chr(10),instr(custom_data, 'fundingSource=',1,2),1)) - (instr(custom_data, 'fundingSource=',1,2) + length('fundingSource=')))Adyen_fundingSource
,substr(custom_data, instr(custom_data, 'countryID=',1,1) + length('countryID='), (instr(custom_data, chr(10),instr(custom_data, 'countryID=',1,1),1)) - (instr(custom_data, 'countryID=',1,1) + length('countryID=')))countryID
,substr(custom_data, instr(custom_data, 'issuerCountry=',1,1) + length('issuerCountry='), (instr(custom_data, chr(10),instr(custom_data, 'issuerCountry=',1,1),1)) - (instr(custom_data, 'issuerCountry=',1,1) + length('issuerCountry=')))Adyen_countryID

from cpg_payment_transaction

where creation_date > '10/1/2019'
and transaction_type = 'Authorize'
and status = 'Completed'
and payment_service_id = 'adyen'
and payment_method_id in ('MasterCard','Visa','AmericanExpress','Discover')
and test_mode <> 12