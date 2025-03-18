select *

from
(

select prod_dur
,renewal_time
,renewal_rule_id
,site_ID
,upper(Country) Bill_Country
,CountryID Issue_Country
,decode(source1,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(class1,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
,decode(usage1,'C',' Credit Hybrid (meaning it has pin capability also).','X',' True credit (No PIN/Signature capability).','R',' Private Label (MasterCard)','P',' Debit - PIN Only without EBT.','E',' Debit – Pin Only with EBT.','H',' Debit Hybrid (PIN and Signature).','S',' Signature only (not PIN capable).','J',' USA Commercial Debit – Signature Only - No PIN Access.','K',' USA Commercial Debit - Pin Capable.','L',' NON USA Consumer Debit - No Pin Access','M',' NON USA Commercial Debit - No Pin Access.','N',' NON USA Consumer Debit - Pin Capable','O',' NON USA Commercial Debit - Pin Capable','U',' Reloadable Prepaid - Amex only','V',' Stored Value Prepaid – Amex only')card_usage_type
,decode(category1,'L','Visa Electron','J3','Visa Healthcare','K1','GSA Corporate T and E','G3','Visa Business Enhanced (US Only)','I','Visa Infinite','G1','Visa Signature Business','K','Corporate T and E','C','Visa Signature','B','Visa Traditional Rewards','G','Visa Business','F','Visa Classic','A','Visa Traditional','L','Visa Electron','N','Visa Platinum','N1','Visa Rewards','P','Visa Gold','Q','Private Label','R','Proprietary','S','Visa Purchasing','S1','Visa Purchasing with Fleet','S2','Visa GSA Purchasing','S3','Visa GSA Purchasing with Fleet','S4','Government Services Loan','S5','Visa Commercial Transport (EBT)','S6','Business Loan','S7','Visa Distribution','U','Visa Travel Money','V','V Pay','CIR','Cirrus','DAG','Global Debit MasterCard Salary','DAP','Platinum Debit MasterCard Salary','DAS','Standard Debit MasterCard Salary','DLG','Debit MasterCard Gold Delayed Debit','DLH','Debit MasterCard World Embossed Delayed Debit','DLP','Debit MasterCard Platinum Delayed Debit','DLS','Debit MasterCard Card Delayed Debit','DOS','Standard Debit MasterCard Social','MAB','World Elite MasterCard for Business Card','MAC','MasterCard World Elite Corporate Card','MAP','MasterCard Commercial Payments Account','MBB','MasterCard Prepaid Consumer','MBC','MasterCard Prepaid Voucher','MBD','MasterCard Professional Debit BusinessCard Card','MBE','MasterCard Electronic Business Card','MBF','Prepaid MC Food','MBK','MasterCard Black Card','MBM','Prepaid MC Meal','MBP','MasterCard Corporate Prepaid','MBT','MasterCard Corporate Prepaid Travel','MCB','MasterCard BusinessCard Card','MCC','MasterCard Credit Card (mixed BIN)','MCD','Debit MasterCard Card','MCE','MasterCard Electronic Card','MCF','MasterCard Fleet Card','MCG','Gold MasterCard Card','MCH','MasterCard Premium Charge','MCO','MasterCard Corporate (Meeting) Card','MCP','MasterCard Purchasing Card','MCS','(Unembossed) Standard MasterCard Card','MCT','Titanium MasterCard Card','MCV','Merchant-Branded Program','MCW','World MasterCard Card','MDB','Debit MasterCard BusinessCard Card','MDG','Gold Debit MasterCard Card','MDH','World Debit Embossed MasterCard Card','MDJ','Debit MasterCard (Enhanced)','MDL','Business Debit Other Embossed','MDO','Debit Other','MDP','Premium Debit MasterCard Card','MDR','Debit Brokerage','MDS','Standard Debit MasterCard','MDT','Commercial Debit MasterCard Card','MDW','World Elite Debit MasterCard','MEB','MasterCard Executive BusinessCard Card','MEC','MasterCard Electronic Commercial','MEF','MasterCard Electronic Payment Account','MEO','MasterCard Corporate Executive Card','MFB','Flex World Elite','MFD','Flex Platinum','MFE','Flex Charge World Elite','MFH','Flex World','MFL','Flex Charge Platinum','MFW','Flex World Charge','MGF','MasterCard Government Commercial Card','MHA','MasterCard Healthcare Prepaid Non-Tax','MHB','MasterCard HSA Substantiated (Debit MasterCard)','MHH','MasterCard HSA Non-Substantiated (Debit MasterCard)','MIA','Prepaid MasterCard Unembossed Student Card','MIK','Prepaid MasterCard Electronic Student (Non-US) Card','MIL','Unembossed MasterCard Student Card (Non-US)','MIP','Prepaid Debit MasterCard Student Card','MIU','Debit MasterCard Unembossed (Non-US)','MLF','MasterCard Agro Card','MNW','MasterCard World Card','MOC','Standard Maestro Social','MOG','Maestro Gold Card','MOP','Maestro Platinum','MOW','World Maestro','MPA','Prepaid Debit Standard Payroll','MPF','MasterCard Prepaid Debit Standard Gift','MPG','Debit MasterCard Standard Prepaid General Spend','MPJ','Prepaid Debit MasterCard Card Gold','MPK','MasterCard Prepaid Government Commercial Card','MPL','Platinum MasterCard Card','MPM','MasterCard Prepaid Debit Standard Consumer Incentive','MPN','MasterCard Prepaid Debit Standard Insurance','MPO','MasterCard Prepaid Debit Standard Offer','MPP','MasterCard Prepaid Card – Commercial Reward Funding','MPQ','MasterCard Prepaid Debit Standard Government Disaster','MPR','MasterCard Prepaid Debit Standard Travel','MPT','MasterCard Prepaid Debit Standard Teen','MPV','MasterCard Prepaid Debit Standard Government','MPW','Debit MasterCard Business Card Prepaid Workplace Business','MPX','MasterCard Prepaid Debit Standard Flex Benefit','MPY','MasterCard Prepaid Debit Standard Employee Incentive','MPZ','MasterCard Prepaid Debit Standard Government Consumer','MRB','MasterCard Prepaid Electronic Business Card (Non-US)','MRC','Prepaid MasterCard Electronic Card (Non-US)','MRG','MasterCard Prepaid Card (Non-US)','MRH','MasterCard Platinum Prepaid Travel (US)','MRJ','Prepaid MasterCard Gold Card','MRK','Prepaid MasterCard Public Sector Commercial Card','MRL','Prepaid MasterCard Electronic Commercial Card (Non-US)','MRO','MasterCard Rewards Only','MRP','Standard Retailer Centric Payments','MRS','Prepaid MasterCard ISIC Student Card','MRW','Prepaid MasterCard Business Card (Non-US)','MSA','Prepaid Maestro Payroll Card','MSB','Maestro Small Business Card','MSF','Prepaid Maestro Gift Card','MSG','Prepaid Maestro Consumer Reloadable Card','MSI','Maestro Student Card','MSJ','Prepaid Maestro Gold','MSM','Prepaid Maestro Consumer Promotion Card','MSN','Prepaid Maestro Insurance Card','MSO','Prepaid Maestro Other Card','MSQ','Unknown','MSR','Prepaid Maestro Travel Card','MST','Prepaid Maestro Teen Card','MSV','Prepaid Maestro Government Benefit Card','MSW','Prepaid Maestro Corporate (Reloadable) Card','MSX','Prepaid Maestro Flex Benefit Card','MSY','Prepaid Maestro Employee Incentive Card','MSZ','Prepaid Maestro Emergency Assistance Card','MTP','MasterCard Platinum Prepaid Travel (UK and Brazil)','MUS','Prepaid Unembossed MasterCard Card','MUW','MasterCard World Domestic Affluent','MWB','World Elite MasterCard Business Card','MWD','World Deferred','MWE','World Elite MasterCard Card','MWO','World Elite MasterCard Corporate Card','MWR','World Retailer Centric Payments','OLB','Maestro Small Business Delayed Debit','OLG','Maestro Gold Delayed Debit','OLP','Maestro Platinum Delayed Debit','OLS','Maestro (Student Card) Delayed Debit','OLW','World Maestro Delayed Debit','PMC','Proprietary Credit Card (Swedish domestic)','PMD','Proprietary Debit Card (Swedish domestic)','PSC','Common Proprietary Swedish Credit Card','PSD','Common Proprietary Swedish Debit Card','PVA','Private Label A','PVB','Private Label B','PVC','Private Label C','PVD','Private Label D','PVE','Private Label E','PVF','Private Label F','PVG','Private Label G','PVH','Private Label H','PVI','Private Label I','PVJ','Private Label J','PVL','Private Label K','SAG','Gold MasterCard Salary Immediate Debit','SAL','Standard Maestro Salary','SAP','Platinum MasterCard Salary Immediate Debit','SAS','Standard MasterCard Salary Immediate Debit','SOS','Standard MasterCard Social Immediate Debit','SUR','Prepaid Unembossed MasterCard Card (Non-US)','TBE','MasterCard Electronic Business Immediate Debit','TCB','MasterCard Corporate Immediate Debit','TCC','MasterCard (mixed BIN) Immediate Debit','TCE','MasterCard (Electronic) Student Card Immediate Debit','TCF','MasterCard Fleet Card Immediate Debit','TCG','Gold MasterCard Card Immediate Debit','TCO','(Corporate) Immediate Debit','TCP','MasterCard Purchasing Card Immeidate Debit','TCS','MasterCard Standard (Unembossed) Card Immediate Debit','TCW','World Signia Immediate Debit','TEB','MasterCard Executive BusinessCard Card Immediate Debit','TEC','MasterCard Electronic Commercial Immediate Debit','TEO','MasterCard Corporate Executive Card Immediate Debit','TNF','MasterCard Public Sector Commercial Card Immediate Debit','TNW','MasterCard New World Immediate Debit','TPB','MasterCard Preferred Business Card Immediate Debit','TPL','Platinum MasterCard Immediate Debit','WBE','World MasterCard Black Edition','1','Consumer Credit – Rewards','2','Commercial Credit','3','Consumer Debit','4','Commercial Debit','5','Prepaid Gift','6','Prepaid ID known','7','Consumer Credit - Premium','8','Consumer Credit – Core','9','Private Label Credit','10','Commercial Credit – Executive Business','11','Consumer Credit – Premium Plus','12','Commercial Prepaid – Non-Reloadable','IB','Non-US','IR','Non-US Reloadable','IS','Non-US Stored Value','RP','US Reloadable','SV','US Stored Value')card_category
,row_last_etl_date
,cpg_auth_date
,payment_method
,auth_status
,units

from
(
select prod_dur
,renewal_time
,renewal_rule_id
,substr(renewal_rule_id, 0,instr(renewal_rule_id,'_',1,1) - 1)site_ID
,substr(renewal_rule_id, instr(renewal_rule_id,'_',1,1) + 1,length(renewal_rule_id) - instr(renewal_rule_id,'_',1,1))Country
,substr(notes, instr(notes,'brand=',1,1) + 6, instr(notes,'usage=',1,1) - (instr(notes,'brand=',1,1) + 7))brand1
,substr(notes, instr(notes,'usage=',1,1) + 6, instr(notes,'category=',1,1) - (instr(notes,'usage=',1,1) + 7))usage1
,substr(notes, instr(notes,'category=',1,1) + 9, instr(notes,'class=',1,1) - (instr(notes,'category=',1,1) + 10))category1
,substr(notes, instr(notes,'class=',1,1) + 6, instr(notes,'source=',1,1) - (instr(notes,'class=',1,1) + 7))class1
,substr(notes, instr(notes,'source=',1,1) + 7, instr(notes,'countryID=',1,1) - (instr(notes,'source=',1,1) + 8))source1
,substr(notes, instr(notes,'countryID=',1,1) + 10, instr(notes,'testmode=',1,1) - (instr(notes,'countryID=',1,1) + 11))countryID
,row_last_etl_date
,cpg_auth_date
,(case when payment_method_id is null then 'PayPalExpress' else payment_method_id end)payment_method
,auth_status
,count(requisition_id)units

from
(
select prod_dur
,renewal_time
,renewal_rule_id
,row_last_etl_date
,(select distinct first_value(trunc(cpg_creation_date)) over (order by cpg_transaction_id) from rcn_auth_trans where requisition_id = division_order_id)cpg_auth_date
,(select distinct first_value(payment_method_id) over (order by cpg_transaction_id) from rcn_auth_trans where requisition_id = division_order_id)payment_method_id
,(select distinct first_value(notes) over (order by cpg_transaction_id) from rcn_auth_trans where requisition_id = division_order_id)notes
,auth_status
,requisition_id
,subscription_id
--select *
from
(
select requisition_id
,subscription_id
,prod_dur
,substr(renewal_time,0,instr(renewal_time,':',1,1) - 1)renewal_time
,renewal_rule_id
,row_last_etl_date
,(select src_create_dttm from SUB_PMT_FAIL_DFACT where subscription_id = ssai.subscription_id and requisition_id = platform_order_id)src_create_dttm
,(select subscription_segment_id from SUB_PMT_FAIL_DFACT where subscription_id = ssai.subscription_id and requisition_id = platform_order_id)subscription_segment_id
,(case when (select platform_order_id from SUB_PMT_FAIL_DFACT where subscription_id = ssai.subscription_id and requisition_id = platform_order_id) is not null then 'Declined'
when (select platform_order_id from LTV_SUB_DETAIL where subscription_id = ssai.subscription_id and requisition_id = platform_order_id) is not null then 'Completed' 
when (select paymentmethodid from ereport.cpg_transactions where requisition_id = divisionorderid and rownum < 2) = 'PayPalExpress' then  (select newstatus from ereport.cpg_transactions where requisition_id = divisionorderid and updatesource = 'SOAP.lookup')
when (select newstatus from ereport.cpg_transactions where requisition_id = divisionorderid and rownum < 2) is not null then  (select newstatus from ereport.cpg_transactions where requisition_id = divisionorderid and newstatus in ('Completed','Declined') and rownum < 2)
when (select status from rcn_payment_transaction where requisition_id = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2) is not null then 'Completed'
else 'Other' end)auth_status
,(select min(cpg_transaction_id) from rcn_auth_trans where requisition_id = division_order_id)cpg_transaction_id

from EREPORT.SUB_AUTH_ADDITIONAL_INFO ssai

where row_last_etl_date between '3/25/2018' and '3/29/2018'
and renewal_rule_id <> 'default'
--and subscription_id = '3260754709'

)BD

where src_create_dttm = (select min(src_create_dttm) from SUB_PMT_FAIL_DFACT where subscription_id = BD.subscription_id and subscription_segment_id = BD.subscription_segment_id)

or

src_create_dttm is null

)

where auth_status <> 'Other'


group by prod_dur
,renewal_time
,renewal_rule_id
,row_last_etl_date
,(case when payment_method_id is null then 'PayPalExpress' else payment_method_id end)
,auth_status
,cpg_auth_date
,substr(renewal_rule_id, 0,instr(renewal_rule_id,'_',1,1) - 1)
,substr(renewal_rule_id, instr(renewal_rule_id,'_',1,1) + 1,length(renewal_rule_id) - instr(renewal_rule_id,'_',1,1))
,substr(notes, instr(notes,'brand=',1,1) + 6, instr(notes,'usage=',1,1) - (instr(notes,'brand=',1,1) + 7))
,substr(notes, instr(notes,'usage=',1,1) + 6, instr(notes,'category=',1,1) - (instr(notes,'usage=',1,1) + 7))
,substr(notes, instr(notes,'category=',1,1) + 9, instr(notes,'class=',1,1) - (instr(notes,'category=',1,1) + 10))
,substr(notes, instr(notes,'class=',1,1) + 6, instr(notes,'source=',1,1) - (instr(notes,'class=',1,1) + 7))
,substr(notes, instr(notes,'source=',1,1) + 7, instr(notes,'countryID=',1,1) - (instr(notes,'source=',1,1) + 8))
,substr(notes, instr(notes,'countryID=',1,1) + 10, instr(notes,'testmode=',1,1) - (instr(notes,'countryID=',1,1) + 11))

)

)

left join

(
with configs as
(
select 'US' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CH' country, to_date('2/27/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 15 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 11 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 16 a_start, 16 a_end, 'B' bucket_type, 'B_16' bucket_name ,16 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 12 a_start, 12 a_end, 'B' bucket_type, 'B_12' bucket_name ,12 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CH' country, to_date('2/27/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/10/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 16 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 12 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 17 a_start, 17 a_end, 'B' bucket_type, 'B_17' bucket_name ,17 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 13 a_start, 13 a_end, 'B' bucket_type, 'B_13' bucket_name ,13 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/11/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/22/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 16 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 12 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 17 a_start, 17 a_end, 'B' bucket_type, 'B_17' bucket_name ,17 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 13 a_start, 13 a_end, 'B' bucket_type, 'B_13' bucket_name ,13 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 8 a_start, 8 a_end, 'C' bucket_type, 'C_8' bucket_name ,8 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 8 a_start, 8 a_end, 'C' bucket_type, 'C_8' bucket_name ,8 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/23/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/24/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 16 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 12 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 17 a_start, 17 a_end, 'B' bucket_type, 'B_17' bucket_name ,17 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 13 a_start, 13 a_end, 'B' bucket_type, 'B_13' bucket_name ,13 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'US' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'DE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 6 a_start, 6 a_end, 'C' bucket_type, 'C_6' bucket_name ,6 as bucket_hour from dual 
UNION
select 'GB' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'CH' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AU' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 8 a_start, 8 a_end, 'C' bucket_type, 'C_8' bucket_name ,8 as bucket_hour from dual 
UNION
select 'SE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'FR' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'BE' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NL' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CA' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'IT' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NO' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DK' country, to_date('3/25/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('3/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'US' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 4 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'GB' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CH' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'AU' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 16 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'SE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 12 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'FR' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'BE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NL' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'CA' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 8 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'IT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'NO' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 2 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'DK' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 0 a_start, 3 a_end, 'A' bucket_type, 'A_0' bucket_name ,0 as bucket_hour from dual 
UNION
select 'US' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 5 a_start, 5 a_end, 'B' bucket_type, 'B_5' bucket_name ,5 as bucket_hour from dual 
UNION
select 'DE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'GB' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'CH' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'AT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'AU' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 17 a_start, 17 a_end, 'B' bucket_type, 'B_17' bucket_name ,17 as bucket_hour from dual 
UNION
select 'SE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 13 a_start, 13 a_end, 'B' bucket_type, 'B_13' bucket_name ,13 as bucket_hour from dual 
UNION
select 'FR' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'BE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NL' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'CA' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 9 a_start, 9 a_end, 'B' bucket_type, 'B_9' bucket_name ,9 as bucket_hour from dual 
UNION
select 'IT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'NO' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 3 a_start, 3 a_end, 'B' bucket_type, 'B_3' bucket_name ,3 as bucket_hour from dual 
UNION
select 'DK' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 4 a_start, 4 a_end, 'B' bucket_type, 'B_4' bucket_name ,4 as bucket_hour from dual 
UNION
select 'US' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'DE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 6 a_start, 6 a_end, 'C' bucket_type, 'C_6' bucket_name ,6 as bucket_hour from dual 
UNION
select 'GB' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 7 a_start, 7 a_end, 'C' bucket_type, 'C_7' bucket_name ,7 as bucket_hour from dual 
UNION
select 'CH' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'AU' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 8 a_start, 8 a_end, 'C' bucket_type, 'C_8' bucket_name ,8 as bucket_hour from dual 
UNION
select 'SE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'NZ' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'FR' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 2 a_start, 2 a_end, 'C' bucket_type, 'C_2' bucket_name ,2 as bucket_hour from dual 
UNION
select 'BE' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NL' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'CA' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'IT' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'NO' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
UNION
select 'DK' country, to_date('4/1/2018 00:00:00','mm/dd/yyyy HH24:mi:ss') start_date, to_date('12/31/2018 23:59:59','mm/dd/yyyy HH24:mi:ss') end_date, 23 a_start, 23 a_end, 'C' bucket_type, 'C_23' bucket_name ,23 as bucket_hour from dual 
)

select *

from configs
)configs

on configs.country = bill_country
and cpg_auth_date between start_date and end_date
and renewal_time between a_start and a_end