select cb_date
      ,payment_service_id
      ,payment_method_id
      ,response_code_1
      ,rev_status
      ,PreArb_status
      ,count(transaction_id)units
      ,sum(usd)usd
      
      from
(
select trunc(creation_date)cb_date
      ,payment_service_id
      ,payment_method_id
      ,response_code_1
      ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and rpt.request_money_amount between .95*request_money_amount and 1.05*request_money_amount and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null then 'Reversal' else 'No Reversal' end)rev_status
      ,(case when creation_date < (select max(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and rpt.request_money_amount between .95*request_money_amount and 1.05*request_money_amount and transaction_type = 'ChargeBack' and status = 'Completed') then '2nd CB' else 'No 2nd CB' end)PreArb_status
      ,transaction_id
      ,division_order_id
      ,request_money_amount usd

from cpg_payment_transaction rpt

where creation_date > sysdate - 60
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id in ('mes', 'firstdata')
and payment_method_id in ('MasterCard', 'Visa')
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')

)

group by cb_date
      ,payment_service_id
      ,payment_method_id
      ,response_code_1
      ,rev_status
      ,PreArb_status