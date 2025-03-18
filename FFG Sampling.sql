select division_order_id
        ,division_site_id
        ,settle_date
        ,payment_service_id
        ,payment_method_id
        ,rec_flag

from
(
select division_order_id
        ,division_site_id
        ,trunc(creatioN_date)settle_date
        ,payment_service_id
        ,payment_method_id
        ,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
        ,dbms_random.value(0,1)ran

from cpg_payment_transaction

where creation_date between sysdate - 20 and sysdate - 10
and transaction_type = 'Settle'
and status = 'Completed'
and division_id = 'fatfoogoo'

order by ran

)

where rownum < 1001