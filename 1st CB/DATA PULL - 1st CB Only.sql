select   rpt.CPG_TRANSACTION_ID 
        ,rpt.division_order_id as order_id
        ,rpt.division_site_id
        ,rpt.division_id
        ,rpt.payment_processor_name
        ,rpt.merchant_descriptor as merchant
        ,rpt.order_date
        ,extract(month from rpt.order_date) || '-' || extract(year from rpt.order_date) as order_month
        ,rpt.settlement_date
        ,extract(month from rpt.settlement_date) || '-' || extract(year from rpt.settlement_date) cb_month
        ,rpt.transaction_type
        ,rpt.payment_method_id
        ,rpt.payment_amount as amount
        ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
        ,rpt.transaction_currency as currency
        ,rpt.status
        ,rpt.response_code as reason_code
        ,decode(rpt.response_code_1, '530','Fraud','806','Non-Fraud','A02','Fraud','A01','Non-Fraud','A03','Non-Fraud','A04','Non-Fraud','A08','Non-Fraud','A10','Non-Fraud','C02','Non-Fraud','C04','Non-Fraud','C05','Non-Fraud','C06','Non-Fraud','C07','Non-Fraud','C08','Non-Fraud','C09','Non-Fraud','C10','Non-Fraud','C11','Non-Fraud','C14','Non-Fraud','C25','Non-Fraud','C28','Non-Fraud','C29','Non-Fraud','C31','Non-Fraud','C32','Non-Fraud','F04','Non-Fraud','F05','Non-Fraud','F10','Fraud','F16','Non-Fraud','F18','Non-Fraud','F22','Non-Fraud','F24','Fraud','F29','Fraud','FR5','Non-Fraud','M03','Non-Fraud','M08','Non-Fraud','M10','Non-Fraud','M11','Non-Fraud','M12','Non-Fraud','M15','Non-Fraud','M18','Non-Fraud','M37','Non-Fraud','M38','Non-Fraud','M47','Fraud','OP1','Non-Fraud','P01','Non-Fraud','P02','Non-Fraud','P03','Non-Fraud','P04','Non-Fraud','P05','Non-Fraud','P07','Non-Fraud','P11','Non-Fraud','P15','Non-Fraud','P22','Non-Fraud','P23','Non-Fraud','R02','Non-Fraud','R06','Fraud','R12','Non-Fraud','R14','Non-Fraud','R15','Non-Fraud','R17','Non-Fraud','R21','Non-Fraud','R22','Non-Fraud','R23','Non-Fraud','F06','Fraud','F15','Non-Fraud','FR2','Fraud','FR3','Fraud','FR4','Non-Fraud','FR6','Non-Fraud','Fraud','Fraud','M01','Fraud','M35','Non-Fraud','M36','Non-Fraud','Non-Fraud','Non-Fraud','P08','Non-Fraud','P17','Non-Fraud','R01','Non-Fraud','R03','Non-Fraud','R04','Non-Fraud','R13','Non-Fraud','AA','Non-Fraud','AP','Non-Fraud','AT','Non-Fraud','AW','Non-Fraud','CA','Non-Fraud','CD','Non-Fraud','CR','Non-Fraud','DP','Non-Fraud','IC','Non-Fraud','IN','Non-Fraud','IS','Non-Fraud','LP','Non-Fraud','NC','Non-Fraud','NR','Non-Fraud','RG','Non-Fraud','RM','Non-Fraud','RN2','Non-Fraud','TF','Non-Fraud','UA01','Fraud','UA02','Fraud','UA03','Non-Fraud','UANR','Fraud','AA','Fraud','AL','Non-Fraud','DA','Non-Fraud','EX','Non-Fraud','NA','Non-Fraud','PM','Non-Fraud','RN','Non-Fraud','SV','Non-Fraud','UA11','Fraud','UA12','Fraud','UA18','Non-Fraud','UA21','Fraud','UA23','Fraud','UA32','Fraud','UA99','Fraud','UANR - Fraud','Fraud','UANR','Non-Fraud','1','Non-Fraud','2','Non-Fraud','4','Fraud','7','Non-Fraud','8','Non-Fraud','12','Non-Fraud','31','Non-Fraud','34','Non-Fraud','35','Non-Fraud','37','Fraud','40','Fraud','41','Non-Fraud','42','Non-Fraud','46','Non-Fraud','47','Fraud','49','Non-Fraud','50','Non-Fraud','53','Non-Fraud','54','Non-Fraud','55','Non-Fraud','57','Fraud','59','Non-Fraud','60','Non-Fraud','62','Fraud','63','Fraud','70','Fraud','4804','Fraud','4807','Non-Fraud','4808','Non-Fraud','4812','Non-Fraud','4831','Non-Fraud','4834','Non-Fraud','4837','Fraud','4840','Fraud','4841','Non-Fraud','4842','Non-Fraud','4846','Non-Fraud','4853','Non-Fraud','4855','Non-Fraud','4859','Non-Fraud','4860','Non-Fraud','4863','Fraud','4870','Fraud','4902','Non-Fraud','4903','Non-Fraud','RJ','Non-Fraud','RV','Non-Fraud','Not as described','Non-Fraud','Closed','Non-Fraud','?','Non-Fraud','Inquiry','Non-Fraud','Inquiry by PayPal','Non-Fraud','Merchandise','Non-Fraud','Non-receipt','Non-Fraud','Unauthorized','Fraud','Unauthorized payment','Fraud','Duplicate payment','Non-Fraud','Item not received','Non-Fraud','Other','Non-Fraud','Special','Non-Fraud','30','Non-Fraud','70','Non-Fraud','71','Non-Fraud','72','Non-Fraud','73','Non-Fraud','74','Non-Fraud','75','Fraud','76','Non-Fraud','77','Non-Fraud','78','Non-Fraud','79','Non-Fraud','80','Non-Fraud','81','Fraud','82','Non-Fraud','83','Fraud','85','Non-Fraud','86','Non-Fraud','90','Non-Fraud','93','Fraud','96','Non-Fraud','3','Non-Fraud','4','Non-Fraud','6','Non-Fraud','10','Non-Fraud','13','Non-Fraud','14','Non-Fraud','4801','Non-Fraud','4802','Non-Fraud','4835','Non-Fraud','4847','Fraud','4849','Non-Fraud','4850','Non-Fraud','4854','Non-Fraud','4857','Fraud','4862','Fraud','9050','Non-Fraud','9051','Non-Fraud','9052','Non-Fraud','9053','Non-Fraud','9054','Non-Fraud','9055','Non-Fraud','4507','Non-Fraud','4512','Non-Fraud','4513','Non-Fraud','4515','Non-Fraud','4516','Non-Fraud','4517','Non-Fraud','4521','Non-Fraud','4540','Fraud','4544','Non-Fraud','4553','Non-Fraud','4554','Non-Fraud','4763','Non-Fraud','4536','Non-Fraud','4799','Fraud','4857','Non-Fraud','6014','Non-Fraud','07','Non-Fraud','93','Non-Fraud','11','Non-Fraud','14','Fraud','15','Non-Fraud','16','Non-Fraud','17','Non-Fraud','21','Non-Fraud','22','Non-Fraud','23','Non-Fraud','25','Non-Fraud','27','Non-Fraud','28','Non-Fraud','40','Non-Fraud','43','Non-Fraud','44','Non-Fraud','45','Fraud','61','Non-Fraud','62','Non-Fraud','08','Non-Fraud','4755','Non-Fraud','4563','Non-Fraud','4752','Non-Fraud','7030','Fraud','512','Non-Fraud','516','Non-Fraud','546','Fraud','91','Non-Fraud','8030','Non-Fraud','8071','Non-Fraud','8072','Non-Fraud','8075','Fraud','8080','Non-Fraud','8082','Non-Fraud','8083','Fraud','8085','Non-Fraud','Other') cb_reason
        ,rpt.usage_code
        ,rpt.bank_name
        ,rpt.recurring_flag
        ,rpt.account_token
        ,rpt.customer_email
        ,rpt.customer_ip





from rcn_payment_transaction rpt 
       
          where cpg_transaction_id in
                   (
                      select /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */(select cpg_transaction_id from rcn_payment_transaction where transaction_type in ('ChargeBack') and division_order_id = junk.division_order_id and  payment_amount = junk.payment_amount and rownum < 2  ) as trans_id
                      from (
                                select distinct (select Min(settlement_date) from rcn_payment_transaction where transaction_type in ('ChargeBack') and division_order_id = rpt.division_order_id)as settlement_date,division_order_id, payment_amount, division_id, status
                                from rcn_payment_transaction rpt
                                where division_order_id in 
                                       (   
                                             select division_order_id 
                                            from rcn_payment_transaction 
                                            where transaction_type in ('ChargeBack') 
                                            and     response_code not in ('98', 'RJ', 'RV')
                                            and    settlement_date between '01-aug-12' and '31-aug-12'
                                            --and  division_id = 'esellerate'
                                           -- and  division_site_id = 'PUB13878:STR35599'
--                                            and     division_site_id in ('38152','41653','tmamer','tmapac','tmemea','tmoemap','tmoemas','tmoemem','tmoemjp','tmpsap','tmpseu','tmpsjp','tmpsus','tmsbeu','tmtsecur','trendcn','trendoem','trendsb','tmsboemn','tmsboeme','tmsboema','tmsboemj','200010204','200072638','200082734','50105','50198','kasperbr','kasperde','kaspergl','kaspersk','kasperuk','kasperus','kaspernl','kasperoe','kasperla','avast','26451','avastbr','adbevlus','avleuweb','adbeedus','adbehkr','adbehcn','adbehtw','adbehap','adbeheu','19198','32776','nuanceeu','nuanceus','nuancevl','nuaresau','scansoft','scsoftAP','vmware','vmwde','vmwjp','vmwaus','mylearn','51877','adsk','adskeren','adskeduc','adskus','200048351','para','parastor','ca','caconsum','cajapan','capac','caportal','cathreat','clink','clinkeu','clinkjp','clinkus','50150','50508','50334','sonic','soniccn','sonicjp','sonicvlp','sonicbr','taxcut','39692','39694','39695','45766','mcafee','mfe','lominger','17075','200065658','50312','50794','defender','defenduk','200010187','50647','defendde','defendwo','defendes','defendbr','acd','acdjp','39696','51498','borland','borlande','50153','embt','200072249','200084785','50169','50428','bobjamer','bobjapac','bobjapan','bobjasia','bobjects','bobjemea','bobjsubs','50217','50887','52117','aladdJP','allume','devdepot','webroot','webrootj','techsmit','ets','50693','worksaff','workshar','41683','absolute','absolbr','absolau','absoljp','200073650','200108739','ea','eaapac','eade','eaemea','eajapan','eara','easa','eatw','ebisuna','ebisuap','ebisueu','ebisujp','matty','ubiemea','ubina','ubisoft','turbine','200035349','22402','dndi','nvidia','nvidiadv','thq','thqworld','tera','41045','atarius','capcomus','aspyr','bbyus','sqenixus','valusoft','primagam','atvi','40565','actiemea','302','gamez','cdvusa','midway','srategyf','roboblit','speakint','106','206','305','logib2c','logieu','logitw','loguears','logikr','logiicbu','logiueeu','logiueau','logiaunz','logiuecs','ekconinf','ekconseu','ekconsus','ekinfcsr','kodak','eksupus','eksupeu','kodakir','rpeeub2c','rpeeuemp','rpeeuexp','rpeeup','rpeusb2c','rpeusemp','rpeusp','nikonusa','nikonhtg','lenovoeu','lenovooe','rimmktpl','49585','52757','53059','66019','canon','canoncon','canebuk','canebfr','canebde','canebnl','hpappli','hpkumo','razerusa','485','50725','200010603','wdau','wdeu','wdus','aceremea','pbemea','emacemea','aliphcom','panana','sgateus','sgeppus','sennheis','drobo','droboeu','samca','samppus','samsung','slingbox','fujitsu','547','netgear','netgrevl','netgsoft','ntgrebus','wgtech','dlink','targusus','freecom','sdeppus','sdiskca','sdiskeu','sdiskuk','sdiskus','shure','ciscoeu','benqeu','pogoplug','pogoja')                               
                                            and     (usage_code is null or usage_code = '1')
                                        )
                                and transaction_type in ('ChargeBack')
                                and     status = 'Completed'
                                order by division_order_id, settlement_date
                           ) junk

                      where settlement_date between '01-aug-12' and '31-aug-12'
                   )
       and     status = 'Completed'
