select day
        ,count(division_order_id)units
   select *     
        from
(
select division_order_id
     --   ,response_message
       --,custom_data
       ,trunc(creation_date)day
       ,substr(custom_data, instr(custom_data,'payerStatus=',1)+12,instr(custom_data,'requireConfirmedAddress=',1) - instr(custom_data,'payerStatus=',1)  -12)verify_status
       ,substr(custom_data, instr(custom_data,'requireConfirmedAddress=',1)+24,4)Ship_Confirm
       ,merchant_number
       ,dbms_random.value(0,1)ran


from cpg_payment_transaction

where creation_date > trunc(sysdate) - 600
and transaction_type = 'RFI'
and status in ('New', 'Pending','Completed')
and payment_service_id = 'paypalExpress'
--and division_site_id = 'samsung'
and custom_data like '%requireConfirmedAddress%'
and custom_data like '%payerStatus%'

order by ran

)

group by day

order by day