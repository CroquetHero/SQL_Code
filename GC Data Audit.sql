select distinct requisition_id, trunc(modification_date)cb_date

from frd_dispute_order_activity

where status = 'STATUS_DISPUTE_CHARGE_BACK'
and requisition_id in