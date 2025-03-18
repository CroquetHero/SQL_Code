select Country_Source
,dateincrement
,First_Date_Increment
,newstatus
,count(transactionid)units

from
(
select paymentmethodid || '-' || issuercountry || '-' || card_source || '-' || card_class Country_Source
--,bin
,cpg_attempt
,renewattnum
,dateincrement
,(select distinct first_value(dateincrement) over (order by transactionid) from EREPORT.cpg_transactions where transactionid = bd.first_transaction_id)First_Date_Increment
--,(case when order_date <= '9/12/2018' then 'Pre' else 'Post' end)date_type
--,paymentmethodid
--,issuercountry
,newstatus
,transactionid

from
(
select bin
,dateincrement
,paymentmethodid
,paymentserviceid
,issuercountry
,newstatus
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,(select distinct first_value(transactionid) over (order by transactionid) from EREPORT.cpg_transactions where ct.divisionorderid = divisionorderid)first_transaction_id
,renewattnum
,trunc(orderdate)order_date
,transactionid
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select divisionorderid,newstatus,divisionsiteid,paymentserviceid
from EREPORT.cpg_transactions ct

where creationdate > '10/1/2017'
and transactiontype = 'Authorize'
and subscriptionid is not null
--and bin in ('403216','406041','406095','407166','419162','427082','429672','429819','453081','453091','453093','476367','514735','514891','516289','518652','522704','529021','534466','537800','540222','542011','542598','544927','544928','545140','545460','546645','547676','548006','552085','552213','552322','552393','556362','558346','559309')
and renewattnum = '1'
and dateincrement is not null

)BD

where cpg_attempt = '2'
--and bin = '425907'

)

group by Country_Source
,dateincrement
,First_Date_Increment
,newstatus