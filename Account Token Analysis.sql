select division_order_id order_id
      ,division_site_id site_id
      ,trunc(creation_date)settle_date,billing_address_email_address
      ,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
      ,(select trunc(max(creation_date)) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Completed')Refund_date
      ,(select trunc(min(creation_date)) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')min_cb_date
      ,(select trunc(max(creation_date)) from cpg_Payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')max_cb_date
      ,request_money_amount amount
      ,request_money_currency currency

from cpg_Payment_transaction rpt

where account_token = '71489596770000000000008085449203'
and transaction_type = 'Settle'

order by settle_date