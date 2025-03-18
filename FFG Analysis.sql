select day
      ,count(division_order_id)units
      
      from
(
select (case --when payment_service_id in ('netgiro-eft','netgiro-seb', 'drwp-eft','netgiro-br', 'netgiro-bms') and transaction_type = 'ChargeBack' then 'Ignore'
             --when payment_service_id in ('firstdata', 'mes') and payment_method_id in ('AmericanExpress','Discover') then 'Ignore'
             when payment_service_id in ('netgiro-bms','netgiro-bnp','netgiro-eft','netgiro-seb') then bank_code
             --when payment_service_id = 'firstdata' and response_code_1 in ('41') then 'Ignore'
             --when payment_service_id in ('paypalExpress','paypalAdaptive') then 'Ignore'
             --when payment_service_id = 'nab' and response_code_1 in ('83', '41', '4841') then 'Ignore'
             when payment_service_id = 'netgiro-amex' then bank_code
             when transaction_type = 'ChargeBack' and creation_date > (select min(creation_date) from cpg_payment_transaction where rpt.division_order_id = division_order_id and transaction_type = 'ChargeBack' and status = 'Completed') then 'Ignore'
             else reference_number end)case_number
       ,division_order_id
       ,trunc(creation_date + 1)day
       
       from cpg_payment_transaction rpt
       
where creation_date > sysdate - 20
and transaction_type in ('ChargeBack', 'ChargeBackNotice', 'RFI')
and status in ('Completed', 'New', 'Requested','Pending')
and division_id = 'fatfoogoo'

)

where case_number <> 'Ignore'

group by day

order by day