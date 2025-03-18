select to_char(creation_date,'MM/YYYY')month
,response_code_1
,count(transaction_id)units
,sum(request_money_amount)amount
,response_message
--,request_money_currency

from cpg_payment_transaction

where creation_date between '1/1/2013' and '10/1/2017'
and transaction_type in ('Authorize')
and status = 'Declined'
and division_site_id = 'PUB25694:STR55652'

group by response_code_1
,to_char(creation_date,'MM/YYYY')
,response_message
