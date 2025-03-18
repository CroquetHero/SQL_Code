select action_day
,Orig_expir_Date
,New_expir_Date
,initiator
,reason_code
,site_id
,(case when display_name like '%1 year%' then 'One Year'
when display_name like '%1 Year%' then 'One Year'
when display_name like '%1yr%' then 'One Year'
when display_name like '%2 year%' then 'Two Year'
when display_name like '%2 Year%' then 'Two Year'
when display_name like '%2yr%' then 'Two Year'
when display_name like '%3 year%' then 'Three Year'
when display_name like '%3 Year%' then 'Three Year'
when display_name like '%3yr%' then 'Three Year'
else display_name end)sub_length
--,expiration_date
,count(subscription_id)units
--select *
from 
(
select subscription_id
,action_day
,initiator
,reason_code
--,orig_exp_date
--,New_exp_date
,(Orig_Month ||'/'||Orig_Day||'/'||Orig_Year) Orig_expir_Date
,(New_Month ||'/'||New_Day||'/'||New_Year)New_expir_Date
--,grace_period_date
,expiration_date
,site_id
,display_name
,name

from
(
SELECT ssl.subscription_id
,trunc(ssl.creation_date)action_day
--,ssli.grace_period_date
,ssli.expiration_date
,substr(description, instr(description, 'Expriation date',1)+34,7) || substr(description, instr(description, 'Expriation date',1)+54,4) orig_exp_date
,substr(description, instr(description, 'to',1)+7, 7) || substr(description, instr(description, 'to',1)+27, 4)New_exp_date
,(case when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Jan' then 1
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Feb' then 2
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Mar' then 3
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Apr' then 4
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'May' then 5
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Jun' then 6
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Jul' then 7
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Aug' then 8
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Sep' then 9
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Oct' then 10
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Nov' then 11
when substr(description, instr(description, 'Expriation date',1)+34,3) = 'Dec' then 12
else 40000 end)orig_month
,(case when substr(description, instr(description, 'Expriation date',1)+38,1) = '0' then substr(description, instr(description, 'Expriation date',1)+39,1)
else substr(description, instr(description, 'Expriation date',1)+38,2) end)orig_day
,substr(description, instr(description, 'Expriation date',1)+54,4)orig_year
,substr(description, instr(description, 'to',1)+27, 4)New_Year
,(case when substr(description, instr(description, 'to',1)+7, 3) = 'Jan' then 1
when substr(description, instr(description, 'to',1)+7, 3) = 'Feb' then 2
when substr(description, instr(description, 'to',1)+7, 3) = 'Mar' then 3
when substr(description, instr(description, 'to',1)+7, 3) = 'Apr' then 4
when substr(description, instr(description, 'to',1)+7, 3) = 'May' then 5
when substr(description, instr(description, 'to',1)+7, 3) = 'Jun' then 6
when substr(description, instr(description, 'to',1)+7, 3) = 'Jul' then 7
when substr(description, instr(description, 'to',1)+7, 3) = 'Aug' then 8
when substr(description, instr(description, 'to',1)+7, 3) = 'Sep' then 9
when substr(description, instr(description, 'to',1)+7, 3) = 'Oct' then 10
when substr(description, instr(description, 'to',1)+7, 3) = 'Nov' then 11
when substr(description, instr(description, 'to',1)+7, 3) = 'Dec' then 12
else 40000 end)New_Month
,(case when substr(description, instr(description, 'to',1)+11, 1) = '0' then substr(description, instr(description, 'to',1)+12, 1)
else substr(description, instr(description, 'to',1)+11, 2) end)New_Day
,initiator
,reason_code
,rli.site_id
,cpd.display_name
,cpd.name
--select *
FROM SUB_SUBSCRIPTION_LOG SSL, sub_subscription_li_item SSLI, REQ_LINE_ITEM rli, cat_product_data cpd

where ssl.subscription_id = ssli.subscription_id
and ssli.req_line_item_id = rli.line_item_id
and rli.product_data_id = cpd.product_data_id
and ssl.creation_date > trunc(sysdate) - 5
and action = 'ACTION_SUBSCRIPTION_EXP_DATE_CHANGE'
and description like '%Expiration%'
--and ssl.subscription_id = '9728390701'

)
where site_id = 'tmamer'

)

where New_expir_Date = expiration_date

group by action_day
,Orig_expir_Date
,New_expir_Date
,initiator
,reason_code
,site_id
,(case when display_name like '%1 year%' then 'One Year'
when display_name like '%1 Year%' then 'One Year'
when display_name like '%1yr%' then 'One Year'
when display_name like '%2 year%' then 'Two Year'
when display_name like '%2 Year%' then 'Two Year'
when display_name like '%2yr%' then 'Two Year'
when display_name like '%3 year%' then 'Three Year'
when display_name like '%3 Year%' then 'Three Year'
when display_name like '%3yr%' then 'Three Year'
else display_name end)
--,expiration_date