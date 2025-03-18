select paymentmethodid
,paymentserviceid
,Dif_Decline_Code
,order_date
,count(transactionid)units

from
(
select bin
,paymentmethodid
,paymentserviceid
,(select distinct first_value(responsecode1) over (order by transactionid) from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid and responsecode1 not in  ('27054','302'))Dif_Decline_Code
,(select newstatus from EREPORT.cpg_transactions where subscriptionid = ct.subscriptionid and subsegmentid = ct.subsegmentid and newstatus = 'Completed')Sub_status
,renewattnum
,trunc(orderdate)order_date
,transactionid
,rank() over (partition by subscriptionid order by divisionorderid)Calendar_attempt

--select *
from EREPORT.cpg_transactions ct

where creationdate > '9/1/2018'
and transactiontype = 'Authorize'
and subscriptionid is not null
and responsecode1 in ('27054','302')

)

where Calendar_attempt = '1'
and renewattnum = '1'

group by paymentmethodid
,paymentserviceid
,Dif_Decline_Code
,order_date