select carrier_id
        ,fulfiller_id
        ,shipping_method
        ,Ship_day
        ,site_id
        ,cb_status
        ,count(ORDER_ID)units
        
        from
(
select distinct requisition_id ORDER_ID
        ,carrier_id
        ,fulfiller_id
        ,shipping_method
        ,to_char(date_shipped,'MM/DD/YYYY')Ship_day
        ,site_id
        ,(case when (select reason from frd_dispute_order_activity where ssn.requisition_id = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) is not null then  (select reason from frd_dispute_order_activity where ssn.requisition_id = requisition_id and status = 'STATUS_DISPUTE_CHARGE_BACK' and rownum < 2) else 'No CB' end)cb_status

from shP_shipment_notice ssn

where modification_date between '1/1/2016' and '4/1/2016'
and creation_date > '1/1/2016'
--and carrier_id in ('FDE','FXFE','FEDEX','F2','FP','F1','f2','15','FedEx','FDE3')--'FG'FH')
and site_id not in ('msca', 'msusa','msde','mseea','mseea1','msfr','msuk','msaus','msjp','msnz','mssg')
--and site_id = 'samsung'
--and carrier_id  ='IPDI'

)

group by carrier_id
        ,fulfiller_id
        ,shipping_method
        ,Ship_day
        ,site_id
        ,cb_status