select cancel_date
        ,type
        ,site_id
        ,refund_status
        ,cb_status
        ,count(requisition_id)units

from
(select trunc(icr.creation_date)cancel_date
        ,icr.type
        ,icr.site_id
        ,(select payment_service_id from pmt_payment_transaction where icr.requisition_id = requisition_id and transaction_type = 'ClearFunds' and status = 'Completed' and rownum < 2)payment_type
        ,(case when icr.total <= 0 then 'No Refund' else 'Refunded' end)refund_status
        ,(case when (select status from frd_dispute_order_activity where icr.requisition_id = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
        ,icr.requisition_id

from inv_cancel_request icr

where icr.creation_date between '1/1/2016'  and sysdate
and icr.modification_date between '1/1/2016' and sysdate
and type not in ('EXPIRED_ORDER')
--and site_id = 'ubiemea'
--and icr.requisition_id = '10119344959'
)
where payment_type = 'PayPal'

group by cancel_date
        ,type
        ,site_id
        ,refund_status
        ,cb_status