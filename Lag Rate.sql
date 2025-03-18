select (cb_date - settle_date)lag
,count(division_order_id)units

from
(
select division_order_id
,(select trunc(min(creation_date)) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Settle' and status = 'Completed')Settle_Date
,trunc(creation_date)CB_Date


from cpg_payment_transaction rpt

where creation_date > '5/1/2019'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id in ('ncldirect')--,'litle','mes')
--and payment_method_id in ('Visa')--,'MasterCard')
and division_site_id in ('samsung2','samsung')
--and response_code_1 = '4831'
and transaction_id = (select min(transaction_id) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
--and division_site_id in ('avast', 'kasperus', 'tmamer')

)

group by (cb_date - settle_date)

order by lag
