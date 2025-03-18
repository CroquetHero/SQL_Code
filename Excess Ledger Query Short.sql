select distinct ac.GL_ACCOUNT SAP_GL_ACCT
,ac.DOC_CURRCY SAP_DOC_CURRCY
,il.bill_date
,ol."/BIC/ZORGORDID"  Order_ID
,il."/BIC/ZPLATKEY" Platform

from SAPSR3."/BI0/AFIGL_O1400" ac
,SAPSR3."/BIC/AZSD_O0900" il
,SAPSR3."/BIC/AZSD_O0100" ol         --Order Lines

WHERE  ac.bill_num = il.bill_num (+)
AND il.DOC_NUMBER = ol.DOC_NUMBER (+)
AND ac.GL_ACCOUNT = '0007100106' --'0007100101'
and il.bill_date between 20190600 and 20190700
--and ac.FISCPER = '2017004'
--and ol."/BIC/ZORGORDID"  = '10524865006'
     
     --and rownum < 10