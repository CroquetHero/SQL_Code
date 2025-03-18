select month
,payment_service_id
,transaction_type
,client
,count(transaction_id)units
,sum(request_money_amount)usd

from
(
select to_char(creation_date,'MM/YYYY')month
,payment_service_id
,transaction_type
,(case when division_site_id in ('wdus','wdeu') then 'Western Digital'
when division_site_id in ('targusus') then 'Targus'
when division_site_id in ('slingbox') then 'Sling Box'
when division_site_id in ('sennww') then ' Sennheiser '
when division_site_id in ('sdiskus') then 'SanDisk'
when division_site_id in ('samsung2','samsung') then 'Samsung'
when division_site_id in ('razerusa','razertw','razereu','razeraus') then 'Razer'
when division_site_id in ('plt') then 'PLT'
when division_site_id in ('omron') then 'Omron'
when division_site_id in ('nvidia') then 'Nvidia'
when division_site_id in ('nokiagl') then 'Nokia'
when division_site_id in ('lominger') then 'Lominger'
when division_site_id in ('logieu','logib2c') then 'Logitech'
when division_site_id in ('lgus') then 'LG'
when division_site_id in ('lenovoeu','lenovb2b') then 'Lenovo'
when division_site_id in ('lenbrook') then 'LenBrook'
when division_site_id in ('kodak') then 'Kodak'
when division_site_id in ('jabra') then 'Jabra'
when division_site_id in ('htcus','htcemea','htcapac') then 'HTC'
when division_site_id in ('furlaus','furlau','furlajp','furlaeu') then 'Furla'
when division_site_id in ('fujitsu') then 'Fujitsu'
when division_site_id in ('flirsys') then 'Flir'
when division_site_id in ('citrix') then 'Citrix'
when division_site_id in ('canary') then 'Canary'
when division_site_id in ('bqeu') then 'BenQ'
when division_site_id in ('bluemic') then 'BlueMic'
when division_site_id in ('bbrryus') then 'Blackberry'
when division_site_id in ('asusau') then 'Asus'
else 'Other' end)Client
,transaction_id
,request_money_amount
,(case when transaction_type = 'ChargeBack' and creation_date > (select max(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type  ='ChargeBack' and status = 'Completed') then 'Ignore' else 'Good' end)status

from cpg_payment_transaction rpt

where creation_date between '1/1/2017' and '11/1/2017'
and transaction_type in ('Settle','ChargeBack')
and status = 'Completed'
and request_money_currency = 'USD'
and payment_method_id = 'Visa'
and division_id = 'pacific'
and division_site_id in ('wdus','wdeu','targusus','slingbox','sennww','sdiskus','samsung2','samsung','razerusa','razertw','razereu','razeraus','plt','omron','nvidia','nokiagl','lominger','logieu','logib2c','lgus','lenovoeu','lenovb2b','lenbrook','kodak','jabra','htcus','htcemea','htcapac','furlaus','furlau','furlajp','furlaeu','fujitsu','flirsys','citrix','canary','bqeu','bluemic','bbrryus','asusau')

)

where status <> 'Ignore'

group by month
,payment_service_id
,transaction_type
,client
