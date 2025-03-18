select product_data_id
        ,display_name
        ,SKU

from cat_product_data

where modification_date > sysdate - 90
and company_id = 'samsungamericas'
and manufacturer = 'Samsung'
and retirement_date is null
and return_method = 'Physical'
