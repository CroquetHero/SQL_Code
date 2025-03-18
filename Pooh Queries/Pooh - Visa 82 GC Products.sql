select display_name
      ,(case when is_shipping_method_reqd = '1' then 'Physical' else 'Digital' end)order_type
      ,sum(quantity)units
      ,sum(item_price_num)usd
      ,round(sum(item_price_num)/count(item_price_num),2)price

from req_line_item rli, cat_product_data cpd

where rli.product_data_id = cpd.product_data_id
and requisition_id in 

group by display_name
,(case when is_shipping_method_reqd = '1' then 'Physical' else 'Digital' end)

order by units desc