select cb_date
      ,payment_processor_name
      ,payment_method_id
      ,PreArb_status
      ,rev_status
      ,division_site_id
     -- ,division_order_id
      ,count(cpg_transaction_id)units
      
      from
(
select settlement_date cb_date
      ,payment_processor_name
      ,payment_method_id
      ,division_order_id
      ,division_site_id
      ,(case when creation_date < (select max(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'PreArb' else 'No PreArb' end)PreArb_status
      ,(case when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null then 'Reversal' else 'No Reversal' end)rev_status
      ,cpg_transaction_id

from rcn_payment_transaction rpt

where creation_date between '01-jan-13' and sysdate
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_processor_name in ('mes', 'firstdata')
and payment_method_id in ('MasterCard', 'Visa')
and response_code in ('4863', '63', '75')
and creation_date = (select min(creation_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and division_site_id <> 'msstore'
)

--where rev_status = 'No Reversal'

group by cb_date
      ,payment_processor_name
      ,payment_method_id
      ,PreArb_status
      ,rev_status
      ,division_site_id 
      
      
      order by units desc