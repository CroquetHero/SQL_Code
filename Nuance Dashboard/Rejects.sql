select count(cart_session_id)rjr_units, round(sum(usd),2)rjr_usd

from

(
select cart_session_id, avg(USD)usd

from

(
select data1.platform_order_date as order_date
      ,cart_session_id
      ,USD
      ,(case when USD < (data1.avrg +(data1.stdv*2)) then '0' else '1' end) as cntrl

from 

(

select trunc(platform_order_date) as platform_order_date
      ,stddev(usd_order_total)stdv
      ,avg(usd_order_total)avrg 
      
      from order_attempt  
      
      where platform = 'globalCommerce'  
      and site_id in ('scsoftap','dictapho','nuanceus','nuanceeu','nuance','nuaeduus','nuaeduuk','nuaeduau','nuaedude','nuaedues','nuaeduca','nuaresau','nuancvl') 
      and return_code = '1000'
      and platform_order_date between '01-sep-12' and '11-sep-12'
      
      group by trunc(platform_order_date)
      
      
      )data1 full join 
      
      (
     select trunc(platform_order_date) as platform_order_date
           ,cart_session_id
           ,usd_order_total as USD
      from order_attempt oa
        
        where oa.platform = 'globalCommerce'
        and oa.site_id in ('scsoftap','dictapho','nuanceus','nuanceeu','nuance','nuaeduus','nuaeduuk','nuaeduau','nuaedude','nuaedues','nuaeduca','nuaresau','nuancvl')
        and oa.return_code between 4000 and 5000 
        and oa.platform_order_date between '01-sep-12' and '11-sep-12'
      )data2
      
      on data1.platform_order_date = data2.platform_order_date
      
      )
      
      where cntrl = '0'
   group by cart_session_id--, order_date
   
   )
 --  group by order_date
   
 --  order by order_date
   