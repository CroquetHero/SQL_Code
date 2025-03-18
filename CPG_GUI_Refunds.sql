select division_order_id
        ,payment_method_id
        ,request_money_amount refund_amount
        ,request_money_currency currency
        ,(select sum(request_money_amount) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')settle_Total
        ,(select sum(request_money_amount) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')CB_Total
        ,(select sum(request_money_amount) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed')Reversal_Total
        ,(select sum(request_money_amount) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')Refund_Total

from cpg_Payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type = 'Refund'
and status = 'Completed'
and division_id = 'pacific'
and division_transaction_id like '%gui%'