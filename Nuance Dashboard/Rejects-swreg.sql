select count(cart_session_id)rjr_units, round(sum(usd),2)rjr_usd

from

(
select cart_session_id, avg(USD)usd

from

(
select data2.order_date
      ,cart_session_id
      ,USD
      ,(case when USD < (data1.avrg +(data1.stdv*2)) then '0' else '1' end) as cntrl

from 

(

select trunc(oa.platform_order_date) as order_date
      ,stddev(usd_order_total)stdv
      ,avg(usd_order_total)avrg 
      
      from order_attempt oa, order_attempt_item  oai
      
      where oa.attempt_key = oai.attempt_key 
      and platform = 'swreg'
      and vendor_id in ('128668')  
      and return_code = '1000'
      and oa.platform_order_date between '01-sep-12' and '11-sep-12'
      
      group by trunc(oa.platform_order_date)
      
      --order by order_date
      
      )data1 right join 
      
      (
     select trunc(oa.platform_order_date) as order_date
           ,cart_session_id
           ,usd_order_total as USD
      from order_attempt oa, order_attempt_item oai
        where oa.attempt_key = oai.attempt_key
        and oa.platform = 'swreg'
        and oai.vendor_id in ('128668')
        and oa.return_code between 4000 and 5000 
        and oa.platform_order_date between '01-sep-12' and '11-sep-12'
      )data2
      
      on data1.order_date = data2.order_date
      
      )
      
      where cntrl = '0'
   group by cart_session_id--, order_date
   
   )
 --  group by order_date
   
 --  order by order_date
   