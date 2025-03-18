select *

from
(
select (case when division_site_id in ('adbectru','adbehap','adbectem','adbehbr','adbeheu','adbecnn','adbesttw','adbehme','adbestkr','adbehru','adbehtw','adbehil','adbectar','adbestcn','adbestap','adbehcn','adbehkr','adbectap') then 'Adobe'
when division_site_id in ('client4.com','gw2') then 'ArenaNet'
when division_site_id in ('avast','avastjp','avastbr','nds_avast') then 'Avast'
when division_site_id in ('avgstore','avgbr') then 'AVG Technologies'
when division_site_id in ('defenduk','defendwo','defendes','defendbr','defendde','defender') then 'BitDefender'
when division_site_id in ('bbrryeu','rimerow','bbrryus','rimeus','rimeca') then 'BlackBerry'
when division_site_id in ('code42','c42pro','cphome') then 'Code42 Software'
when division_site_id in ('crelcorp','corelna','crelapac') then 'Corel'
when division_site_id in ('digitalextremes.com') then 'Digital Extremes'
when division_site_id in ('flirsys') then 'FLIR Systems'
when division_site_id in ('htcus','htcemea','htcapac','htc.com') then 'HTC'
when division_site_id in ('izotope') then 'iZotope'
when division_site_id in ('kasperbr','kasucpbr','kasper','kasperla','kasperuk','kasperoe','kaspersk','kasucpla','kasucpuk','kasb2bgl','kaspernl','kasperus','kasperde','kasucpde','kaspergl','kasucpus','kasperjp','kasucpkr','kasucpru','kasperft') then 'Kaspersky'
when division_site_id in ('lenovb2b','lenovoeu') then 'Lenovo'
when division_site_id in ('logieu','logib2c','logiaunz','logitw') then 'Logitech'
when division_site_id in ('470','581','583','585','587','589','590','595','596','614','621','622','623','624','625','626','633') then 'MSFT Hup'
when division_site_id in ('ncsoft','ncsoft2') then 'NCSOFT'
when division_site_id in ('nuanceus','nuanceeu','scsoftAP','nuancesm') then 'Nuance'
when division_site_id in ('nvsubs','nvidiadv','nvidia','nvidiamr') then 'Nvidia'
when division_site_id in ('razeraus','razertw','razereu','razerusa') then 'Razer'
when division_site_id in ('samsung') then 'Samsung'
when division_site_id in ('tk2irr') then 'Take-Two'
when division_site_id in ('techsm','techsmit') then 'TechSmith'
when division_site_id in ('tmoemas','trendsb','tmoemap','tmoemem','tmpsus','trendtw','trendoem','tmsboeme','tmapac','trendcn','tmecon','tmsboema','tmsboemn','tmemea','tmsboemj','tmsbeu','tmpsjp','nds_tm','tmamer','tmpsap','tmpseu') then 'Trend'
when division_site_id in ('vmwjapan','vmwbr','vmwde','vmware','vmwren','mylearn','vmwaus') then 'Vmware'
when division_site_id in ('wdau','wdeu','wdus') then 'Western Digital'
when division_site_id in ('zenimax.com','bethesda') then 'Zenimax'
else 'Other' end)Client
,division_site_id
,region_code
,decode(country_code,'AF','Asia',	'AX','Europe',	'AL','Europe',	'DZ','Africa',	'AS','Oceania',	'AD','Europe',	'AO','Africa',	'AI','Americas',	'AQ','',	'AG','Americas',	'AR','Americas',	'AM','Asia',	'AW','Americas',	'AU','Oceania',	'AT','Europe',	'AZ','Asia',	'BS','Americas',	'BH','Asia',	'BD','Asia',	'BB','Americas',	'BY','Europe',	'BE','Europe',	'BZ','Americas',	'BJ','Africa',	'BM','Americas',	'BT','Asia',	'BO','Americas',	'BQ','Americas',	'BA','Europe',	'BW','Africa',	'BV','',	'BR','Americas',	'IO','',	'BN','Asia',	'BG','Europe',	'BF','Africa',	'BI','Africa',	'KH','Asia',	'CM','Africa',	'CA','Americas',	'CV','Africa',	'KY','Americas',	'CF','Africa',	'TD','Africa',	'CL','Americas',	'CN','Asia',	'CX','',	'CC','',	'CO','Americas',	'KM','Africa',	'CG','Africa',	'CD','Africa',	'CK','Oceania',	'CR','Americas',	'CI','Africa',	'HR','Europe',	'CU','Americas',	'CW','Americas',	'CY','Asia',	'CZ','Europe',	'DK','Europe',	'DJ','Africa',	'DM','Americas',	'DO','Americas',	'EC','Americas',	'EG','Africa',	'SV','Americas',	'GQ','Africa',	'ER','Africa',	'EE','Europe',	'ET','Africa',	'FK','Americas',	'FO','Europe',	'FJ','Oceania',	'FI','Europe',	'FR','Europe',	'GF','Americas',	'PF','Oceania',	'TF','',	'GA','Africa',	'GM','Africa',	'GE','Asia',	'DE','Europe',	'GH','Africa',	'GI','Europe',	'GR','Europe',	'GL','Americas',	'GD','Americas',	'GP','Americas',	'GU','Oceania',	'GT','Americas',	'GG','Europe',	'GN','Africa',	'GW','Africa',	'GY','Americas',	'HT','Americas',	'HM','',	'VA','Europe',	'HN','Americas',	'HK','Asia',	'HU','Europe',	'IS','Europe',	'IN','Asia',	'ID','Asia',	'IR','Asia',	'IQ','Asia',	'IE','Europe',	'IM','Europe',	'IL','Asia',	'IT','Europe',	'JM','Americas',	'JP','Asia',	'JE','Europe',	'JO','Asia',	'KZ','Asia',	'KE','Africa',	'KI','Oceania',	'KP','Asia',	'KR','Asia',	'KW','Asia',	'KG','Asia',	'LA','Asia',	'LV','Europe',	'LB','Asia',	'LS','Africa',	'LR','Africa',	'LY','Africa',	'LI','Europe',	'LT','Europe',	'LU','Europe',	'MO','Asia',	'MK','Europe',	'MG','Africa',	'MW','Africa',	'MY','Asia',	'MV','Asia',	'ML','Africa',	'MT','Europe',	'MH','Oceania',	'MQ','Americas',	'MR','Africa',	'MU','Africa',	'YT','Africa',	'MX','Americas',	'FM','Oceania',	'MD','Europe',	'MC','Europe',	'MN','Asia',	'ME','Europe',	'MS','Americas',	'MA','Africa',	'MZ','Africa',	'MM','Asia',	'NA','Africa',	'NR','Oceania',	'NP','Asia',	'NL','Europe',	'NC','Oceania',	'NZ','Oceania',	'NI','Americas',	'NE','Africa',	'NG','Africa',	'NU','Oceania',	'NF','Oceania',	'MP','Oceania',	'NO','Europe',	'OM','Asia',	'PK','Asia',	'PW','Oceania',	'PS','Asia',	'PA','Americas',	'PG','Oceania',	'PY','Americas',	'PE','Americas',	'PH','Asia',	'PN','Oceania',	'PL','Europe',	'PT','Europe',	'PR','Americas',	'QA','Asia',	'RE','Africa',	'RO','Europe',	'RU','Europe',	'RW','Africa',	'BL','Americas',	'SH','Africa',	'KN','Americas',	'LC','Americas',	'MF','Americas',	'PM','Americas',	'VC','Americas',	'WS','Oceania',	'SM','Europe',	'ST','Africa',	'SA','Asia',	'SN','Africa',	'RS','Europe',	'SC','Africa',	'SL','Africa',	'SG','Asia',	'SX','Americas',	'SK','Europe',	'SI','Europe',	'SB','Oceania',	'SO','Africa',	'ZA','Africa',	'GS','',	'SS','Africa',	'ES','Europe',	'LK','Asia',	'SD','Africa',	'SR','Americas',	'SJ','Europe',	'SZ','Africa',	'SE','Europe',	'CH','Europe',	'SY','Asia',	'TW','Asia',	'TJ','Asia',	'TZ','Africa',	'TH','Asia',	'TL','Asia',	'TG','Africa',	'TK','Oceania',	'TO','Oceania',	'TT','Americas',	'TN','Africa',	'TR','Asia',	'TM','Asia',	'TC','Americas',	'TV','Oceania',	'UG','Africa',	'UA','Europe',	'AE','Asia',	'GB','Europe',	'US','Americas',	'UM','',	'UY','Americas',	'UZ','Asia',	'VU','Oceania',	'VE','Americas',	'VN','Asia',	'VG','Americas',	'VI','Americas',	'WF','Oceania',	'EH','Africa',	'YE','Asia',	'ZM','Africa',	'ZW','Africa','Other')locale
,payment_method_id
,bank_name
,division_order_id
,(case when (select min(cpg_creation_date) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed') is not null then (select min(cpg_creation_date) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed')
when (select min(cpg_creation_date) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Failed') is not null then (select min(cpg_creation_date) from rcn_auth_trans where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Failed')
else (select min(cpg_creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') end)auth_time
,(select sum(usd_payment_amount) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')settle_amount
,country_code
,(case when (select subscription_id from SUB_SEG_EXPIRE_DNORM where platform_order_id = rpt.division_order_id and rownum <2) is not null then 'Subscription' else 'Non-Subscription' end)subscription_status
,response_code CB_Code
,cpg_creation_date CB_Time
,usd_payment_amount CB_Amount
,(select sum(usd_payment_amount) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')Refund_amount

from rcn_payment_transaction rpt

where creation_date between trunc(sysdate) - 2 and trunc(sysdate)
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_method_id <> 'MicrosoftPayment'

)

where Client <> 'Other'

