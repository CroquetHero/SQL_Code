select trunc(creation_date)day
      ,count(request_money_currency)units
--select *
from cpg_payment_transaction rpt

where creation_date between  trunc(sysdate) - 42 and trunc(sysdate) - 1
and transaction_type = 'Authorize'
and status = 'Completed'
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is null
and division_id = 'pacific'
and payment_method_id in ('MasterCard', 'Visa', 'AmericanExpress', 'Discover')
and response_money_amount > 10
and division_site_id = 'avast'

group by  trunc(creation_date)

order by day