select bin
,issuercountry
,paymentmethodid
,dateincrement
,order_date
--,paymentserviceid
--,First_Message
--,First_processor
,newstatus
,count(transactionid)units
--select *
from
(
select paymentmethodid || '-' || issuercountry || '-' || card_source || '-' || card_class Country_Source
--,card_status
,renewattnum
,cpg_attempt
,dateincrement
,paymentserviceid
,issuercountry
,paymentmethodid
,bin
,import_flag
,order_date
--,First_message
--,(case when order_date <= '9/12/2018' then 'Pre' else 'Post' end)date_type
--,paymentmethodid
--,issuercountry
--,divisionsiteid
,card_status
--,(case when (exp_date - order_date) < 0 then 'Expired' else 'Valid' end)card_status
,(select responsemessage from EREPORT.cpg_transactions where transactionid = First_Transaction)First_Message
,(select paymentserviceid from EREPORT.cpg_transactions where transactionid = First_Transaction)First_processor
,newstatus
,transactionid
,divisionorderid
,subscriptionid
--,count(transactionid)units
--select *
from
(
select bin
,dateincrement
,paymentmethodid
,paymentserviceid
,issuercountry
,newstatus
,divisionsiteid
,(select min(transactionid) from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid)First_Transaction
--,(select distinct first_value(responsemessage) over (order by transactionid) from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid)First_message
,(case when (select newstatus from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid and newstatus = 'Completed' and rownum < 2) is not null then 'Completed' else 'Declined' end)order_status
,renewattnum
,(case when dateincrement is null then 'Valid' else 'Expired' end)card_status
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,transactionid
,divisionorderid
,subscriptionid
,expirationdate
,(select imported from EREPORT.SUB_AUTH_ADDITIONAL_INFO where requisition_id = ct.divisionorderid and rownum < 2)import_flag
--,(case when substr(expirationdate,0,1) = '0' then substr(expirationdate,2,1) else substr(expirationdate,0,2) end)
,to_date((case when substr(expirationdate,0,1) = '0' then substr(expirationdate,2,1) else substr(expirationdate,0,2) end) || '/1/' || '20' || substr(expirationdate,length(expirationdate)-1,2),'MM/DD/YYYY','NLS_DATE_LANGUAGE = American')exp_date
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate > '1/1/2018'
and trunc(orderdate) > '1/1/2018'
and transactiontype = 'Authorize'
and subscriptionid is not null
and renewattnum is not null
and oldstatus = 'New'
and bin = '401795'
--and expirationdate is not null
--and expirationdate not in ('0000')
and renewattnum in ('1')--,'3','2')
and paymentmethodid in ('AmericanExpress','Visa','Discover','MasterCard')
--and (case when substr(expirationdate,0,1) = '0' then substr(expirationdate,2,1) else substr(expirationdate,0,2) end) not in ('1','2','3','4','5','6','7','8','9','10','11','12')
and dateincrement is not null

)

--where paymentmethodid = 'Visa'
--and issuercountry = 'US'
--and card_source = 'Credit'
--and card_class = 'Business'

)

where cpg_attempt = '1'

group by bin
,issuercountry
,paymentmethodid
,dateincrement
,newstatus
,order_date
