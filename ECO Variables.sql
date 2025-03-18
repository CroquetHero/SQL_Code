select country_source
,bin
,dateincrement
,newstatus
--,current_status
--,sub_status
,count(transactionid)units
--select *
from
(
select paymentmethodid || '-' || (case when issuercountry is null then billingcountry else issuercountry end)Country_Source-- || '-' || card_source || '-' || card_class Country_Source
--,card_status
,addedexpiryyears
,renewattnum
,cpg_attempt
,(case when addedexpiryyears is null then null when dateincrement is null then '3' else dateincrement end)dateincrement
,paymentserviceid
,issuercountry
,paymentmethodid
,bin
,import_flag
,order_date
,(select responsemessage from EREPORT.cpg_transactions where transactionid = First_Transaction)First_Message
,(select paymentserviceid from EREPORT.cpg_transactions where transactionid = First_Transaction)First_processor
,newstatus
,transactionid
,divisionorderid
,subscriptionid
,current_status
,sub_status
,Bill_to_zip
,substr(Bill_to_zip,1,1)Zip_Region
,substr(Bill_to_zip,2,1)Zip_Sub_Region
,substr(Bill_to_zip,3,1)Zip_Sector
,substr(Bill_to_zip,4,1)Zip_Sub_Sector
,substr(Bill_to_zip,5,1)Zip_Sub_Sector_Divider
,substr(Bill_to_zip,7,3)Zip_Delivery_Area

--select *
from
(
select bin
,dateincrement
,to_char(creationdate,'D')Settle_Day
,to_char(creationdate,'DD')Settle_Day_of_Month
,addedexpiryyears
,paymentmethodid
,paymentserviceid
,issuercountry
,billingcountry
,newstatus
,divisionsiteid
,(select min(transactionid) from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid)First_Transaction
,(case when (select newstatus from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid and newstatus = 'Completed' and rownum < 2) is not null then 'Completed' else 'Declined' end)order_status
,renewattnum
,(case when dateincrement is null then 'Valid' else 'Expired' end)card_status
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,trunc(orderdate)order_date
,transactionid
,divisionorderid
,subscriptionid
,expirationdate
,(select bill_to_postal_code from CUSTOMER_DIM_VW where order_number = divisionorderid)Bill_to_zip
,(select distinct first_value(newstatus) over (order by creationdate desc,transactionid desc) from EREPORT.cpg_transactions where divisionorderid = ct.divisionorderid)current_status
,(select distinct first_value(newstatus) over (order by creationdate desc, transactionid desc) from EREPORT.cpg_transactions where subscriptionid = ct.subscriptionid and subsegmentid = ct.subsegmentid)sub_status
,(select imported from EREPORT.SUB_AUTH_ADDITIONAL_INFO where requisition_id = ct.divisionorderid and rownum < 2)import_flag
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
--select *
from EREPORT.cpg_transactions ct

where creationdate > '1/1/2019'
and transactiontype = 'Authorize'
and subscriptionid is not null
and renewattnum is not null
and oldstatus = 'New'
and renewattnum in ('1')--,'3','2')
--and divisionsiteid = 'avastbr'
and paymentmethodid in ('AmericanExpress','Visa','Discover','MasterCard')
and addedexpiryyears is not null

)

--where issuercountry = 'AR'
--and paymentmethodid = 'Visa'
--and card_source = 'Credit'
--and card_class = 'Consumer'

)

where cpg_attempt = '1'
and newstatus in ('Completed','Declined')
--and sub_status not in ('Completed')

group by country_source
,bin
,dateincrement
,newstatus
