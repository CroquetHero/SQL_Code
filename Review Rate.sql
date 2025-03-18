select payment_method
      ,oa.site_id
      ,return_code
      ,count(oa.order_id)units
      ,sum(usd_order_total)usd

from order_attempt oa, order_attempt_payment oap

where oa.attempt_key = oap.attempt_key
and oa.platform_order_date > '01-jan-15'
and oa.platform = 'globalCommerce'
and oa.return_code in ('2018','4073')
--and oa.order_id ='9463974457'

group by payment_method,site_id,return_code