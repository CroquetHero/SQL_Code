select  *
from
(
select to_char(orf.creation_date,'MM-YYYY') mnth
, decode(is_fraud,'1','Fraud','Non_Fraud') refund_type
,(case when oa.platform ='globalCommerce' and oa.site_id = 'msstore' then 'MSSTORE' when oa.platform ='globalTech' and oa.site_id like '%MS%' then 'gT_MS' when oa.platform = 'globalCommerce' and oa.site_id in ('msedisus','msedpg','msedeu','msmacau','msmacbr','msmacca','msmacde','msmaceur','msmacfr','msmacgb','msmachk','msmacie','msmacjp','msmacus','msmacsg','msmacmx','msmacnz','msmaces','msmacus2','money','moneyca','moneyjp','mskrdvd','msaudvd','msmactau','msmactbr','msmactca','msmactde','msmactes','msmactfr','msmactgb','msmactie','msmactjp','msmactmx','msmactnz','msmactus','mswpus','mswpca','mswpmx','mswpfr','mswpuk','mswpde','mswpkr','mswpau','works','workscad','workseur','worksbra','worksrsa','msmacosx','robotics','msstore','msshuk','msshfr','itmssh','msshes','msshse','msshdk','msshbe','msshno','msshfi','msshde','msshpt','msshgb','msshau','msshus','msshca','msshkr','msshtw','msshmx','msshnz','money','msshau','msshes','msshtw','msshkr','msshmx','msshtw','msshuk','msshus','msstore') then 'gC_No_Store' else 'other' end) vert
, count(distinct(oa.order_id)) units
,sum(amount) amount
from order_refund orf, order_attempt oa
where orf.attempt_key = oa.attempt_key
and orf.creation_date between &&date1 and &&date2
and OA.PLATFORM in ('globalCommerce','globalTech')
group by  to_char(orf.creation_date,'MM-YYYY'), decode(is_fraud,'1','Fraud','Non_Fraud') ,(case when oa.platform ='globalCommerce' and oa.site_id = 'msstore' then 'MSSTORE' when oa.platform ='globalTech' and oa.site_id like '%MS%' then 'gT_MS' when oa.platform = 'globalCommerce' and oa.site_id in ('msedisus','msedpg','msedeu','msmacau','msmacbr','msmacca','msmacde','msmaceur','msmacfr','msmacgb','msmachk','msmacie','msmacjp','msmacus','msmacsg','msmacmx','msmacnz','msmaces','msmacus2','money','moneyca','moneyjp','mskrdvd','msaudvd','msmactau','msmactbr','msmactca','msmactde','msmactes','msmactfr','msmactgb','msmactie','msmactjp','msmactmx','msmactnz','msmactus','mswpus','mswpca','mswpmx','mswpfr','mswpuk','mswpde','mswpkr','mswpau','works','workscad','workseur','worksbra','worksrsa','msmacosx','robotics','msstore','msshuk','msshfr','itmssh','msshes','msshse','msshdk','msshbe','msshno','msshfi','msshde','msshpt','msshgb','msshau','msshus','msshca','msshkr','msshtw','msshmx','msshnz','money','msshau','msshes','msshtw','msshkr','msshmx','msshtw','msshuk','msshus','msstore') then 'gC_No_Store' else 'other' end) 
)
where vert <> 'other'
order by vert, mnth, refund_type desc
