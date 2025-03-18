select issuercountry
--,bin
,card_status
,dateincrement
,addedexpiryyears
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
,addedexpiryyears
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
,(case when (exp_date - order_date) < 0 then 'Expired' else 'Valid' end)card_status
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
,addedexpiryyears
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

where creationdate > '12/1/2018'
and transactiontype = 'Authorize'
and subscriptionid is not null
and renewattnum is not null
and oldstatus = 'New'
and expirationdate is not null
and expirationdate not in ('0000')
--and bin in ('403216','406041','406095','407166','419162','427082','429672','429819','453081','453091','453093','476367','514735','514891','516289','518652','522704','529021','534466','537800','540222','542011','542598','544927','544928','545140','545460','546645','547676','548006','552085','552213','552322','552393','556362','558346','559309')
and renewattnum in ('1')--,'3','2')
and paymentmethodid in ('AmericanExpress','Visa','Discover','MasterCard')
--and (case when substr(expirationdate,0,1) = '0' then substr(expirationdate,2,1) else substr(expirationdate,0,2) end) not in ('1','2','3','4','5','6','7','8','9','10','11','12')
--and dateincrement is not null
and issuercountry in ('AE','AR','BH','BR','BY','CL','CN','CO','CR','CZ','DK','EC','EG','ES','FI','GR','GT','HK','HU','ID','IL','IN','JO','KR','KW','KZ','LB','LU','LV','MY','NG','NO','NZ','OM','PA','PE','PH','PL','QA','RU','SK','TT','ZA')

)

--where issuercountry = 'AR'
--and paymentmethodid = 'Visa'
--and card_source = 'Credit'
--and card_class = 'Consumer'

)

where cpg_attempt = '1'

group by issuercountry
--,bin
,card_status
,newstatus
,dateincrement
,order_date
,addedexpiryyears
