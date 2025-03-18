select responsemessage
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,renewattnum
,newstatus
,(select distinct prod_dur from EREPORT.SUB_AUTH_ADDITIONAL_INFO where subscriptionid = subscription_id)Prod_dur
,divisionorderid
,subscriptionid
,creationdate
,orderdate

from ereport.cpg_transactions

where transactiontype = 'Authorize'
and subscriptionid in 
(
select distinct subscriptionid
from EREPORT.cpg_transactions ct

where creationdate > '7/1/2018'
--and divisionsiteid = 'avgstore'
and subscriptionid is not null
and paymentserviceid in ('firstdata','litle','mes')
--and paymentmethodid = 'MasterCard'
and transactiontype = 'AccountUpdate'
and responsemessage = 'Account closed'

)

group by responsemessage

order by units desc