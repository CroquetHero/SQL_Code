select month
        ,division_site_id
        ,bank_name
        ,account_bin
        ,transaction_type
        ,count(transaction_id)units
        
        from
(
select division_site_id
        ,to_char(creation_date, 'MM/YYYY')month
        ,(case when bank_name = 'corporate' then 'corporate'
        when bank_name = 'len=16' then 'Blank'
        else substr(bank_name, instr(bank_name, 'bankName=', 1) + 9, instr(bank_name, 'len=',1)- (instr(bank_name, 'bankName=', 1,1) + 9)) end)bank_name
        ,(select distinct account_bin from cpg_customer_account where cpt.account_token = account_token and account_bin is not null)account_bin
        ,transaction_type
        ,transaction_id

from cpg_payment_transaction cpt

where creation_date between '1/1/2016' and '2/1/2016'
and transaction_type in ('ChargeBack','Settle')
and status = 'Completed'
and payment_method_id = 'MasterCard'
and payment_service_id in ('firstdata','mes')
and division_site_id in ('tmamer', 'avast', 'kasperus')
and custom_data like '%recurring%'

)

group by division_site_id
        ,bank_name
        ,account_bin
        ,transaction_type
        ,month