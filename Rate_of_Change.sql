select ORDER_ID
,subscription_id
,next_renewal_date
,display_name
,Product_Group
,Tenure
,(case when New_Sub_Price is null and STD_New_price = 0 then AVG_New_price else New_Sub_Price end)New_Sub_Price
,BD.product_id

from
(
select requisition_id ORDER_ID
,ssli.subscription_id
,next_renewal_date
,display_name
,substr(display_name, 1 , instr(display_name,'-',1,1) - 2)Product_Group
--,(select distinct first_value(line_item_type) over (order by creation_date) from sub_subscription_li_item where ssli.subscription_id = subscription_id)trial_status
,(select count(line_item_type) from sub_subscription_li_item where ssli.subscription_id = subscription_id and line_item_type <> 'ORIGINAL')Tenure
,(select distinct first_value(price_amt) over (order by segment_number_end_hold) from SUB_SUBSCRIPTION_HOLD_PRICE where subscription_id = ssli.subscription_id)New_Sub_Price
,(rli.item_price_num + rli.tax_num)Order_amount
,rli.item_price_num
,rli.tax_num
,cpd.product_id

--select *
from sub_subscription_li_item ssli, req_line_item rli, cat_product_data cpd

where ssli.req_line_item_id = rli.line_item_id
and rli.product_data_id = cpd.product_data_id 
and site_id = 'avastbr'
and next_renewal_date between '9/17/2019' and '10/1/2019'

)BD

left join

(
select cpd.product_id
,round(avg(price_amt),5)AVG_New_price
,round(stddev(price_amt),5)STD_New_price
,count(sshp.subscription_id)units

from sub_subscription_li_item ssli, req_line_item rli, cat_product_data cpd, SUB_SUBSCRIPTION_HOLD_PRICE sshp

where ssli.req_line_item_id = rli.line_item_id
and ssli.subscription_id = sshp.subscription_id
and rli.product_data_id = cpd.product_data_id 
and site_id = 'avastbr'
and next_renewal_date between '9/17/2019' and '10/1/2019'

group by cpd.product_id

order by units desc

)Future_Price

on Future_Price.product_id = BD.product_id
