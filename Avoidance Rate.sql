select month
      ,response_code_2
      ,CB_Status
      ,merchant_number
      ,count(transaction_id)units
      
      from
(
select to_char(creation_date, 'MM/YYYY')month
      ,response_code_2
      ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)CB_Status
      ,transaction_id
      ,merchant_number

from cpg_payment_transaction rpt

where creation_date > '1/1/2015'
and transaction_type = 'RFI'
and status = 'Completed'
and payment_service_id in ('paypalExpress', 'paypalAdaptive')

)

group by month
      ,response_code_2
      ,CB_Status
      ,merchant_number
      
   