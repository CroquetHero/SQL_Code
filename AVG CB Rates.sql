select division_order_id
,payment_method_id
,Settle_date
,payment_service_id
,decode(card_source,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(card_class,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
,(select distinct imported from EREPORT.SUB_auth_ADDITIONAL_INFO where sub_ID = subscription_id)import_flag
,cb_status
,rec_flag

from
(
select division_order_id
,payment_method_id
,trunc(cpg_creation_date)Settle_date
,payment_service_id
,substr(notes,instr(notes,'class=',1,1) + length('class='),(instr(notes,',',instr(notes,'class=',1,1),1)) - (instr(notes,'class=',1,1) + length('class=')))card_class
,substr(notes,instr(notes,'source=',1,1) + length('source='),(instr(notes,',',instr(notes,'source=',1,1),1)) - (instr(notes,'source=',1,1) + length('source=')))card_source
,substr(ref_field_1,0,11)sub_ID
,(case when (select status from rcn_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed' and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status
,(case when ref_field_1 is null then 'Non-Recurring' else 'Recurring' end)rec_flag
from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type = 'Settle'
and status = 'Completed'
and division_site_id in ('avast','avgstore')

)


