select site_id
        ,auth_date
        ,card_type
        ,product_name
        ,LOD_Status
        ,CB_Status
        ,sum(list_price_num)usd
        ,count(requisition_id)units
        
        from
(
select rli.requisition_id
        ,rli.site_id
        ,to_char(rli.creation_date, 'MM/DD/YYYY')auth_date
        ,(select display_name from cat_product_data where rli.product_data_id = product_data_id and rownum < 2)product_name
        ,rli.list_price_num
        ,(select card_type from pmt_payment_transaction where requisition_id = rli.requisition_id and transaction_type = 'Settle' and rownum < 2)card_type
        ,(case when (select action_performed from req_requisition_log where requisition_id = rli.requisition_id and action_performed = 'LOD_REFUND' and rownum < 2) is not null then 'LOD Refund'
                when (select action_performed from req_requisition_log where requisition_id = rli.requisition_id and action_performed = 'LOD_APPROVE' and rownum < 2) is not null then 'LOD Approved'
                else 'LOD Attempt' end)LOD_Status
        ,(case when (select status from frd_dispute_order_activity where requisition_id = rli.requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK'and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
                

from req_line_item rli,  req_requisition_log rrl

where rrl.requisition_id = rli.requisition_id
and rli.site_id = 'avast'
and rli.modification_date > '7/15/2015'
and rli.creation_date between '7/15/2015' and '7/16/2015'
and rli.list_price_currency = 'USD'
and action_performed = 'SYSTEM_SENT_NOTIFICATION' 
and reason = 'User Return LOD event'
--and ppt.merchant_id in ('941000108061_00000004','311009012882')
)
where card_type is not null

group by site_id
        ,auth_date
        ,product_name
        ,LOD_Status
        ,CB_Status
        ,card_type
        