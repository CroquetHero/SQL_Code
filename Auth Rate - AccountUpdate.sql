select auth_date
,division_site_id
,account_update_date
,account_update_message
,status
,count(division_order_id)units

from
(
select trunc(creation_date)auth_date
,division_order_id
,division_site_id
,(select distinct first_value(creation_date) over (order by creation_date desc)AccountUpdate_Date from cpg_payment_transaction where account_token = rpt.account_token and creation_date < rpt.creation_date and transaction_type = 'AccountUpdate' and status = 'Completed')Account_Update_Date
,(select distinct first_value(response_message) over (order by creation_date desc)AccountUpdate_Date from cpg_payment_transaction where account_token = rpt.account_token and creation_date < rpt.creation_date and transaction_type = 'AccountUpdate' and status = 'Completed')Account_Update_message
,status
--,custom_data

from cpg_payment_transaction rpt

where creation_date between '12/7/2017' and '12/8/2017'
and transaction_type = 'Authorize'
and division_id <> 'netgiro'
and (select status from cpg_payment_transaction where account_token = rpt.account_token and transaction_type = 'AccountUpdate' and status = 'Completed' and rownum < 2) is not null
and transaction_id = (select distinct first_value(transaction_id) over (order by transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize')
and division_order_id not like '%OrderID%'
and custom_data like '%recurring%'
--and account_token = '16322920070000000000005390695904'
and custom_data like '%renewAttNum=1%'

)

where (auth_date - account_update_date) < 720

group by auth_date
,division_site_id
,account_update_date
,account_update_message
,status