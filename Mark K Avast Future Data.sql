select ORDER_ID
,subscription_id
,paymentserviceid
,paymentmethodid payment_method_id
,paymentamount payment_amount
,card_source funding_source
,card_class
,Card_usage
,bin
,bankname
,merchantnumber merchant_number
,billing_country_id billing_country
,issuer_country
,cpg_creation_date creation_date
,division_site_id
,expirationdate expiration_date
,(case when (expiration_date - trunc(sysdate)) < 0 then 'TRUE' else 'FALSE' end)expired_bool
,(expiration_date - trunc(sysdate))Days_to_Expire
,to_char(cpg_creation_date, 'HH24')creation_hour_of_day
,to_char(cpg_creation_date, 'MM')creation_date_month
,next_day(cpg_creation_date - 7, 'sun')creation_date_Sunday
,to_char(cpg_creation_date, 'WW')creation_date_Week
,to_char(cpg_creation_date, 'D')locale_day_of_week
,to_char(cpg_creation_date, 'MM/DD/YYYY HH24')creation_date_hour
,(case when issuer_country = 'AE' and transaction_currency = 'AED' then 'TRUE'
when issuer_country in ('AD','AT','BE','DE','ES','FI','FR','GF','GP','GR','IE','IT','LU','MC','MQ','NL','PT','RE','SI','YT') and transaction_currency = 'EUR' then 'TRUE'
when issuer_country in ('FM','GU','MH','MP','PR','PW','US','VG','VI') and transaction_currency = 'USD' then 'TRUE'
when issuer_country in ('NF','AU') and transaction_currency = 'AUD' then 'TRUE'
when issuer_country = 'AR' and transaction_currency = 'ARS' then 'TRUE'
when issuer_country = 'CA' and transaction_currency = 'CAD' then 'TRUE'
when issuer_country = 'CH' and transaction_currency = 'CHF' then 'TRUE'
when issuer_country = 'CL' and transaction_currency = 'CLP' then 'TRUE'
when issuer_country = 'CN' and transaction_currency = 'CNY' then 'TRUE'
when issuer_country = 'CO' and transaction_currency = 'COP' then 'TRUE'
when issuer_country = 'CZ' and transaction_currency = 'CZK' then 'TRUE'
when issuer_country = 'DK' and transaction_currency = 'DKK' then 'TRUE'
when issuer_country = 'GB' and transaction_currency = 'GBP' then 'TRUE'
when issuer_country = 'ID' and transaction_currency = 'IDR' then 'TRUE'
when issuer_country = 'IL' and transaction_currency = 'ILS' then 'TRUE'
when issuer_country = 'JP' and transaction_currency = 'JPY' then 'TRUE'
when issuer_country = 'KR' and transaction_currency = 'KRW' then 'TRUE'
when issuer_country = 'MX' and transaction_currency = 'MXN' then 'TRUE'
when issuer_country = 'MY' and transaction_currency = 'MYR' then 'TRUE'
when issuer_country = 'NZ' and transaction_currency = 'NZD' then 'TRUE'
when issuer_country = 'PE' and transaction_currency = 'PEN' then 'TRUE'
when issuer_country = 'PH' and transaction_currency = 'PHP' then 'TRUE'
when issuer_country = 'PL' and transaction_currency = 'PLN' then 'TRUE'
when issuer_country = 'SA' and transaction_currency = 'SAR' then 'TRUE'
when issuer_country = 'SE' and transaction_currency = 'SEK' then 'TRUE'
when issuer_country = 'SG' and transaction_currency = 'SGD' then 'TRUE'
when issuer_country = 'TR' and transaction_currency = 'TRY' then 'TRUE'
when issuer_country = 'TW' and transaction_currency = 'TWD' then 'TRUE'
when issuer_country = 'ZA' and transaction_currency = 'ZAR' then 'TRUE'
when issuer_country = 'NO' and transaction_currency = 'NOK' then 'TRUE'
else 'FALSE' end)Issuer_country_curr_match
,(case when billing_country_id = 'AE' and transaction_currency = 'AED' then 'TRUE'
when billing_country_id in ('AD','AT','BE','DE','ES','FI','FR','GF','GP','GR','IE','IT','LU','MC','MQ','NL','PT','RE','SI','YT') and transaction_currency = 'EUR' then 'TRUE'
when billing_country_id in ('FM','GU','MH','MP','PR','PW','US','VG','VI') and transaction_currency = 'USD' then 'TRUE'
when billing_country_id in ('NF','AU') and transaction_currency = 'AUD' then 'TRUE'
when billing_country_id = 'AR' and transaction_currency = 'ARS' then 'TRUE'
when billing_country_id = 'CA' and transaction_currency = 'CAD' then 'TRUE'
when billing_country_id = 'CH' and transaction_currency = 'CHF' then 'TRUE'
when billing_country_id = 'CL' and transaction_currency = 'CLP' then 'TRUE'
when billing_country_id = 'CN' and transaction_currency = 'CNY' then 'TRUE'
when billing_country_id = 'CO' and transaction_currency = 'COP' then 'TRUE'
when billing_country_id = 'CZ' and transaction_currency = 'CZK' then 'TRUE'
when billing_country_id = 'DK' and transaction_currency = 'DKK' then 'TRUE'
when billing_country_id = 'GB' and transaction_currency = 'GBP' then 'TRUE'
when billing_country_id = 'ID' and transaction_currency = 'IDR' then 'TRUE'
when billing_country_id = 'IL' and transaction_currency = 'ILS' then 'TRUE'
when billing_country_id = 'JP' and transaction_currency = 'JPY' then 'TRUE'
when billing_country_id = 'KR' and transaction_currency = 'KRW' then 'TRUE'
when billing_country_id = 'MX' and transaction_currency = 'MXN' then 'TRUE'
when billing_country_id = 'MY' and transaction_currency = 'MYR' then 'TRUE'
when billing_country_id = 'NZ' and transaction_currency = 'NZD' then 'TRUE'
when billing_country_id = 'PE' and transaction_currency = 'PEN' then 'TRUE'
when billing_country_id = 'PH' and transaction_currency = 'PHP' then 'TRUE'
when billing_country_id = 'PL' and transaction_currency = 'PLN' then 'TRUE'
when billing_country_id = 'SA' and transaction_currency = 'SAR' then 'TRUE'
when billing_country_id = 'SE' and transaction_currency = 'SEK' then 'TRUE'
when billing_country_id = 'SG' and transaction_currency = 'SGD' then 'TRUE'
when billing_country_id = 'TR' and transaction_currency = 'TRY' then 'TRUE'
when billing_country_id = 'TW' and transaction_currency = 'TWD' then 'TRUE'
when billing_country_id = 'ZA' and transaction_currency = 'ZAR' then 'TRUE'
when billing_country_id = 'NO' and transaction_currency = 'NOK' then 'TRUE'
else 'FALSE' end)billing_country_curr_match
,Settle_Day
,Settle_Day_of_month
,Avg_CB_Lag
,STD_CB_Lag
,(case when trial_status = 'TRIAL' then 'TRUE' else 'FALSE' end)from_trial_bool
,contract_term_code
,(case when trial_status = 'TRIAL' then 'Trial'
when (select count(platform_order_id) from sub_seg_expire_dnorm where platform_order_id = First_Order_ID and subscription_type_code = 'ORIGINAL') > 1 then 'Multi-Sub'
when (select distinct division_order_id from rcn_auth_trans where BD3.Account_Token = Account_Token and division_order_id <> First_Order_ID and trunc(cpg_creation_date) = prev_date and status = 'Completed' and division_site_id = 'avastbr' and rownum < 2) is not null then 'UpSale'
else 'Single Sub' end)Customer_Type

from
(
select division_order_id ORDER_ID
,division_site_id
,subscription_id
,payment_service_id paymentserviceid
,payment_method_id paymentmethodid
,cpg_creation_date
,payment_amount paymentamount
,transaction_currency
,funding_source card_source
,card_class
,Card_usage
,bin
,bank_Name bankname
,merchant_number merchantnumber
,billing_country_id
,Settle_Day
,Settle_Day_of_month
,decode(bin,'522815','65.6',	'510147','53.3',	'428269','38.9',	'403246','34.8',	'509067','61.8',	'544859','52.4',	'536233','33.1',	'434995','44.7',	'637095','107.5',	'430535','42.3',	'542661','15.7',	'516291','26',	'506753','80.54545455',	'526966','57.18181818',	'506731','43.36363636',	'549391','19.63636364',	'418047','27.54545455',	'547874','51.72727273',	'549319','29.18181818',	'536143','34.36363636',	'534520','35.27272727',	'529205','90.72727273',	'474525','34.36363636',	'514004','29',	'493493','40',	'534516','33.09090909',	'512374','35.33333333',	'544891','27.33333333',	'455185','30.83333333',	'544570','26.5',	'459315','30.83333333',	'496045','54.16666667',	'402934','124.0833333',	'400437','62.66666667',	'518482','106.9166667',	'476333','26.33333333',	'493100','31.08333333',	'548046','19.91666667',	'512363','29.92307692',	'534593','34.61538462',	'491412','46.61538462',	'539039','25.53846154',	'526965','54.15384615',	'544915','39.46153846',	'527430','31.07692308',	'441120','22.69230769',	'554473','44',	'421844','36.23076923',	'513557','39.38461538',	'518759','21.38461538',	'515118','52.21428571',	'544300','40.71428571',	'411854','23.42857143',	'400268','21.14285714',	'535091','39.07142857',	'544199','34.21428571',	'409308','38.21428571',	'407505','64.92857143',	'411049','36.21428571',	'481274','26.42857143',	'459450','68.33333333',	'459316','40',	'509069','65',	'515787','58.26666667',	'518544','44.4',	'522590','33.46666667',	'527887','31.66666667',	'554612','55.66666667',	'526787','21.66666667',	'421845','27.66666667',	'421960','65.06666667',	'546852','52.25',	'464294','41.4375',	'535850','22.82352941',	'511781','27',	'514086','25.47058824',	'541465','44.58823529',	'521397','47.83333333',	'539073','43.61111111',	'539029','49.94444444',	'516306','32.16666667',	'525922','38.94444444',	'407303','21.33333333',	'455187','34.22222222',	'536269','56.94444444',	'554463','35.27777778',	'458919','45.42105263',	'444458','21.84210526',	'522027','35.89473684',	'527889','34.47368421',	'539083','25.15789474',	'540105','38.21052632',	'526778','30.05263158',	'421847','39.84210526',	'535085','46.75',	'464299','30.95',	'526769','54.85',	'439027','28.3',	'532930','29.5',	'522688','26.9047619',	'536537','18.95238095',	'514895','24.09090909',	'427164','47.45454545',	'539028','59.09090909',	'548293','34.95454545',	'536380','56',	'491675','44.86956522',	'418668','56.43478261',	'524820','30.75',	'553096','55.70833333',	'521180','22.44',	'471703','38.88',	'543882','28.24',	'422100','41.30769231',	'491674','28.34615385',	'525718','25.65384615',	'410425','36',	'525662','31.61538462',	'542976','28.62962963',	'527437','36.2962963',	'515601','24.2962963',	'636368','34.21428571',	'515894','39.03571429',	'476608','49.71428571',	'516292','35.82142857',	'428268','38.64285714',	'415275','32.5862069',	'421958','81.37931034',	'518814','119.3448276',	'459314','35.93103448',	'525663','40.33333333',	'518454','113.6',	'544883','30.70967742',	'552937','60.15625',	'531705','27.375',	'549159','41',	'552305','43.60606061',	'525664','37.36363636',	'516220','34.12121212',	'526863','34.90909091',	'455182','32.97058824',	'539090','35.35294118',	'547408','36.42857143',	'544540','40.38888889',	'476331','27.97222222',	'459077','51.66666667',	'552693','44.25',	'439388','43.16666667',	'541759','32.16666667',	'520977','35.78378378',	'529323','34.75675676',	'534513','28.86486486',	'542974','30.36842105',	'459384','90.39473684',	'485464','46.36842105',	'498431','46.74358974',	'489391','40.125',	'514087','28.425',	'406168','41.45',	'422200','51.09756098',	'536805','41.07317073',	'520132','34.24390244',	'410424','59.31707317',	'552236','33.80952381',	'539091','34.90697674',	'455181','40.39534884',	'506741','73.75',	'527497','33.42222222',	'552640','45.04444444',	'455183','32.26666667',	'515117','40.69565217',	'558763','59.60869565',	'459313','31.56521739',	'427167','34.68085106',	'415274','30.9375',	'541555','40.70833333',	'522499','43.34693878',	'432032','46.84',	'441524','27',	'548474','33.98',	'536518','30',	'546056','37.88461538',	'548723','29.2962963',	'421848','39.64285714',	'418053','34.81355932',	'552128','68.13333333',	'514868','48.3',	'506778','52.73770492',	'512707','35.03278689',	'527407','38.74193548',	'552289','28.70967742',	'522840','45.06451613',	'544315','41.96923077',	'548985','35.29850746',	'530033','24.6119403',	'455184','38.87323944',	'528392','31.13888889',	'406669','44.15068493',	'554927','23.35616438',	'444054','41.65753425',	'525631','47.60273973',	'439354','44.82432432',	'548724','28.83783784',	'422053','45.47435897',	'459080','44.33333333',	'535858','29.92405063',	'470598','43.2625',	'540593','57.45121951',	'544828','58.52439024',	'506775','64.61904762',	'525496','37',	'546452','22.71428571',	'459360','81.62352941',	'534503','35.6744186',	'548984','34.52325581',	'527468','36.88372093',	'531681','31.71590909',	'482425','37.68539326',	'459383','82.46153846',	'428267','35.04347826',	'422005','36.31313131',	'444456','28.27722772',	'412177','40.18811881',	'548573','27.66666667',	'541187','33.03809524',	'550209','24.79090909',	'525320','34.25663717',	'535081','34.36206897',	'554906','24.00793651',	'530994','36.78125',	'410863','27.71969697',	'527496','32.69924812',	'498408','32.35766423',	'520405','36.28985507',	'530034','36.47183099',	'549167','39.5170068',	'512682','63.75496689',	'406655','39.84210526',	'553636','39.06535948',	'523284','37.07051282',	'542820','30.59876543',	'498423','23.74390244',	'530780','30.48809524',	'514945','31.37647059',	'422061','48.15730337',	'498407','28.02173913',	'490172','42.46236559',	'546479','23.9798995',	'523421','25.58767773',	'498401','29.73991031',	'453211','37.47577093',	'515590','39.14661654',	'','44.20612813',	'498406','30.34079602',	'498453','29.45985401',	'606282','60.21555556',	'498442','30.18431373',	'544731','33.26699629')Avg_CB_Lag
,decode(bin,'522815','34.42931567',	'510147','38.55746073',	'428269','15.20562761',	'403246','24.28442574',	'509067','8.337332374',	'544859','42.04019241',	'536233','11.92057046',	'434995','23.42861498',	'637095','32.70830679',	'430535','16.14551881',	'542661','7.040359839',	'516291','19.6977156',	'506753','34.29974821',	'526966','21.32518784',	'506731','25.42547041',	'549391','12.47615908',	'418047','8.710495237',	'547874','25.85378467',	'549319','24.26033051',	'536143','37.57731424',	'534520','28.4678447',	'529205','45.67513746',	'474525','11.68137601',	'514004','9.97997996',	'493493','18.62793601',	'534516','17.86871313',	'512374','23.94817637',	'544891','24.83521449',	'455185','24.62383669',	'544570','17.20200834',	'459315','23.6098336',	'496045','31.15601017',	'402934','2.810963385',	'400437','21.61789382',	'518482','31.80468328',	'476333','11.28420725',	'493100','25.40028036',	'548046','14.88414857',	'512363','35.16025583',	'534593','19.09859708',	'491412','25.53931108',	'539039','12.56062223',	'526965','22.57892142',	'544915','21.74325713',	'527430','11.71510093',	'441120','14.82331843',	'554473','24.84283934',	'421844','24.50902503',	'513557','20.05217553',	'518759','16.95355647',	'515118','22.33720102',	'544300','35.20801607',	'411854','10.16566079',	'400268','12.62389153',	'535091','43.72547978',	'544199','19.2760456',	'409308','49.15779705',	'407505','65.91307129',	'411049','18.70902115',	'481274','26.41012127',	'459450','56.01742926',	'459316','58.02093218',	'509069','19.63961012',	'515787','15.76826228',	'518544','34.26326646',	'522590','21.56341699',	'527887','16.28613199',	'554612','23.46628788',	'526787','14.50943864',	'421845','22.72401708',	'421960','32.29433092',	'546852','19.50897229',	'464294','35.47387536',	'535850','15.53317134',	'511781','16.37070554',	'514086','17.93083115',	'541465','39.81215082',	'521397','33.85826861',	'539073','33.58945719',	'539029','22.86397686',	'516306','20.90665529',	'525922','22.50613569',	'407303','15.35463141',	'455187','22.5611732',	'536269','21.49000376',	'554463','9.034610285',	'458919','36.21742335',	'444458','11.05673831',	'522027','18.06129913',	'527889','38.49006859',	'539083','11.99658821',	'540105','30.36734165',	'526778','12.70377758',	'421847','39.95867749',	'535085','28.44546953',	'464299','14.82343451',	'526769','63.21581664',	'439027','22.25238012',	'532930','25.74674226',	'522688','15.86160383',	'536537','12.94788087',	'514895','25.9686791',	'427164','12.85348673',	'539028','37.77364802',	'548293','38.26533589',	'536380','62.54888997',	'491675','37.07768791',	'418668','39.23220626',	'524820','21.53510784',	'553096','20.94813298',	'521180','17.45489425',	'471703','23.24205958',	'543882','17.17139094',	'422100','41.83086825',	'491674','19.7968529',	'525718','9.511854951',	'410425','28.77081855',	'525662','26.43494191',	'542976','13.04179125',	'527437','16.90428898',	'515601','12.02182251',	'636368','15.59761887',	'515894','28.86941499',	'476608','37.04237528',	'516292','33.22766983',	'428268','18.59552771',	'415275','30.99598735',	'421958','21.28784662',	'518814','22.42810078',	'459314','27.84001621',	'525663','35.36346579',	'518454','26.40611215',	'544883','25.51103493',	'552937','21.07606711',	'531705','21.48180025',	'549159','31.02964244',	'552305','29.96658493',	'525664','24.16585683',	'516220','39.26333975',	'526863','25.58974848',	'455182','24.72697618',	'539090','22.30488784',	'547408','24.55999343',	'544540','32.97035706',	'476331','19.9434717',	'459077','42.5105029',	'552693','28.84478165',	'439388','31.10213589',	'541759','29.78925981',	'520977','25.35540172',	'529323','22.75156332',	'534513','21.87992759',	'542974','14.64059712',	'459384','25.28704344',	'485464','42.32909743',	'498431','43.99923322',	'489391','43.9026823',	'514087','12.73373774',	'406168','28.9207139',	'422200','47.54356154',	'536805','35.64084051',	'520132','29.77900308',	'410424','41.9627448',	'552236','25.96643058',	'539091','23.35626148',	'455181','28.92942112',	'506741','30.15859244',	'527497','27.05506917',	'552640','25.66210113',	'455183','23.58389281',	'515117','21.68754847',	'558763','28.35213358',	'459313','26.97707024',	'427167','22.44326798',	'415274','24.08619826',	'541555','38.55968479',	'522499','27.46706438',	'432032','24.43764243',	'441524','34.69693864',	'548474','19.49828878',	'536518','13.87995177',	'546056','31.79570439',	'548723','17.89342625',	'421848','45.60918112',	'418053','21.53463495',	'552128','43.80831384',	'514868','31.50480189',	'506778','30.32430359',	'512707','20.94116139',	'527407','36.22105876',	'552289','25.88080312',	'522840','32.31143074',	'544315','29.65582217',	'548985','23.66240781',	'530033','14.54143007',	'455184','27.53747036',	'528392','25.93942323',	'406669','39.12184358',	'554927','23.24409714',	'444054','45.44203242',	'525631','28.25024077',	'439354','41.81150071',	'548724','20.9552864',	'422053','48.91464189',	'459080','37.53013219',	'535858','22.69122283',	'470598','40.23184196',	'540593','25.75916591',	'544828','35.02670079',	'506775','28.03092301',	'525496','29.2471809',	'546452','21.71977691',	'459360','31.38166604',	'534503','30.16988832',	'548984','20.98107088',	'527468','23.45429528',	'531681','18.92085686',	'482425','22.40007889',	'459383','34.02198887',	'428267','21.66118372',	'422005','38.83813781',	'444456','19.6163803',	'412177','32.53973352',	'548573','32.848916',	'541187','34.79553569',	'550209','23.04964544',	'525320','30.54030673',	'535081','29.42238029',	'554906','19.67434717',	'530994','28.73389655',	'410863','27.46109375',	'527496','22.99900688',	'498408','26.53209411',	'520405','24.44096206',	'530034','23.64773801',	'549167','28.15012439',	'512682','19.15375225',	'406655','31.56179795',	'553636','32.28709071',	'523284','21.87710902',	'542820','25.34248878',	'498423','17.64844905',	'530780','23.31815568',	'514945','17.45593029',	'422061','75.12398774',	'498407','18.88155677',	'490172','38.21958155',	'546479','19.82854788',	'523421','21.33107815',	'498401','25.90670326',	'453211','29.22968372',	'515590','37.33324089',	'','41.17827255',	'498406','19.30308924',	'498453','21.82055909',	'606282','23.16158458',	'498442','27.80936629',	'544731','34.47567532')STD_CB_Lag
--,rate_of_change
,(select distinct first_value(payment_plan_code) over (order by cpg_transaction_id) from rcn_payment_transaction where division_order_id = First_Order_ID and transaction_type = 'Settle' and status = 'Completed')payment_plan_code
,(select distinct first_value(account_token) over (order by cpg_transaction_id) from rcn_payment_transaction where First_Order_ID = division_order_id and transaction_type = 'Settle' and status = 'Completed')account_token
,(select distinct first_value(trunc(cpg_creation_date)) over (order by cpg_transaction_id desc) from rcn_auth_trans where division_order_id = First_Order_ID and status = 'Completed')Prev_Date
,trial_status
,first_order_id
,contract_term_code
,add_months(expiration_date,1)expiration_date
,expirationdate
,issuer_country

from
(
select division_order_id
,division_site_id
,subscription_id
,cpg_creation_date
,payment_service_id
,payment_method_id
,payment_amount
,transaction_currency
,funding_source
,card_class
,Card_usage
,bin
,bank_Name
,merchant_number
,billing_country_id
--,merchantcontact
--,renewAttNum
--,cpg_attempt
--,cb_status
--,Prev_Order_ID
,Settle_Day
,to_char(Settle_Day, 'DD')Settle_Day_of_month
,(select distinct first_value(platform_order_id) over (order by src_create_dttm) from sub_seg_expire_dnorm where subscription_id = BD.subscription_id)First_Order_ID
,(select distinct first_value(subscription_type_code) over (order by purchase_dt) from sub_seg_expire_dnorm where BD.subscription_id = subscription_id)trial_status
,(select distinct first_value(contract_term_code) over (order by purchase_dt) from sub_seg_expire_dnorm where BD.subscription_id = subscription_id)contract_term_code
,(case when expirationdate like '%/%' then to_char(substr(expirationdate,1,2)) || '/1/20' || to_char(substr(expirationdate,4,2))
else to_char(substr(expirationdate,1,2)) || '/1/20' || to_char(substr(expirationdate,3,2)) end)expiration_date
,expirationdate
,issuer_country
--select *
from
(
select division_order_id
,division_site_id
--,subscription_id
,cpg_creation_date
,payment_service_id
,payment_method_id
,payment_amount
,transaction_currency
,billing_country_id
,substr(notes, instr(notes, 'class=',1,1) + length('class='), (instr(notes, ',',instr(notes, 'class=',1,1),1)) - (instr(notes, 'class=',1,1) + length('class=')))Card_Class
,substr(notes, instr(notes, 'countryID=',1,1) + length('countryID='), (instr(notes, ',',instr(notes, 'countryID=',1,1),1)) - (instr(notes, 'countryID=',1,1) + length('countryID=')))issuer_country
,substr(notes, instr(notes, 'usage=',1,1) + length('usage='), (instr(notes, ',',instr(notes, 'usage=',1,1),1)) - (instr(notes, 'usage=',1,1) + length('usage=')))Card_usage
,(case when notes like '%countryID%' then substr(notes, instr(notes, 'source=',1,1) + length('source='), (instr(notes, ',',instr(notes, 'source=',1,1),1)) - (instr(notes, 'source=',1,1) + length('source='))) else substr(notes, instr(notes, 'source=',1,1) + length('source='), (length(notes)) - (instr(notes, 'source=',1,1) + length('source=')) + 1) end)Funding_Source
,bank_name
,merchant_number
,(select distinct first_value(bin) over (order by transactionid) from ereport.cpg_transactions where division_order_id = divisionorderid and transactiontype = 'Authorize' and newstatus = 'Completed')BIN
,(select distinct first_value(expirationdate) over (order by transactionid) from ereport.cpg_transactions where division_order_id = divisionorderid and transactiontype = 'Authorize' and newstatus = 'Completed')expirationdate
,trunc(cpg_creation_date)Settle_Day
--,(select distinct first_value(subscription_type_code) over (order by purchase_dt) from sub_seg_expire_dnorm where ssed.subscription_id = subscription_id)trial_status
--,(select count(subscription_type_code) from sub_seg_expire_dnorm where ssed.subscription_id = subscription_id and subscription_type_code = 'RENEWED')renewal_num
--,(select count(subscription_type_code) from sub_seg_expire_dnorm where ssed.subscription_id = subscription_id and subscription_type_code <> 'ORIGINAL')Tenure
--,contract_term_code
,(select subscription_id from sub_seg_expire_dnorm ssed where rpt.division_order_id = ssed.platform_order_id and rownum < 2)subscription_id
--select *
from rcn_auth_trans rpt

where payment_method_id in ('MasterCard','Visa')
and transaction_type = 'Authorize'
and status = 'Completed'
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed')
and division_site_id = 'avast'
and creation_date > '11/1/2019'
    
)BD

)BD2

)BD3

where issuer_country in ('US','CA','AU','ES','FR')
and subscription_id is not null

    