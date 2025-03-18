select  bin
,lag
,New_Month
,New_Year
,old_Month
,old_year
,Update_date
,count(division_order_id)units

from
(

select verify_trans_id bin
,division_order_id
,transaction_id
,trunc(creation_date)Update_date
,expiration_date
,secondary_date
,'20' || substr(expiration_date,3,2)New_Year
,substr(expiration_date,0,2)New_Month
,'20' || substr(secondary_date,3,2)Old_Year
,substr(secondary_date,0,2)Old_Month
,substr(expiration_date,0,2) || '/01/20' || substr(expiration_date,3,2)exp_date
,substr(secondary_date,0,2) || '/01/20' || substr(secondary_date,3,2)old_exp_date
--,custom_data
,payment_method_id
,payment_service_id
,(substr(expiration_date,0,2)) + (substr(expiration_date,3,2)*12) - (substr(secondary_date,0,2) + (substr(secondary_date,3,2)*12))lag

--select *
from cpg_payment_transaction rpt

where creation_date between '7/1/2017' and '7/1/2018'
and transaction_type = 'AccountUpdate'
and status = 'Completed'
and response_message = 'New expiration date'
and verify_trans_id in ('517805','414709','480213','529149','546630','486236','430572','552851','412174','529107','544045','545800','520101','540791','548897','512025','515241','528942','515676')
--and (select count(transaction_id) from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'AccountUpdate' and status = 'Completed') > 1

)

where old_exp_date < Update_date

group by bin
,lag
,New_Year
,old_year
,New_Month
,old_Month
,Update_date
