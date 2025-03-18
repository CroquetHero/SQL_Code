select division_order_id
        ,trunc(creation_date)rfi_date
        ,division_site_id
        ,request_money_amount usd
        ,response_code_2

from cpg_payment_transaction rpt

where creation_date > trunc(sysdate) - 3
and transaction_type = 'RFI'
and status in ('Pending', 'New')
and payment_service_id = 'paypalExpress'
and request_money_amount > 300
and request_money_currency = 'USD'
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'RFI' and status = 'Completed' and rownum < 2) is null
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is null
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed' and rownum < 2) is null
