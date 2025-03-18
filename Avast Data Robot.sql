select divisionorderid
--,subscriptionid
,order_date
,paymentserviceid
,paymentmethodid
,paymentamount
,paymentcurrency
,Checkout_status
,billingcountry
,decode(fundingsource,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(cardclass,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
,bin
,IssuerCountry
,bankName
,merchantnumber
,merchantcontact
,renewAttNum
,cpg_attempt
,cb_status
,trial_status
--,Prev_Order_ID
,(case when trial_status = 'TRIAL' and (select count(platform_order_id) from sub_seg_expire_dnorm where subscription_id = BD.subscriptionid) <= 2 then 0 
when (select payment_amount from rcn_payment_transaction where division_order_id = BD.prev_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is null then 0
else (round(paymentamount/(select payment_amount from rcn_payment_transaction where division_order_id = BD.prev_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2),2) - 1) end)Rate_of_Change

from
(
select divisionorderid
,subscriptionid
,trunc(creationdate)order_date
,paymentserviceid
,paymentmethodid
,paymentamount
,paymentcurrency
,(case when (select bill_to_address_line1_text from CUSTOMER_DIM_VW where order_number = divisionorderid and bill_to_address_line1_text = '.') is not null then 'Limited' else 'Not Limited' end)Checkout_status
,billingcountry
,cardClass
,fundingSource
,IssuerCountry
,bankName
,merchantnumber
,merchantcontact
,renewAttNum
,bin
,rank() over (partition by divisionorderid order by transactionid)cpg_attempt
,(case when (select status from rcn_payment_transaction where division_order_id = ct.divisionorderid and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
,(select distinct first_value(platform_order_id) over (order by purchase_dt desc) from sub_seg_expire_dnorm where subscriptionid = subscription_id and platform_order_id <> divisionorderid)Prev_Order_ID
,(select distinct first_value(subscription_type_code) over (order by purchase_dt) from sub_seg_expire_dnorm where subscriptionid = subscription_id and platform_order_id <> divisionorderid)trial_status

--select *
from ereport.cpg_transactions ct

where creationdate between trunc(sysdate) - 10 and trunc(sysdate)
and transactiontype = 'Authorize'
and newstatus = 'Completed'
and paymentmethodid in ('MasterCard','Visa')
and divisionsiteid = 'avast'
and midCategory = 'recurring'
and renewattnum is not null

)BD
