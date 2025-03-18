select auth_date
,newstatus
,divisionsiteid
,midcategory
,card_source
,card_class
,import_flag
,count(divisionorderid)units
--select paymentcurrency,newstatus,count(divisionorderid)units

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
,paymentcurrency
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,midcategory
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
,(select distinct imported from EREPORT.SUB_auth_ADDITIONAL_INFO where subscriptionid = subscription_id)import_flag
,(select count(subscriptionid) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id and subscription_type_code = 'RENEWED')Renew_Count
,(select distinct first_value(contract_term_code) over (order by sub_seg_expire_key desc) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id)Sub_length
,(select distinct first_value(trunc(src_create_dttm)) over (order by platform_order_id desc) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id)Last_Comp_Date
,(select distinct first_value(subscription_type_code) over (order by sub_seg_expire_key) from SUB_SEG_EXPIRE_DNORM where subscriptionid = subscription_id)Sub_type

--select *
from EREPORT.cpg_transactions ct

where creationdate between '11/1/2018' and sysdate
and transactiontype = 'Authorize'
--and divisionsiteid in ('avast','avgstore','avgbr','avastbr')
--and subscriptionid is not null
--and renewattnum = '1'
and paymentmethodid = 'MasterCard'
and paymentserviceid = 'firstdata'
--and paymentmethodid in ('Visa','Discover','AmricanExpress','MasterCard')

)
where cpg_attempt = '1'
and newstatus in ('Completed','Declined')

group by auth_date
,newstatus
,divisionsiteid
,midcategory
,card_source
,card_class
,import_flag
