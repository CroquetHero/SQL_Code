select distinct PLSTC_SRGT_ID
,substr(PLSTC_SRGT_ID,1,6)Cap_BIN
,AUTHZN_RQST_PROC_DT
,AUTHZN_RQST_PROC_TM
,AUTHZN_RQST_PROC_CD
,AUTHZN_AMT
,AUTHZN_APPRD_AMT
,AUTHZN_APPRL_CD
,AUTHZN_CATG_CD
,AUTHZN_DCLN_REAS_CD
,AUTHZN_PLSTC_EXPIRN_DT
,AUTHZN_RQST_TYPE_CD
,AUTHZN_RESPNS_CD
,POS_ENTRY_MTHD_CD
,MRCH_NM
,ACQR_BIN_NUM
,MRCH_ID
,MRCH_CATG_CD
,MC_BANKNET_REFNC_NUM
,VISA_BANKNET_TRXN_ID
,FRD_DCSN_RULE_NUM
,CRBRS_MODEL_SCORE_1_VAL
,divisionorderid
--,transactionid

from
(
select PLSTC_SRGT_ID,AUTHZN_RQST_PROC_DT,AUTHZN_RQST_PROC_TM,AUTHZN_RQST_PROC_CD,AUTHZN_AMT,AUTHZN_APPRD_AMT,AUTHZN_APPRL_CD,AUTHZN_CATG_CD,AUTHZN_DCLN_REAS_CD,AUTHZN_PLSTC_EXPIRN_DT,AUTHZN_RQST_TYPE_CD,AUTHZN_RESPNS_CD,POS_ENTRY_MTHD_CD,MRCH_NM,ACQR_BIN_NUM,MRCH_ID,MRCH_CATG_CD,MC_BANKNET_REFNC_NUM,VISA_BANKNET_TRXN_ID,FRD_DCSN_RULE_NUM,CRBRS_MODEL_SCORE_1_VAL

from cap_one_table

--where AUTHZN_RQST_PROC_DT between '10/1/2018' and '10/5/2018'
--and PLSTC_SRGT_ID = '468836REum5v9977'

)

left join

(
select divisionorderid
,bin
,merchantdescriptor
,paymentserviceid
,paymentmethodid
,merchantnumber
,bankname
,midcategory
,newstatus
,paymentamount
,responsecode1
,responsemessage
,authorizationcode
,to_char(orderdate, 'MM/DD/YYYY')day
,to_char(orderdate + 1/24, 'HH24:MI:SS')time
,transactionid
,to_char(orderdate + 1/24 - 2/24/60/60, 'HH24:MI:SS')time2
,to_char(orderdate + 1/24 + 2/24/60/60, 'HH24:MI:SS')time3

from ereport.cpg_transactions

where creationdate between '9/30/2018' and '12/6/2018'
and transactiontype = 'Authorize'
and paymentmethodid in ('Visa','MasterCard')

)CT

on upper(merchantdescriptor) = upper(MRCH_NM)
and paymentamount = AUTHZN_AMT
and AUTHZN_RQST_PROC_DT = day
and substr(PLSTC_SRGT_ID,1,6) = bin
and AUTHZN_RQST_PROC_TM between time2 and time3
--and authorizationcode = AUTHZN_APPRL_CD

where AUTHZN_APPRL_CD is null
and divisionorderid is not null
