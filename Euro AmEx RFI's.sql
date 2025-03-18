select division_order_id
      ,reference_number
      ,substr(bank_code,3,length(bank_code) - 2)bank_code
      ,authorization_code
      ,(select creation_date from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('RFI') and status = 'New' and rownum < 2)RFI_status
      ,(select reference_number from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type in ('ChargeBackNotice') and rownum < 2)case_control

from cpg_payment_transaction rpt

where creation_date > sysdate - 200
and transaction_type in ('Settle')
and status = 'Completed'
and payment_service_id = 'netgiro-amex'
and authorization_code = '2492783712'