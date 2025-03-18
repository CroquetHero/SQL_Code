select divisionsiteid
,Auth_Date
,Sub_Start_Type
,refund_status
,cb_status
,count(divisionorderid)units

from
(
select divisionorderid
,divisionsiteid
,Auth_Date
,subscriptionid
,Sub_Start_Type
,(case when (select status from rcn_payment_transaction where division_order_id = Big_Data.divisionorderid and transaction_type = 'Refund' and status = 'Completed' and rownum < 2)is not null then 'Refund' else 'No Refund'end)refund_status
,(case when (select status from rcn_payment_transaction where division_order_id = Big_Data.divisionorderid and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2)is not null then 'CB' else 'No CB'end)CB_status

from 
(
select divisionorderid
,divisionsiteid
,trunc(creationdate)Auth_Date
,subscriptionid
,(select distinct first_value(subscription_type_code) over (order by row_FIRST_etl_dttm) from SUB_SEG_EXPIRE_DNORM where subscription_id = ct.subscriptionid)Sub_Start_Type

from ereport.cpg_transactions ct

where creationdate between '7/1/2017' and '8/1/2017'
and paymentserviceid = 'paypalExpress'
and subscriptionid is not null
and newstatus = 'Completed'

)Big_Data

)

group by divisionsiteid
,Auth_Date
,Sub_Start_Type
,refund_status
,cb_status
