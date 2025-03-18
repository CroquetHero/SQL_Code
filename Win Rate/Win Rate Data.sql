select payment_processor_name
      ,settlement_date
      ,payment_method_id
      ,ChargeBack_code
      ,transaction_type
  --    ,division_id
      ,count(cpg_transaction_id) as Units
      ,sum(USD) as USD

from

(

select payment_processor_name
      ,payment_method_id
      ,cpg_transaction_id
      ,division_id
      ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
      ,transaction_currency
      ,(case
      when payment_processor_name = 'netgiro-seb' and transaction_type = 'ChargeBackRevrs' then 
      (select (case
when response_code = '4801' then '1'
when response_code = '4802' then '2'
when response_code = '4807' then '7'
when response_code = '4808' then '8'
when response_code = '4812' then '12'
when response_code = '4831' then '31'
when response_code = '4834' then '34'
when response_code = '4835' then '35'
when response_code = '4837' then '37'
when response_code = '4840' then '40'
when response_code = '4841' then '41'
when response_code = '4842' then '42'
when response_code = '4846' then '46'
when response_code = '4847' then '47'
when response_code = '4850' then '50'
when response_code = '4853' then '53'
when response_code = '4854' then '54'
when response_code = '4855' then '55'
when response_code = '4859' then '59'
when response_code = '4860' then '60'
when response_code = '4863' then '63'
when response_code = '4870' then '70'
else response_code end
      ) from rcn_payment_transaction where transaction_type in ('ChargeBack') and status = 'Completed' and auth_transaction_id = rpt.auth_transaction_id and rownum < 2)
when response_code = '4801' then '1'
when response_code = '4802' then '2'
when response_code = '4807' then '7'
when response_code = '4808' then '8'
when response_code = '4812' then '12'
when response_code = '4831' then '31'
when response_code = '4834' then '34'
when response_code = '4835' then '35'
when response_code = '4837' then '37'
when response_code = '4840' then '40'
when response_code = '4841' then '41'
when response_code = '4842' then '42'
when response_code = '4846' then '46'
when response_code = '4847' then '47'
when response_code = '4850' then '50'
when response_code = '4853' then '53'
when response_code = '4854' then '54'
when response_code = '4855' then '55'
when response_code = '4859' then '59'
when response_code = '4860' then '60'
when response_code = '4863' then '63'
when response_code = '4870' then '70'


else response_code
end
) as ChargeBack_code
      ,transaction_type
      ,to_char(settlement_date, 'MM-YYYY') as settlement_date

from rcn_payment_transaction rpt

where settlement_date between '01-jan-14' and '31-jan-14'
and creation_date > sysdate - 45
and payment_processor_name in ('mes','firstdata', 'paymentech', 'netgiro-seb', 'netgiro-bms', 'nab')
and transaction_type in ('Settle', 'ChargeBack', 'ChargeBackRevrs')
and payment_method_id in ('Visa','MasterCard','AmericanExpress','Discover')
and status = 'Completed'
and division_site_id is not null

) WRT


group by payment_processor_name
        ,payment_method_id
     --   ,transaction_currency
        ,ChargeBack_code
        ,transaction_type
        ,settlement_date
     --   ,division_id