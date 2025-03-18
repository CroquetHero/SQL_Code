select site_id
      ,day
      ,payment_type
      ,cb_status
      ,Refund_Status
      ,amount
      ,count(units)units
    --  ,sum(amount/(select exchange_rate from pmt_exchange_rate where aa.currency = to_currency and day between effective_date and expiration_date))usd

from

(
select site_id
      ,trunc(creation_date)day
      ,(case when (select requisition_id from frd_dispute_order_activity where nn.requisition_id = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then 'CB' else 'No CB' end)CB_Status
      ,requisition_id units
      ,(select card_type from pmt_payment_Transaction where nn.requisition_id = requisition_id and rownum < 2)payment_type
      --,(select request_amount from pmt_payment_Transaction where nn.requisition_id = requisition_id and rownum < 2)amount
     -- ,(select request_currency from pmt_payment_Transaction where nn.requisition_id = requisition_id and rownum < 2)currency
      ,(case when (select requisition_id from ntf_notification where nn.requisition_id = requisition_id and event_name = 'User Refund Confirmation' and rownum < 2) is not null then 'Refund' else 'No Refund' end)Refund_Status
      ,(select total_num_usd from req_requisition where nn.requisition_id = requisition_id)amount
      
from ntf_notification nn
where event_name = 'User Return LOD event'
and nn.creation_date between trunc(sysdate) - 40 and trunc(sysdate) - 20
--and requisition_id = '14295286328'
)aa
where payment_type in ('Visa', 'MasterCard', 'visa', 'masterCard')

group by site_id
      ,day
      ,cb_status
      ,Refund_Status
      ,payment_type
      ,amount