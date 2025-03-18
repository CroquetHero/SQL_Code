select distinct division_order_id
,reference_number
,bank_code
,merchant_number
--,response_code_2
,trunc(creation_date)rfi_date
,(select distinct first_value(status) over (order by creation_date desc)dup_order from cpg_payment_transaction where division_order_id = rpt.division_order_id and division_site_id = rpt.division_site_id and transaction_type = 'RFI')Current_Status
,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')cb_date
,request_money_amount amount
,request_money_currency currency

from cpg_payment_transaction rpt

where transaction_type = 'RFI'
and division_order_id in ('14262925571','14318089971','14329930171','14302761371','14261271571','14364094071','14233800371','12180257838','14299035671','14270735871','13478953971','14285302171','14336532971','14292719271','14317822171','14309621771','14334756771','14316345371','12148958738','14285169071','14290491371','14334756771','10917729305','10826215205','14301777671','14220969071','14313990371','14252159271','10833574805','14285644771','14282052271','14285302171','13326966459','13327103259','13326947259','13326935959','14290491371','24099866162','13553548329','24081673862','10834583405','10834020505','14200754671','9870088472','10837294005','13320364459','10022963204','16002971362','12313614071','11066885806','8843735556','20859520062','9855514172','24332405162','14354356371','10017155904','11030704771')

order by current_status
,division_order_id