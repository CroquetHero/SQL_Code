select to_char(creation_date,'MM/YYYY')month
        ,response_code_1
        ,response_message
        ,count(transaction_id)units
        ,sum(request_money_amount)amount
        ,request_money_currency

from cpg_payment_transaction rpt

where creation_date between '1/1/2017' and '3/1/2017'
and transaction_type = 'Settle'
and status = 'Failed'
--and merchant_number = 'atlanticpaypal@digitalriver.com'
and (select count(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and request_money_amount = rpt.request_money_amount and transaction_type = 'Authorize') = 1
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and request_money_amount = rpt.request_money_amount and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) is not null
and (select count(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and request_money_amount = rpt.request_money_amount and transaction_type = 'Settle') = 1

group by response_code_1,request_money_currency,to_char(creation_date,'MM/YYYY'),response_message

order by units desc