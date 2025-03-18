select  *
from
(
select to_char(orf.creation_date,'MM/YYYY') mnth
, decode(is_fraud,'1','Fraud','Non_Fraud') refund_type
,oai.vendor_id 
,count(distinct(oai.attempt_key)) units 
,sum(item_total) amount
from order_refund orf, order_attempt_item oai
where orf.attempt_key = oai.attempt_key
and orf.creation_date between &&date1 and &&date2
and oai.vendor_id in ('138084','134968','137777','128668','137505','136354','135966','133253','131089','135860','134442','135927','137729','122967')
--and OA.PLATFORM in ('globalCommerce','globalTech')
group by to_char(orf.creation_date,'MM/YYYY'), decode(is_fraud,'1','Fraud','Non_Fraud'),oai.vendor_id 
)
order by vendor_id, mnth, refund_type desc
