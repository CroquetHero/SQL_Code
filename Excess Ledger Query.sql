SELECT
    ac.AC_DOC_NR SAP_ACCT_NR,
    ac.AC_DOC_LN SAP_ACCT_LN,
    ac.COMP_CODE SAP_COMP_CODE,
    ac.FISCPER SAP_FISC_PER,
    ac.PSTNG_DATE SAP_PSTNG_DATE,
    ac.DOC_DATE SAP_DOC_DATE,
    ac.CREATEDON SAP_CREATE_DATE,
    ac.CHRT_ACCTS SAP_CHART_ACCTS,
    ac.AC_DOC_TYP SAP_AC_DOC_TYPE,
    ac.GL_ACCOUNT SAP_GL_ACCT,
    ac.REF_DOC_NO SAP_REF_DOC_NR,
    ac.FI_AWTYP SAP_REF_SOURCE,
    ac.POSTXT SAP_GLDOC_LN_TEXT,
    ac.DOC_HD_TXT SAP_GLDOC_HDR_TXT,
    ac.PROFIT_CTR SAP_PROFIT_CTR,
    ac.DOC_NUMBER SAP_ORD_NR,
    max(ol.DOC_TYPE) SAP_ORD_TYPE,
    max(il.ORD_REASON) SAP_ORD_RSN,
    max(il.BILL_NUM) SAP_BILL_NR,
    max(il.BILL_TYPE) SAP_BILL_TYPE,
    max(ol."/BIC/ZPLATKEY") PLAT_ID,
    max(ol."/BIC/ZPLORDNO") PLAT_ORD_NR,
    max(ol."/BIC/ZORGORDID") PLAT_ORIG_ORD_NR,
    max(oh."/BIC/ZLOCALE") PLAT_LOCALE,
    max(ol.PAYER) SAP_MERCH_CUST,
    max(oh."/BIC/ZSITE_ID") PLAT_SITE_ID,
    max(il."/BIC/ZVEN_SITE") SAP_SITE_VEND,
    max(oh."/BIC/ZCLIENTID") PLAT_CLIENT_ID,
    max(oh."/BIC/ZVEN_CLNS") SAP_CLIENT_VEND,
    max(ol."/BIC/ZPAYMETH") SAP_PAY_METHOD,
    max(ol."/BIC/ZADRC_SH") SAP_SHIP_TO_CUST,
    max(ol."/BIC/ZADRC_BP") SAP_BILL_TO_CUST,
    ac.DOC_HD_TXT SAP_ACCT_DOC_HDR,
    ac.DOC_CURRCY SAP_DOC_CURRCY,
    case when d1."/BIC/ZCDCM" is null then ac.DEB_CRE_DC else power(10, (2 - d1."/BIC/ZCDCM"))*ac.DEB_CRE_DC end as SAP_DC_AMT,
    ac.LOC_CURRCY SAP_LOC_CURRCY,
    case when d2."/BIC/ZCDCM" is null then ac.DEB_CRE_LC else power(10, (2 - d2."/BIC/ZCDCM"))*ac.DEB_CRE_LC end as SAP_LC_AMT,
    ac.LOC_CURRC2 SAP_LOC2,
    ac.DEB_CRE_L2 SAP_LC2_AMT,
    ac.MATERIAL SAP_MATERIAL,
    ac.USERNAME SAP_USER
FROM
    SAPSR3."/BI0/AFIGL_O1400" ac,        --Accounting Segment
    SAPSR3."/BIC/AZSD_O0900" il,          --Invoice Lines
    SAPSR3."/BIC/AZSD_O0100" ol,         --Order Lines
    SAPSR3."/BIC/AZSD_O0300" oh,        --Order Header
    SAPSR3."/BIC/PZCDEC" d1,                --Currency Decimals Document Currency
    SAPSR3."/BIC/PZCDEC" d2                 --Currency Decimals Local Currency
WHERE
    ac.GL_ACCOUNT in ('0007100101','0007100106')
 --   (
 --   '0007100100', --Non Fraud Chargebacks
 --   '0007100101', --Non Fraud Chargebacks (Excess)
 --   '0007100105', --Fraud Chargebacks
 --   '0007100106', --Fraud Chargebacks (Excess)
--    '0007100110', --Chargeback Reversals
--    '0007100120', --Non Fraud Chargebacks Billback
--    '0007100125', --Fraud Chargebacks Billback
 --   '0007100130', --Manual Chargebacks
 --   '0007100135'  --Chargeback Reserve Adjustment
 --   )
   -- AND ac.COMP_CODE = '1010'
    AND ac.FISCPER = '2015010'
    AND ac.bill_num = il.bill_num (+)
    AND il.DOC_NUMBER = ol.DOC_NUMBER (+)
    AND il.DOC_NUMBER = oh.DOC_NUMBER (+)
    AND il.S_ORD_ITEM = ol.S_ORD_ITEM (+)
    AND ac.DOC_CURRCY = d1."/BIC/ZCDEC" (+)
    AND ac.LOC_CURRCY = d2."/BIC/ZCDEC" (+)
GROUP BY
    ac.AC_DOC_NR,
    ac.AC_DOC_LN,
    ac.COMP_CODE,
    ac.FISCPER,
    ac.PSTNG_DATE,
    ac.DOC_DATE,
    ac.CREATEDON,
    ac.CHRT_ACCTS,
    ac.AC_DOC_TYP,
    ac.GL_ACCOUNT,
    ac.REF_DOC_NO,
    ac.FI_AWTYP,
    ac.POSTXT,
    ac.DOC_HD_TXT,
    ac.PROFIT_CTR,
    ac.DOC_NUMBER,
    ac.DOC_HD_TXT,
    ac.DOC_CURRCY,
    case when d1."/BIC/ZCDCM" is null then ac.DEB_CRE_DC else power(10, (2 - d1."/BIC/ZCDCM"))*ac.DEB_CRE_DC end,
    ac.LOC_CURRCY,
    case when d2."/BIC/ZCDCM" is null then ac.DEB_CRE_LC else power(10, (2 - d2."/BIC/ZCDCM"))*ac.DEB_CRE_LC end,
    ac.LOC_CURRC2,
    ac.DEB_CRE_L2,
    ac.MATERIAL,
    ac.USERNAME