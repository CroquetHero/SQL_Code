select *

from
(
select display_name
        ,trunc(rli.creation_date)settle_date
        ,trunc(rli.modification_date)mod_date
        ,requisition_id
        ,(case when (select requisition_id from frd_dispute_order_activity where rli.requisition_id = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then 'CB' else 'No CB' end)CB_Status
        ,(select card_type from pmt_payment_Transaction where rli.requisition_id = requisition_id and rownum < 2)payment_type
        ,(case when (select requisition_id from ntf_notification where rli.requisition_id = requisition_id and event_name = 'User Refund Confirmation' and rownum < 2) is not null then 'Refund' else 'No Refund' end)Refund_Status
        ,(select total_num_usd from req_requisition where rli.requisition_id = requisition_id)amount
     
        from req_line_item rli, cat_product_data cpd
        
        where cpd.product_data_id = rli.product_data_id
        and rli.modification_date > trunc(sysdate) - 10
        and rli.creation_date between trunc(sysdate) - 10 and trunc(sysdate) - 9
        and rli.product_data_id in ('6356526700','6356527400','6356528100','6356528800','6356529500','6356530200')
        
        )
        
      where payment_type in ('Visa', 'MasterCard', 'visa', 'masterCard') 
      
      