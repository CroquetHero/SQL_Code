SELECT rpt.CPG_TRANSACTION_ID ,
  rpt.division_order_id AS order_id ,
  rpt.division_site_id ,
  rpt.division_id ,
  rpt.payment_processor_name ,
  rpt.merchant_descriptor AS merchant ,
  rpt.order_date ,
  extract(MONTH FROM rpt.order_date)
  || '-'
  || extract(YEAR FROM rpt.order_date) AS order_month ,
  rpt.settlement_date ,
  extract(MONTH FROM rpt.settlement_date)
  || '-'
  || extract(YEAR FROM rpt.settlement_date) cb_month ,
  rpt.transaction_type ,
  rpt.payment_method_id ,
  rpt.payment_amount AS amount ,
  DECODE(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/
  (SELECT der.exchange_rate_num
  FROM Currency_exchange_sfact_vw der
  WHERE TRUNC(der.effective_date) = rpt.settlement_date
  AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
  )))                      AS usd ,
  rpt.transaction_currency AS currency ,
  rpt.status ,
  rpt.response_code AS reason_code ,
  DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud','4516'
  , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud', 'Inquiry by PayPal' ,
  'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
  rpt.usage_code ,
  rpt.bank_name ,
  rpt.country_code ,
  rpt.recurring_flag ,
  rpt.account_token ,
  rpt.customer_email ,
  rpt.customer_ip
FROM rcn_payment_transaction rpt
WHERE cpg_transaction_id IN
  (SELECT
    /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
    (
    SELECT cpg_transaction_id
    FROM rcn_payment_transaction
    WHERE transaction_type IN ('ChargeBack')
    AND division_order_id   = junk.division_order_id
    AND payment_amount      = junk.payment_amount
    AND rownum              < 2
    ) AS trans_id
  FROM
    ( SELECT DISTINCT
      (SELECT MIN(settlement_date)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND division_order_id   = rpt.division_order_id
      )AS settlement_date,
      division_order_id,
      payment_amount,
      division_id,
      status
    FROM rcn_payment_transaction rpt
    WHERE division_order_id IN
      (SELECT division_order_id
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND response_code NOT  IN ('98', 'RJ', 'RV')
      and creation_date > &&date1
      AND settlement_date BETWEEN
        &&date1 AND
        &&date2
        --and  division_id = 'esellerate'
        -- and  division_site_id = 'PUB13878:STR35599'
        --                                            and     division_site_id in ('38152','41653','tmamer','tmapac','tmemea','tmoemap','tmoemas','tmoemem','tmoemjp','tmpsap','tmpseu','tmpsjp','tmpsus','tmsbeu','tmtsecur','trendcn','trendoem','trendsb','tmsboemn','tmsboeme','tmsboema','tmsboemj','200010204','200072638','200082734','50105','50198','kasperbr','kasperde','kaspergl','kaspersk','kasperuk','kasperus','kaspernl','kasperoe','kasperla','avast','26451','avastbr','adbevlus','avleuweb','adbeedus','adbehkr','adbehcn','adbehtw','adbehap','adbeheu','19198','32776','nuanceeu','nuanceus','nuancevl','nuaresau','scansoft','scsoftAP','vmware','vmwde','vmwjp','vmwaus','mylearn','51877','adsk','adskeren','adskeduc','adskus','200048351','para','parastor','ca','caconsum','cajapan','capac','caportal','cathreat','clink','clinkeu','clinkjp','clinkus','50150','50508','50334','sonic','soniccn','sonicjp','sonicvlp','sonicbr','taxcut','39692','39694','39695','45766','mcafee','mfe','lominger','
        -- 17075','200065658','50312','50794','defender','defenduk','200010187','50647','defendde','defendwo','defendes','defendbr','acd','acdjp','39696','51498','borland','borlande','50153','embt','200072249','200084785','50169','50428','bobjamer','bobjapac','bobjapan','bobjasia','bobjects','bobjemea','bobjsubs','50217','50887','52117','aladdJP','allume','devdepot','webroot','webrootj','techsmit','ets','50693','worksaff','workshar','41683','absolute','absolbr','absolau','absoljp','200073650','200108739','ea','eaapac','eade','eaemea','eajapan','eara','easa','eatw','ebisuna','ebisuap','ebisueu','ebisujp','matty','ubiemea','ubina','ubisoft','turbine','200035349','22402','dndi','nvidia','nvidiadv','thq','thqworld','tera','41045','atarius','capcomus','aspyr','bbyus','sqenixus','valusoft','primagam','atvi','40565','actiemea','302','gamez','cdvusa','midway','srategyf','roboblit','speakint','106','206','305','logib2c','logieu','logitw','loguears','logikr','logiicbu','logiueeu','logiueau','
        -- logiaunz','logiuecs','ekconinf','ekconseu','ekconsus','ekinfcsr','kodak','eksupus','eksupeu','kodakir','rpeeub2c','rpeeuemp','rpeeuexp','rpeeup','rpeusb2c','rpeusemp','rpeusp','nikonusa','nikonhtg','lenovoeu','lenovooe','rimmktpl','49585','52757','53059','66019','canon','canoncon','canebuk','canebfr','canebde','canebnl','hpappli','hpkumo','razerusa','485','50725','200010603','wdau','wdeu','wdus','aceremea','pbemea','emacemea','aliphcom','panana','sgateus','sgeppus','sennheis','drobo','droboeu','samca','samppus','samsung','slingbox','fujitsu','547','netgear','netgrevl','netgsoft','ntgrebus','wgtech','dlink','targusus','freecom','sdeppus','sdiskca','sdiskeu','sdiskuk','sdiskus','shure','ciscoeu','benqeu','pogoplug','pogoja')
      AND (usage_code IS NULL
      OR usage_code    = '1')
      )
    AND transaction_type IN ('ChargeBack')
    AND status            = 'Completed'
    ORDER BY division_order_id,
      settlement_date
    ) junk
  WHERE settlement_date BETWEEN
    &&date1 AND
    &&date2
  )
AND status = 'Completed'
