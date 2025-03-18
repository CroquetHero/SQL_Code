select settle_date
        ,payment_processor_name
        ,payment_method_id
        ,payment_amount
        ,cb_status
        ,refund_status
        ,count(cpg_transaction_id)units
        
        from
(
select trunc(cpg_creatioN_date)settle_date
        ,payment_processor_name
        ,payment_method_id
        ,payment_amount
        ,cpg_transaction_id
        ,(case when (select min(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed') is not null then 'Refund' else 'No Refund' end)refund_status
        ,(case when (select min(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') is not null then 'CB' else 'No CB' end)CB_status

from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type = 'Settle'
and status = 'Completed'
and division_site_id = 'avast'
and payment_processor_name in ('mes', 'firstdata')
and payment_method_id in ('Visa', 'MasterCard')
and payment_amount > 100

)

group by settle_date
        ,payment_processor_name
        ,payment_method_id
        ,payment_amount
        ,cb_status
        ,refund_status
        