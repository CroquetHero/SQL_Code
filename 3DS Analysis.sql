select month
        ,division_site_id
        ,Payment_method_id
        ,verify_eci
        ,bank_name
        ,rev_status
        ,PreArb_status
        ,count(transaction_id)units
        
        from
(
select division_site_id
        ,Payment_method_id
        ,verify_eci
        ,to_char(creation_date,'MM/YYYY')month
        ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is not null then 'Reversal' else 'No Reversal' end)rev_status
        ,(case when creation_date < (select max(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'PreArb' else 'No PreArb' end)PreArb_status
        ,transaction_id
        ,substr(bank_name, instr(bank_name, 'bankName=')+9, length(bank_name) - instr(bank_name, 'bankName=') - 14 )bank_name
        
from cpg_payment_transaction rpt

where creation_date between '1/1/2016' and sysdate
and transaction_type = 'Settle'
and status = 'Completed'
and payment_service_id in ('mes', 'firstdata')
and payment_method_id in ('MasterCard', 'Visa')
--and response_code_1 in ('83','37', '4837')
--and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and verify_eci is not null
and division_id = 'pacific'

)

group by division_site_id
        ,Payment_method_id
        ,verify_eci
        ,rev_status
        ,PreArb_status
        ,month
        ,bank_name