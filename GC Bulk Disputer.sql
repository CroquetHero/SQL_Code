select distinct division_order_id
,response_code_1

from cpg_payment_transaction

where creation_date between trunc(sysdate) - 1 and trunc(sysdate)
and transaction_type in ('ChargeBack','ChargeBackNotice','RFI')
and status in ('Completed','New','Cancelled','Pending')
and division_id = 'pacific'
