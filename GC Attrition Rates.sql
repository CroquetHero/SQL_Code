select orig_date
      ,units sub_length
      ,count(subscription_id)units
      
      from
(
select subscription_id
      ,orig_date
    --  ,product_data_id
      ,count(units)units
      
      from
(
select subscription_id
    --  ,product_data_id
      ,(select min(trunc(creation_date)) from sub_subscription_li_item  where ssli.subscription_id = subscription_id and line_item_type = 'ORIGINAL')Orig_date
      ,sub_line_item_id units

from sub_subscription_li_item ssli, req_line_item rli

where ssli.req_line_item_id = rli.line_item_id
--and line_item_type = 'ORIGINAL'
--and ssli.creation_date > sysdate - 10
and subscription_id in (

select distinct subscription_id

from sub_subscription_li_item ssli, req_line_item rli,cat_product_data cpd

where ssli.req_line_item_id = rli.line_item_id
and rli.product_data_id = cpd.product_data_id
--and name in ('DE - Base - Kaspersky Internet Security 2013 - 1PC - Auto Renewal Service - Monthly','DE - Monthly Sub - Renewal - Kaspersky Internet Security 2013 - Auto Renewal Service','DE - Monthly Sub - Renewal - Kaspersky Internet Security 2014 1PC - Auto Renewal Service','DE - Monthly Sub - Base - Kaspersky Internet Security 2014 - 1PC - Auto Renewal Service')
and ssli.creation_date between '01-sep-09' and '01-oct-09'
and rli.site_id = 'kasperus'
and ssli.line_item_type = 'ORIGINAL'
and name like '%Year%'
and purchased_duration_date - activation_date between 330 and 400
--and rownum < 1001

)

)

group by subscription_id,orig_date--,product_data_id

--order by units desc, orig_date

)

group by orig_date
      ,units
      
      order by orig_date