select division_order_id
,bank_code
,authorization_code
,division_site_id
,merchant_number
,trunc(creation_date)rfi_date
,request_money_amount
,request_money_currency
,rank() over (partition by division_Order_id order by transaction_id)RFI_Num
,response_code_2
,response_message
,substr(custom_data, instr(custom_data,'BuyerComt=',1,1)+10,(instr(custom_data,chr(10),instr(custom_data,'BuyerComt=',1,1),1)) -(instr(custom_data,'BuyerComt=',1,1)+10))customer_Complaint
,custom_data

from cpg_payment_transaction rpt

where creation_date between trunc(sysdate) - 1 and trunc(sysdate) 
and transaction_type = 'RFI'
and payment_service_id = 'paypalExpress'
--and division_site_id = 'nvidia'
--and creation_date = (select max(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'RFI')
and response_message in ('Waiting For Seller''s Response','Open','Waiting for Shipment Tracking Information')
and custom_data like '%shipto.name%'
