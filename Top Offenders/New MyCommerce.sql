select division_id
,division_site_id
,merchant_descriptor
,Current_Settle_Units
,Current_CB_Units
,Current_Settle_USD
,Current_CB_USD
,Last_month_settle_units
,Last_month_cb_units
,Last_last_month_settle_units
,Last_last_month_cb_units
,Current_Unit_Rate
,Current_USD_Rate
,Prev_month_Unit_Rate
,Prev_month_USD_Rate
,Prev_prev_Unit_Rate
,Prev_prev_USD_Rate
,(case when current_cb_units > 10 and Current_Unit_Rate > .05 and Prev_month_Unit_Rate > .05 and Prev_prev_Unit_Rate > .05 then 'Red'
when current_cb_units between 4 and 9 and Current_Unit_Rate > .08 and Prev_month_Unit_Rate > .08 and Prev_prev_Unit_Rate > .08 then 'Red'
when current_cb_units > 10 and Current_Unit_Rate > .05 then 'Light Red'
when current_cb_units between 4 and 9 and Current_Unit_Rate > .08 then 'Light Red'
when current_cb_units > 10 and Current_Unit_Rate > .02 and Prev_month_Unit_Rate > .02 and Prev_prev_Unit_Rate > .02 then 'Light Red'
when current_cb_units > 10 and Current_Unit_Rate > .02 then 'Yellow'
when current_cb_units > 10 and Current_Unit_Rate > .015 then 'Light Yellow'
when current_cb_units between 4 and 9 and Current_Unit_Rate > .05 then 'Light Yellow'
when current_cb_units <= 10 and Current_Unit_Rate < .05 then 'Green'
when current_cb_units > 10 and Current_Unit_Rate < .015 then 'Green'
when current_settle_units is null then 'Brown'
when current_cb_units is null then 'Green'
else 'Green' end)Warning_flag

from
(
select BD.division_id
,BD.division_site_id
,BD.merchant_descriptor
,BD.settle_units Current_Settle_Units
,BD.cb_units Current_CB_Units
,BD.settle_usd Current_Settle_USD
,BD.cb_usd Current_CB_USD
,Last_month_settle_units
,Last_month_cb_units
,Prev_prev.settle_units Last_last_month_settle_units
,Prev_prev.cb_units Last_last_month_cb_units
,Prev_prev.settle_usd Last_last_month_settle_usd
,Prev_prev.cb_usd Last_last_month_cb_usd
,round(BD.cb_units/BD.settle_units,3) Current_Unit_Rate
,round(BD.cb_usd/BD.settle_usd,3) Current_USD_Rate
,BD.Prev_month_Unit_Rate
,BD.Prev_month_USD_Rate
,round(Prev_prev.cb_units/Prev_prev.settle_units,3) Prev_prev_Unit_Rate
,round(Prev_prev.cb_usd/Prev_prev.settle_usd,3) Prev_prev_USD_Rate

from
(
select Current_month.division_id
,Current_month.division_site_id
,Current_month.merchant_descriptor
,Current_month.settle_units
,Current_month.cb_units
,Current_month.settle_usd
,Current_month.cb_usd
,Prev_month.settle_units Last_month_settle_units
,Prev_month.cb_units Last_month_cb_units
,Prev_month.settle_usd Last_month_settle_usd
,Prev_month.cb_usd Last_month_cb_usd
,round(Prev_month.cb_units/Prev_month.settle_units,3) Prev_month_Unit_Rate
,round(Prev_month.cb_usd/Prev_month.settle_usd,3) Prev_month_USD_Rate

from
(
select (case when sale.division_id is null then cb.division_id else sale.division_id end)division_id
,(case when sale.division_site_id is null then cb.division_site_id else sale.division_site_id end)division_site_id
,(case when sale.merchant_descriptor is null then cb.merchant_descriptor else sale.merchant_descriptor end)merchant_descriptor
,settle_units
,settle_usd
,CB_units
,CB_usd

from
(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)settle_units
,sum(usd_payment_amount)settle_usd

from rcn_payment_transaction rpt

where creation_date between '7/1/2019' and '8/1/2019'
and transaction_type in ('Settle')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('Settle') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor

)Sale

full join

(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)cb_units
,sum(usd_payment_amount)cb_usd

from rcn_payment_transaction rpt

where creation_date between '7/1/2019' and '8/1/2019'
and transaction_type in ('ChargeBack')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBack') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor
)CB

on sale.division_id = cb.division_id
and sale.division_site_id = cb.division_site_id
and sale.merchant_descriptor = cb.merchant_descriptor

)Current_month

left join

(

select (case when sale.division_id is null then cb.division_id else sale.division_id end)division_id
,(case when sale.division_site_id is null then cb.division_site_id else sale.division_site_id end)division_site_id
,(case when sale.merchant_descriptor is null then cb.merchant_descriptor else sale.merchant_descriptor end)merchant_descriptor
,settle_units
,settle_usd
,CB_units
,CB_usd

from
(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)settle_units
,sum(usd_payment_amount)settle_usd

from rcn_payment_transaction rpt

where creation_date between '6/1/2019' and '7/1/2019'
and transaction_type in ('Settle')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('Settle') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor

)Sale

full join

(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)cb_units
,sum(usd_payment_amount)cb_usd

from rcn_payment_transaction rpt

where creation_date between '6/1/2019' and '7/1/2019'
and transaction_type in ('ChargeBack')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBack') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor
)CB

on sale.division_id = cb.division_id
and sale.division_site_id = cb.division_site_id
and sale.merchant_descriptor = cb.merchant_descriptor

)Prev_month

on Current_month.division_id = Prev_month.division_id
and Current_month.division_site_id = Prev_month.division_site_id
and Current_month.merchant_descriptor = Prev_month.merchant_descriptor

)BD

left join

(
select (case when sale.division_id is null then cb.division_id else sale.division_id end)division_id
,(case when sale.division_site_id is null then cb.division_site_id else sale.division_site_id end)division_site_id
,(case when sale.merchant_descriptor is null then cb.merchant_descriptor else sale.merchant_descriptor end)merchant_descriptor
,settle_units
,settle_usd
,CB_units
,CB_usd

from
(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)settle_units
,sum(usd_payment_amount)settle_usd

from rcn_payment_transaction rpt

where creation_date between '5/1/2019' and '6/1/2019'
and transaction_type in ('Settle')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('Settle') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor

)Sale

full join

(
select division_id
,division_site_id
,merchant_descriptor
,count(cpg_transaction_id)cb_units
,sum(usd_payment_amount)cb_usd

from rcn_payment_transaction rpt

where creation_date between '5/1/2019' and '6/1/2019'
and transaction_type in ('ChargeBack')
and status in ('Completed')
and payment_method_id in ('Visa','MasterCard')
and cpg_transaction_id = (select min(cpg_transaction_id) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBack') and status in ('Completed'))
and division_id in ('element5','swreg','esellerate','regnow')

group by division_id
,division_site_id
,merchant_descriptor
)CB

on sale.division_id = cb.division_id
and sale.division_site_id = cb.division_site_id
and sale.merchant_descriptor = cb.merchant_descriptor

)Prev_prev

on Prev_prev.division_id = BD.division_id
and Prev_prev.division_site_id = BD.division_site_id
and Prev_prev.merchant_descriptor = BD.merchant_descriptor

)

order by current_settle_units desc
