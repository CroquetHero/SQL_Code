select order_start
      ,term_unit
      ,term_length
      ,renewal_count
      ,subscription_id
      ,product_id
      ,count(subscription_id)units
      
      from
(
select subscription_id
      ,term_unit
      ,term_length
      ,sspd.product_id
      ,min(start_date)order_start
      ,count(start_date) - 1 Renewal_count

from sub_sli_plan_detail sspd, cat_product cp

where sspd.product_id = cp.product_id
--and sspd.creation_date >= sysdate - 600
--and start_date between sysdate - 600 and sysdate
--and sspd.product_id = '177549500'
and company_id = 'tmamer'

group by subscription_id
      ,term_unit
      ,term_length
      ,sspd.product_id

)
--where renewal_count > 0
group by order_start
      ,renewal_count
      ,term_unit
      ,term_length
      ,subscription_id
      ,product_id
      
      order by order_start