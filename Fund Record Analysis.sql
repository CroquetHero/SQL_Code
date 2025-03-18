select *

from
(
select division_order_id
        ,trunc(creation_date)cb_date
        ,division_site_id
        ,response_code_1
        ,substr(bank_name,instr(bank_name, 'countryID=', 1) + 10 , 2)bank_country
        ,(select count(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed')fund_count
        ,(select sum(request_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Fund' and status = 'Completed')fund_total

from cpg_payment_transaction rpt

where creation_date > '7/1/2017'
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_service_id = 'litle'
and payment_method_id in ('Visa','MasterCard')
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')
and (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed' and rownum < 2) is null

)

where fund_total <> 0