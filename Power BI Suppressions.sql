select Client
,site_id
,(case when payment_type = 'cpgCreditCard' and payment_mask = '3' then 'AmericanExpress'
when payment_type = 'cpgCreditCard' and payment_mask = '4' then 'Visa'
when payment_type = 'cpgCreditCard' and payment_mask = '5' then 'MasterCard'
when payment_type = 'cpgCreditCard' and payment_mask = '6' then 'Discover'
else payment_type end)payment_type
,bill_to_country
,order_id
,Suppression_Date
,usd_order_total
,(case when subscription = '0' then 'Non-Subscription'
when subscription = '1' then 'Subscription'
else 'Other' end)subscription_status

from
(
select (case when site_id in ('adbectru','adbehap','adbectem','adbehbr','adbeheu','adbecnn','adbesttw','adbehme','adbestkr','adbehru','adbehtw','adbehil','adbectar','adbestcn','adbestap','adbehcn','adbehkr','adbectap') then 'Adobe'
when site_id in ('client4.com','gw2') then 'ArenaNet'
when site_id in ('avast','avastjp','avastbr','nds_avast') then 'Avast'
when site_id in ('avgstore','avgbr') then 'AVG Technologies'
when site_id in ('defenduk','defendwo','defendes','defendbr','defendde','defender') then 'BitDefender'
when site_id in ('bbrryeu','rimerow','bbrryus','rimeus','rimeca') then 'BlackBerry'
when site_id in ('code42','c42pro','cphome') then 'Code42 Software'
when site_id in ('crelcorp','corelna','crelapac') then 'Corel'
when site_id in ('digitalextremes.com') then 'Digital Extremes'
when site_id in ('flirsys') then 'FLIR Systems'
when site_id in ('htcus','htcemea','htcapac','htc.com') then 'HTC'
when site_id in ('izotope') then 'iZotope'
when site_id in ('kasperbr','kasucpbr','kasper','kasperla','kasperuk','kasperoe','kaspersk','kasucpla','kasucpuk','kasb2bgl','kaspernl','kasperus','kasperde','kasucpde','kaspergl','kasucpus','kasperjp','kasucpkr','kasucpru','kasperft') then 'Kaspersky'
when site_id in ('lenovb2b','lenovoeu') then 'Lenovo'
when site_id in ('logieu','logib2c','logiaunz','logitw') then 'Logitech'
when site_id in ('470','581','583','585','587','589','590','595','596','614','621','622','623','624','625','626','633') then 'MSFT Hup'
when site_id in ('ncsoft','ncsoft2') then 'NCSOFT'
when site_id in ('nuanceus','nuanceeu','scsoftAP','nuancesm') then 'Nuance'
when site_id in ('nvsubs','nvidiadv','nvidia','nvidiamr') then 'Nvidia'
when site_id in ('razeraus','razertw','razereu','razerusa') then 'Razer'
when site_id in ('samsung') then 'Samsung'
when site_id in ('tk2irr') then 'Take-Two'
when site_id in ('techsm','techsmit') then 'TechSmith'
when site_id in ('tmoemas','trendsb','tmoemap','tmoemem','tmpsus','trendtw','trendoem','tmsboeme','tmapac','trendcn','tmecon','tmsboema','tmsboemn','tmemea','tmsboemj','tmsbeu','tmpsjp','nds_tm','tmamer','tmpsap','tmpseu') then 'Trend'
when site_id in ('vmwjapan','vmwbr','vmwde','vmware','vmwren','mylearn','vmwaus') then 'Vmware'
when site_id in ('wdau','wdeu','wdus') then 'Western Digital'
when site_id in ('zenimax.com','bethesda') then 'Zenimax'
else 'Other' end)Client
,oa.site_id
--,oa.country_iso
,(select payment_method from order_attempt_payment where oa.attempt_key = attempt_key)payment_type
,substr((select payment_mask from order_attempt_payment where oa.attempt_key = attempt_key),0,1)payment_mask
,oa.country_iso bill_to_country
,oa.order_id
,orf.refund_date Suppression_Date
,oa.usd_order_total
,(select max(is_subscription) from order_attempt_item where oa.attempt_key = attempt_key)subscription

from order_attempt oa, order_refund orf

where oa.attempt_key = orf.attempt_key
and orf.refund_date between trunc(sysdate) - 1 and trunc(sysdate)
and reason_code = 'Suppression refund'
--and oa.return_code between 4000 and 5000
--and oa.order_id in ('14169329871','14165773671','22725269462')

)

where client <> 'Other'