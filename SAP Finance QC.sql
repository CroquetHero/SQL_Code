select (case when LM.PLAT_CLIENT_ID is null then past1.PLAT_CLIENT_ID else LM.PLAT_CLIENT_ID end)Site_ID
        ,past1.n Months
        ,LM.BillBack_Sum
        ,past1.BillBack_Mean
        ,past1.BillBack_STD
        ,(case when BillBack_STD > 0 then round((LM.BillBack_Sum - past1.BillBack_Mean)/BillBack_STD,3) else 0 end)ratio
        
        from
(
select PLAT_CLIENT_ID
,count(BillBack_Sum)n
,round(avg(BillBack_Sum),3)BillBack_Mean
,round(stddev(BillBack_Sum),3)BillBack_STD

from
(
select ac.fiscper
,oh."/BIC/ZCLIENTID" PLAT_CLIENT_ID
,sum(ac.DEB_CRE_L2 )BillBack_Sum
--select *
from SAPSR3."/BI0/AFIGL_O1400" ac
,SAPSR3."/BIC/AZSD_O0900" il
,SAPSR3."/BIC/AZSD_O0300" oh

where ac.bill_num = il.bill_num (+)
AND il.DOC_NUMBER = oh.DOC_NUMBER (+)
and ac.GL_ACCOUNT = '0007100120'
and ac.tcttimstmp > '20170100000000'
and ac.fiscper between '2017000' and '2017012'

group by ac.fiscper
,oh."/BIC/ZCLIENTID"

)

group by PLAT_CLIENT_ID

)Past1

full join

(

select ac.fiscper
,oh."/BIC/ZCLIENTID" PLAT_CLIENT_ID
,sum(ac.DEB_CRE_L2 )BillBack_Sum
--select *
from SAPSR3."/BI0/AFIGL_O1400" ac
,SAPSR3."/BIC/AZSD_O0900" il
,SAPSR3."/BIC/AZSD_O0300" oh

where ac.bill_num = il.bill_num (+)
AND il.DOC_NUMBER = oh.DOC_NUMBER (+)
and ac.GL_ACCOUNT = '0007100120'
and ac.tcttimstmp > '20170100000000'
and ac.fiscper between '2017012' and '2018001'

group by ac.fiscper
,oh."/BIC/ZCLIENTID"

)LM


on LM.PLAT_CLIENT_ID = past1.PLAT_CLIENT_ID
        where BillBack_Sum is null
        and BillBack_Mean < 1000
        