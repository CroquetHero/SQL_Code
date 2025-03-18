select division_order_id
,substr(message, instr(message, 'houseNumberOrName',1,1) + length('houseNumberOrName') + 4,(instr(message, chr(10),instr(message, 'houseNumberOrName',1,1),1)) - (instr(message, 'houseNumberOrName',1,1) + length('houseNumberOrName')) - 6)Adyen_houseNumberOrName
,substr(message, instr(message, 'street',1,1) + length('street') + 4,(instr(message, chr(10),instr(message, 'street',1,1),1)) - (instr(message, 'street',1,1) + length('street')) - 6)Adyen_street
,substr(message, instr(message, 'city',1,1) + length('city') + 4,(instr(message, chr(10),instr(message, 'city',1,1),1)) - (instr(message, 'city',1,1) + length('city')) - 6)Adyen_city
,substr(message, instr(message, 'stateOrProvince',1,1) + length('stateOrProvince') + 4,(instr(message, chr(10),instr(message, 'stateOrProvince',1,1),1)) - (instr(message, 'stateOrProvince',1,1) + length('stateOrProvince')) - 6)Adyen_stateOrProvince
,substr(message, instr(message, 'postalCode',1,1) + length('postalCode') + 4,(instr(message, chr(10),instr(message, 'postalCode',1,1),1)) - (instr(message, 'postalCode',1,1) + length('postalCode')) - 5)Adyen_postalCode
,substr(message, instr(message, 'country',1,1) + length('country') + 4,(instr(message, chr(10),instr(message, 'country',1,1),1)) - (instr(message, 'country',1,1) + length('country')) - 6)Adyen_Country
,substr(message, instr(message, 'enhancedSchemeData.totalTaxAmount',1,1) + length('enhancedSchemeData.totalTaxAmount') + 4,(instr(message, chr(10),instr(message, 'enhancedSchemeData.totalTaxAmount',1,1),1)) - (instr(message, 'enhancedSchemeData.totalTaxAmount',1,1) + length('enhancedSchemeData.totalTaxAmount')) - 6)Total_Tax_Amount
,substr(message, instr(message, 'enhancedSchemeData.customerReference',1,1) + length('enhancedSchemeData.customerReference') + 4,(instr(message, chr(10),instr(message, 'enhancedSchemeData.customerReference',1,1),1)) - (instr(message, 'enhancedSchemeData.customerReference',1,1) + length('enhancedSchemeData.customerReference')) - 6)Customer_Reference
,(select distinct first_value(substr(message, instr(message, 'avsResult',1,1) + length('avsResult') + 4,(instr(message, chr(10),instr(message, 'avsResult',1,1),1)) - (instr(message, 'avsResult',1,1) + length('avsResult')) - 6)) over (order by creation_date) from cpg_log where division_order_id = cl.division_order_id and logger_name = 'support.cpg.adyen' and source_method_name = 'processAuthResponse' and log_level = 'INFO' )Adyen_avsResult
,(select distinct first_value(substr(message, instr(message, 'avsResultRaw',1,1) + length('avsResultRaw') + 4,(instr(message, chr(10),instr(message, 'avsResultRaw',1,1),1)) - (instr(message, 'avsResultRaw',1,1) + length('avsResultRaw')) - 6)) over (order by creation_date) from cpg_log where division_order_id = cl.division_order_id and logger_name = 'support.cpg.adyen' and source_method_name = 'processAuthResponse' and log_level = 'INFO' )Adyen_avsResultRaw
,(select distinct first_value(substr(message, instr(message, 'cvcResultRaw',1,1) + length('cvcResultRaw') + 4,(instr(message, chr(10),instr(message, 'cvcResultRaw',1,1),1)) - (instr(message, 'cvcResultRaw',1,1) + length('cvcResultRaw')) - 6)) over (order by creation_date) from cpg_log where division_order_id = cl.division_order_id and logger_name = 'support.cpg.adyen' and source_method_name = 'processAuthResponse' and log_level = 'INFO' )Adyen_cvcResultRaw
,message

--select *
from cpg_log CL

where division_order_id = '15496367238'
--and creation_date between trunc(sysdate) - 1 and  trunc(sysdate)
and log_level = 'FINE'
and source_method_name = 'submitRequest'
and logger_name = 'support.cpg.adyen'
