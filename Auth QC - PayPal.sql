select divisionsiteid
,auth_Rate
,units Yest_attempts
,mean
,days
,attempts
,ratio

from
(
select yest_Data.divisionsiteid
,yest_Data.auth_Rate
,yest_Data.units
,Prev_Data.mean
,Prev_Data.days
,Prev_Data.attempts
,(Prev_Data.mean - (3*Prev_Data.STD))LCL
,round(((yest_Data.auth_Rate - Prev_Data.mean)/Prev_Data.STD),3)ratio
--select *
from
(
select yest_all.divisionsiteid
,round(yest_comp.units/yest_all.units,3) auth_Rate
,yest_all.units

from
(
select divisionsiteid
,newstatus
,count(transactionid)units
--select *
from
(
select bin
,dateincrement
,addedexpiryyears
,paymentmethodid
,paymentserviceid
,divisionsiteid
,transactionid
,(case when issuercountry is null then billingcountry else issuercountry end)issuercountry
,newstatus
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate between trunc(sysdate) -1 and trunc(sysdate)
and transactiontype = 'Authorize'
--and subscriptionid is not null
and newstatus in ('Completed','Declined')
--and renewattnum = '1'
and paymentserviceid = 'paypalExpress'
--and addedexpiryyears is not null

)

where cpg_attempt = '1'
and newstatus  ='Completed'

group by divisionsiteid
,newstatus

)Yest_Comp

right join

(

select divisionsiteid
,count(transactionid)units
--select *
from

(
select bin
,dateincrement
,addedexpiryyears
,paymentmethodid
,paymentserviceid
,divisionsiteid
,transactionid
,(case when issuercountry is null then billingcountry else issuercountry end)issuercountry
,newstatus
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate between trunc(sysdate) -1 and trunc(sysdate)
and transactiontype = 'Authorize'
--and subscriptionid is not null
and newstatus in ('Completed','Declined')
--and renewattnum = '1'
and paymentserviceid = 'paypalExpress'
--and addedexpiryyears is not null
--and newstatus = 'Completed'

)

where cpg_attempt = '1'

group by divisionsiteid

)Yest_All

on yest_comp.divisionsiteid = yest_all.divisionsiteid

where yest_all.units > 30

)Yest_Data

left join

(
select divisionsiteid
,count(units)days
,sum(units)Attempts
,round(avg(auth_rate),3)mean
,round(stddev(auth_rate),3)STD

from
(
select yest_all.divisionsiteid
,yest_all.order_date
,round(yest_comp.units/yest_all.units,3) auth_Rate
,yest_all.units

from
(
select divisionsiteid
,newstatus
,order_date
,count(transactionid)units
--select *
from
(
select bin
,dateincrement
,addedexpiryyears
,paymentmethodid
,paymentserviceid
,divisionsiteid
,transactionid
,(case when issuercountry is null then billingcountry else issuercountry end)issuercountry
,newstatus
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate between trunc(sysdate) - 31 and trunc(sysdate) -1
and transactiontype = 'Authorize'
--and subscriptionid is not null
and newstatus in ('Completed','Declined')
--and renewattnum = '1'
and paymentserviceid = 'paypalExpress'
--and addedexpiryyears is not null

)

where cpg_attempt = '1'
and newstatus = 'Completed'

group by divisionsiteid
,newstatus
,order_date

)Yest_Comp

right join

(

select divisionsiteid
,order_date
,count(transactionid)units
--select *
from


(
select bin
,dateincrement
,addedexpiryyears
,paymentmethodid
,paymentserviceid
,divisionsiteid
,transactionid
,(case when issuercountry is null then billingcountry else issuercountry end)issuercountry
,newstatus
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate between trunc(sysdate) - 31 and trunc(sysdate) -1
and transactiontype = 'Authorize'
--and subscriptionid is not null
and newstatus in ('Completed','Declined')
--and renewattnum = '1'
and paymentserviceid = 'paypalExpress'
--and addedexpiryyears is not null
--and newstatus = 'Completed'

)

where cpg_attempt = '1'

group by divisionsiteid
,order_date

)Yest_All

on yest_comp.divisionsiteid = yest_all.divisionsiteid
and yest_comp.order_date = yest_all.order_date

)

group by divisionsiteid

order by attempts desc

)Prev_Data

on yest_Data.divisionsiteid = Prev_Data.divisionsiteid

)

where mean < 1
and auth_rate < 1
--and LCL > auth_rate

order by ratio
