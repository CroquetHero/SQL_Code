select *

from
(
select requisition_id
        ,card_type
        ,(case when (select action_performed from req_requisition_log where ppt.requisition_id = requisition_id and action_performed = 'CANCEL_ORDER' and rownum < 2) is not null then 'Cancelled' else 'Not Cancelled' end)cancel_status
        ,(case when (select transaction_type from pmt_payment_transaction where ppt.requisition_id = requisition_id and transaction_type = 'BankPaymentCredit' and status = 'Completed' and rownum < 2) is not null then 'Refunded' else 'Not Refunded' end)refund_status

from pmt_payment_transaction ppt

where creation_date between trunc(sysdate) - 15 and trunc(sysdate) - 13
and transaction_type = 'ClearFunds'
and status = 'Completed'
and card_type in ('PayPalExpressCheckout','PayPalExpress')

)

where cancel_status = 'Cancelled'