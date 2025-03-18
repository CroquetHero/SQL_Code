select distinct oid, payment_service_id, payment_method_id,site_id,ref_num,response_code_1, Settle_amount, nvl(cb_amount,0)cb, nvl(Refund_amount,0)refund, nvl(reversal_amount,0)reversal, (Settle_amount - nvl(cb_amount,0) -  nvl(Refund_amount,0) + nvl(reversal_amount,0)) net,request_money_currency
from
(
select division_order_id oid,division_site_id as site_id, payment_service_id, payment_method_id,
(
case when payment_service_id in  ('mes','firstdata','litle','netgiro-br') and payment_method_id in ('Visa','MasterCard','AmericanExpress') then reference_number
when payment_method_id = 'Discover' then authorization_code
when payment_service_id in  ('netgiro-seb','netgiro-bms','netgiro-seb') then bank_code
end
) ref_num

, (select sum(nvl(response_money_amount,request_money_amount)) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Settle' and status = 'Completed') Settle_amount
, (select sum(nvl(response_money_amount,request_money_amount)) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and response_code_1 <> '80') cb_amount
, (select sum(nvl(response_money_amount,request_money_amount)) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'Refund' and status = 'Completed') Refund_amount
, (select sum(nvl(response_money_amount,request_money_amount)) from cpg_payment_transaction where division_order_id = cpt.division_order_id and transaction_type = 'ChargeBackRevrs' and status = 'Completed') Reversal_amount
,request_money_currency
,response_code_1

from cpg_payment_transaction cpt 

where transaction_type = 'ChargeBack' 
and status = 'Completed' 
and creation_date between trunc(sysdate) - 1 and trunc(sysdate)  
and payment_method_id <> 'MicrosoftPayment' 
--and response_code_1 not in ('80')
)
where (Settle_amount - nvl(cb_amount,0) -  nvl(Refund_amount,0) + nvl(reversal_amount,0)) < -5
--and refund_amount <> 0

order by net