select distinct requisition_id
        ,tracking_number
        ,to_char(creation_date,'MM/DD/YYYY')day
        ,site_id
select *
from shP_shipment_notice

where modification_date > sysdate - 10
and creation_date > sysdate - 10
and carrier_id = '15'
and site_id not in ('targusus')