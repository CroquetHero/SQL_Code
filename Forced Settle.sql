select to_char(creation_date, 'MM/YYYY')Month
,transaction_type
,status
,merchant_descriptor
,division_site_id
,payment_method_id
,payment_service_id
,count(transaction_id)units
,sum(request_money_amount)amount
,request_money_currency
--,(select count(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle')Settle_units
--,(select distinct first_value(status) over (order by creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and creation_date < rpt.creation_date and transaction_type = 'Settle')Settle_status

from cpg_payment_transaction rpt

where creation_date between '10/1/2019' and '11/1/2019'
and transaction_type = 'Authorize'
and payment_method_id in ('Visa','Discover','MasterCard','AmericanExpress')
and payment_service_id not in ('adyen','litle','mes','firstdata')
and transaction_id > (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and division_id = rpt.division_id and transaction_type = 'Authorize')
and creation_date > (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and division_id = rpt.division_id and transaction_type = 'Settle')
and status = 'Declined'


group by to_char(creation_date, 'MM/YYYY')
,transaction_type
,status
,merchant_descriptor
,division_site_id
,request_money_currency
,payment_method_id
,payment_service_id