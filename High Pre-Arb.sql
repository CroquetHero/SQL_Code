select division_order_id order_id
        ,reference_number
        ,payment_service_id processor
        ,payment_method_id
        ,division_site_id site_id
        ,request_money_amount amount
        ,response_code_1 cb_code
        ,trunc(creation_date)cb_date

from cpg_payment_transaction rpt

where creation_date > trunc(sysdate)
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id in ('mes', 'firstdata','litle')
and payment_method_id in ('MasterCard', 'Visa')
and division_id = 'pacific'
and request_money_amount > 300
and trunc(creation_date) > (select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and request_money_amount > 300)

order by creation_date,division_order_id