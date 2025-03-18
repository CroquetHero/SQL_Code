select payment_processor_name
      ,payment_method_id
      ,response_code
      ,transaction_type
      ,(case
      when response_code in ('30','4859','59','8030','Item not received','4554','Merchandise','4855','55','RG','Non-receipt','516') then 'Services Not Provided or Merchandise Not Received'
      when response_code in ('41','4841','8041','AP','4544','CR') then 'Cancelled Recurring Transaction'
      when response_code in ('53','4853','4856','56','RM','Not as described','4553') then 'Not as Described or Defective Merchandise'
      when response_code in ('57','4804','4','4840','40','4512') then 'Fraudulent Multiple Transactions'
      when response_code = '62' then 'Counterfeit Transaction'
      when response_code = '70' then 'Account Number on Exception File'
      when response_code in ('71','DA','AT') then 'Declined Authorization'
      when response_code in ('72','8072','4808','8','NA','4521','9053') then 'No Authorization Obtained'
      when response_code in ('73','4835','35','EX') then 'Expired Card'
      when response_code in ('74','4842','42','LP','4536') then 'Late Presentment'
      when response_code in ('75','4863','63','AA','8075') then 'Cardholder Does Not Recognize the Transaction'
      when response_code in ('76','4846','46') then 'Incorrect Transaction Code'
      when response_code in ('77','9052') then 'Non Matching Acct Number'
      when response_code = '78' then 'Service Code Violation, Did not Obtain Authorization (International Only)'
      when response_code in ('79','4801','1','4516') then 'Requested Transaction Information Not Received'
      when response_code in ('80','4831','31','AW','4507') then 'Incorrect Transaction Amount or Acct Number'
      when response_code in ('81','UA11','UA12','UA18','UA21','UA22','UA23','UA28') then 'Fraudulent Transaction - Card Present'
      when response_code in ('82','4834','34','DP','8082','512','Duplicate payment') then 'Duplicate Processing'
      when response_code in ('83','4837','37','45','UA01','UA02','UA03','UA31','UA32','UA38','8083','Unauthorized','Unauthorized payment','4540','4847','47','546') then 'Fraudulent Transaction - Card Not Present'
      when response_code in ('85','4860','60','RN2','4513','8085') then 'Credit Not Processed'
      when response_code in ('4802','4803','2','3','IC','4517','UANR','UANR - Fraud') then 'Documentation Received Invalid/Incomplete'
      when response_code in ('4850','50','CD') then 'Credit Posted as a Purchase'
      when response_code in ('NC','Other','?','Inquiry','Inquiry by PayPal','Special','4854','54') then 'Other Reason Codes'
      when response_code in ('4812','12','IN','9051') then 'Account Number Not on File'
      when response_code in ('4807','7') then 'Warning Bulletin Filed'
      when response_code in ('IS','NR') then 'Documentation in response to Retrieval Request Missing Valid/Legible Signature'
      when response_code in ('86','8086','4515') then 'Paid by Other Means'
      when response_code in ('UA99','TF','4849','49') then 'Non-Compliance with Operating Regulations '
      when response_code = '4763' then 'Full recourse'
      when response_code = '9050' then 'Insufficient Funds'
      when response_code = '9054' then 'Recall on Direct Debit'
      when response_code = '9055' then 'Objection by Debtor'
      when response_code = '4857' then 'Card Activated Telephone Transaction'
      when response_code = '4862' then 'Counterfeit Transaction Magnetic Stripe POS Fraud'
      when response_code = '4870' then 'Chip Liability Shift'
      when response_code = '4871' then 'Chip and PIN Liability Shift'
      when response_code = '4905' then 'Invalid Acquirer Reference Data on Second Presentment'
      when response_code = '91' then 'Dummy Code'
      when response_code in ('n/a','98','unknown','4902','08','02','03') then 'Error'
      when response_code = 'Fraud' then 'AmEx - Fraud'
      when response_code = 'Non-Fraud' then 'AmEx - Non-Fraud'
      else 'None of the Above' end)Chargeback_Def
      ,count(cpg_transaction_id)units
      ,sum(usd)usd
      
      from
(
select (case
      when payment_processor_name in ('netgiro-amex', 'netgiro-bms', 'netgiro-bnp','netgiro-seb') and transaction_type = 'ChargeBackRevrs' then 
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
) as response_code
      ,payment_processor_name
      ,payment_method_id
      ,(case when transaction_type = 'ChargeBackRevrs' then 'Reversal'
             when  settlement_date > (select min(settlement_date) from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rpt.payment_amount between .9*payment_amount and 1.1*payment_amount) then '2nd ChargeBack'
             else '1st ChargeBack' end)transaction_type 
      ,cpg_transaction_id
      ,decode(rpt.transaction_currency, 'USD', payment_amount, (rpt.payment_amount/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where rpt.settlement_date = der.effective_date and  rpt.TRANSACTION_CURRENCY = der.to_currency_code and rownum < 2))) as usd
      
      from rcn_payment_transaction rpt
      
      where settlement_Date between '01-jan-13' and sysdate
      and transaction_type in ('ChargeBackRevrs','ChargeBack')
      and status = 'Completed'
      and response_code <> 'n/a'
      
      
      )
      
      group by response_code
      ,(case
      when response_code in ('30','4859','59','8030','Item not received','4554','Merchandise','4855','55','RG','Non-receipt','516') then 'Services Not Provided or Merchandise Not Received'
      when response_code in ('41','4841','8041','AP','4544','CR') then 'Cancelled Recurring Transaction'
      when response_code in ('53','4853','4856','56','RM','Not as described','4553') then 'Not as Described or Defective Merchandise'
      when response_code in ('57','4804','4','4840','40','4512') then 'Fraudulent Multiple Transactions'
      when response_code = '62' then 'Counterfeit Transaction'
      when response_code = '70' then 'Account Number on Exception File'
      when response_code in ('71','DA','AT') then 'Declined Authorization'
      when response_code in ('72','8072','4808','8','NA','4521','9053') then 'No Authorization Obtained'
      when response_code in ('73','4835','35','EX') then 'Expired Card'
      when response_code in ('74','4842','42','LP','4536') then 'Late Presentment'
      when response_code in ('75','4863','63','AA','8075') then 'Cardholder Does Not Recognize the Transaction'
      when response_code in ('76','4846','46') then 'Incorrect Transaction Code'
      when response_code in ('77','9052') then 'Non Matching Acct Number'
      when response_code = '78' then 'Service Code Violation, Did not Obtain Authorization (International Only)'
      when response_code in ('79','4801','1','4516') then 'Requested Transaction Information Not Received'
      when response_code in ('80','4831','31','AW','4507') then 'Incorrect Transaction Amount or Acct Number'
      when response_code in ('81','UA11','UA12','UA18','UA21','UA22','UA23','UA28') then 'Fraudulent Transaction - Card Present'
      when response_code in ('82','4834','34','DP','8082','512','Duplicate payment') then 'Duplicate Processing'
      when response_code in ('83','4837','37','45','UA01','UA02','UA03','UA31','UA32','UA38','8083','Unauthorized','Unauthorized payment','4540','4847','47','546') then 'Fraudulent Transaction - Card Not Present'
      when response_code in ('85','4860','60','RN2','4513','8085') then 'Credit Not Processed'
      when response_code in ('4802','4803','2','3','IC','4517','UANR','UANR - Fraud') then 'Documentation Received Invalid/Incomplete'
      when response_code in ('4850','50','CD') then 'Credit Posted as a Purchase'
      when response_code in ('NC','Other','?','Inquiry','Inquiry by PayPal','Special','4854','54') then 'Other Reason Codes'
      when response_code in ('4812','12','IN','9051') then 'Account Number Not on File'
      when response_code in ('4807','7') then 'Warning Bulletin Filed'
      when response_code in ('IS','NR') then 'Documentation in response to Retrieval Request Missing Valid/Legible Signature'
      when response_code in ('86','8086','4515') then 'Paid by Other Means'
      when response_code in ('UA99','TF','4849','49') then 'Non-Compliance with Operating Regulations '
      when response_code = '4763' then 'Full recourse'
      when response_code = '9050' then 'Insufficient Funds'
      when response_code = '9054' then 'Recall on Direct Debit'
      when response_code = '9055' then 'Objection by Debtor'
      when response_code = '4857' then 'Card Activated Telephone Transaction'
      when response_code = '4862' then 'Counterfeit Transaction Magnetic Stripe POS Fraud'
      when response_code = '4870' then 'Chip Liability Shift'
      when response_code = '4871' then 'Chip and PIN Liability Shift'
      when response_code = '4905' then 'Invalid Acquirer Reference Data on Second Presentment'
      when response_code = '91' then 'Dummy Code'
      when response_code in ('n/a','98','unknown','4902','08','02','03') then 'Error'
      when response_code = 'Fraud' then 'AmEx - Fraud'
      when response_code = 'Non-Fraud' then 'AmEx - Non-Fraud'
      else 'None of the Above' end)
      ,payment_processor_name
      ,payment_method_id
      ,transaction_type
      
      order by chargeback_def, response_code
      