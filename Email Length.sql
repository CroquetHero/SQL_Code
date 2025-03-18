select site
        ,payment_method_id
        ,payment_service_id
        ,email_end
        ,cb_status
        ,count(division_order_id)units
        
        from
(
select /*length(substr(billing_address_email_address,0,instr(billing_address_email_address,'@') - 1))email_length
        ,billing_address_email_address
        ,*/substr(billing_address_email_address,instr(billing_address_email_address,'@') + 1,length(billing_address_email_address) - instr(billing_address_email_address,'@'))email_end
        ,division_order_id
        ,division_site_id
        ,(case when division_id in ('swreg', 'esellerate', 'regnow', 'element5') then 'MyCommerce5'
                 when division_id in ('commerce5','fatfoogoo') then division_id
                  else division_site_id end)site
        ,payment_method_id
        ,payment_service_id
        ,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status

from cpg_payment_transaction rpt

where creation_date between trunc(sysdate) - 150 and trunc(sysdate) - 130
and transaction_type = 'Settle'
and status = 'Completed'
and payment_method_id in ('MasterCard', 'Visa', 'Discover', 'AmericanExpress')
and payment_service_id in ('mes', 'litle', 'firstdata')
and division_site_id is not null
--and division_id = 'fatfoogoo'


)

group by site
        ,payment_method_id
        ,payment_service_id
        ,email_end
        ,cb_status