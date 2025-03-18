select divisionorderid
,subscriptionid
,auth_date
,newstatus OneDotOne_Status
,paymentserviceid
,paymentmethodid
,divisionsiteid
,midcategory
,(case when Last_Comp_Date >= auth_date then 'Completed' else 'Declined' end)Sub_status
,(case when (select status from rcn_payment_transaction where New_Requisition_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum< 2) is not null then 'CB'
when New_Requisition_id is null then 'N/A'
else 'No CB' end)cb_status
,New_Requisition_id
,Prev_Order_ID

from
(
select divisionorderid
,subscriptionid
,trunc(creationdate)auth_date
,newstatus
,paymentserviceid
,paymentmethodid
,divisionsiteid
,issuercountry
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,midcategory
,(select distinct first_value(trunc(src_create_dttm)) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id)Last_Comp_Date
,(select distinct first_value(platform_order_id) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id and trunc(src_create_dttm) >= trunc(creationdate))New_Requisition_id 
,(select distinct first_value(platform_order_id) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id and trunc(src_create_dttm) < trunc(creationdate))Prev_Order_ID 

--select *
from EREPORT.cpg_transactions ct

where creationdate between '7/1/2018' and '9/2/2018'
and transactiontype = 'Authorize'
and divisionsiteid in ('tmemea','tmecon')
and subscriptionid is not null
and renewattnum = '1'
and dateincrement is not null

)
where cpg_attempt = '1'
