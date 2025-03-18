select rpt.*
,(case when rpt.second_processor is null then rpt.payment_service_id || '||' || rpt.request_money_currency
when rpt.second_attempt_status = 'Completed' then rpt.payment_service_id || '||' || rpt.second_processor || '||' || rpt.request_money_currency
else payment_service_id || '||' || second_processor || '||' || (select distinct first_value(payment_service_id) over (order by transaction_id desc)dup_order from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id = rpt.division_order_id and transaction_type = 'Authorize') || '||' || request_money_currency end) Retry_Cycle
,(select distinct first_value(status) over (order by transaction_id desc)dup_order from cpg_payment_transaction where account_token = rpt.account_token and division_site_id = rpt.division_site_id and division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and transaction_id <> rpt.transaction_id and transaction_id <> second_transaction_id)third_attempt_status
,(case when (select status from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Authorize' and status = 'Completed' and rownum < 2) is not null then 'Completed' else 'Declined' end)Order_status
,rank1 Number_of_Submits
,decode(source1,'C','Credit','D','Debit','H','Charge','P','Prepaid','R','Deferred Debit')card_source
,decode(class1,'B','Business','C','Consumer','P','Purchase','T','Corporate')card_class
,decode(usage1,'C',' Credit Hybrid (meaning it has pin capability also).','X',' True credit (No PIN/Signature capability).','R',' Private Label (MasterCard)','P',' Debit - PIN Only without EBT.','E',' Debit � Pin Only with EBT.','H',' Debit Hybrid (PIN and Signature).','S',' Signature only (not PIN capable).','J',' USA Commercial Debit � Signature Only - No PIN Access.','K',' USA Commercial Debit - Pin Capable.','L',' NON USA Consumer Debit - No Pin Access','M',' NON USA Commercial Debit - No Pin Access.','N',' NON USA Consumer Debit - Pin Capable','O',' NON USA Commercial Debit - Pin Capable','U',' Reloadable Prepaid - Amex only','V',' Stored Value Prepaid � Amex only')card_usage_type
,decode(category1,'L','Visa Electron','N','Visa Platinum','N1','Visa Rewards','P','Visa Gold','Q','Private Label','R','Proprietary','S','Visa Purchasing','S1','Visa Purchasing with Fleet','S2','Visa GSA Purchasing','S3','Visa GSA Purchasing with Fleet','S4','Government Services Loan','S5','Visa Commercial Transport (EBT)','S6','Business Loan','S7','Visa Distribution','U','Visa Travel Money','V','V Pay','CIR','Cirrus','DAG','Global Debit MasterCard Salary','DAP','Platinum Debit MasterCard Salary','DAS','Standard Debit MasterCard Salary','DLG','Debit MasterCard Gold Delayed Debit','DLH','Debit MasterCard World Embossed Delayed Debit','DLP','Debit MasterCard Platinum Delayed Debit','DLS','Debit MasterCard Card Delayed Debit','DOS','Standard Debit MasterCard Social','MAB','World Elite MasterCard for Business Card','MAC','MasterCard World Elite Corporate Card','MAP','MasterCard Commercial Payments Account','MBB','MasterCard Prepaid Consumer','MBC','MasterCard Prepaid Voucher','MBD','MasterCard Professional Debit BusinessCard Card','MBE','MasterCard Electronic Business Card','MBF','Prepaid MC Food','MBK','MasterCard Black Card','MBM','Prepaid MC Meal','MBP','MasterCard Corporate Prepaid','MBT','MasterCard Corporate Prepaid Travel','MCB','MasterCard BusinessCard Card','MCC','MasterCard Credit Card (mixed BIN)','MCD','Debit MasterCard Card','MCE','MasterCard Electronic Card','MCF','MasterCard Fleet Card','MCG','Gold MasterCard Card','MCH','MasterCard Premium Charge','MCO','MasterCard Corporate (Meeting) Card','MCP','MasterCard Purchasing Card','MCS','(Unembossed) Standard MasterCard Card','MCT','Titanium MasterCard Card','MCV','Merchant-Branded Program','MCW','World MasterCard Card','MDB','Debit MasterCard BusinessCard Card','MDG','Gold Debit MasterCard Card','MDH','World Debit Embossed MasterCard Card','MDJ','Debit MasterCard (Enhanced)','MDL','Business Debit Other Embossed','MDO','Debit Other','MDP','Premium Debit MasterCard Card','MDR','Debit Brokerage','MDS','Standard Debit MasterCard','MDT','Commercial Debit MasterCard Card','MDW','World Elite Debit MasterCard','MEB','MasterCard Executive BusinessCard Card','MEC','MasterCard Electronic Commercial','MEF','MasterCard Electronic Payment Account','MEO','MasterCard Corporate Executive Card','MFB','Flex World Elite','MFD','Flex Platinum','MFE','Flex Charge World Elite','MFH','Flex World','MFL','Flex Charge Platinum','MFW','Flex World Charge','MGF','MasterCard Government Commercial Card','MHA','MasterCard Healthcare Prepaid Non-Tax','MHB','MasterCard HSA Substantiated (Debit MasterCard)','MHH','MasterCard HSA Non-Substantiated (Debit MasterCard)','MIA','Prepaid MasterCard Unembossed Student Card','MIK','Prepaid MasterCard Electronic Student (Non-US) Card','MIL','Unembossed MasterCard Student Card (Non-US)','MIP','Prepaid Debit MasterCard Student Card','MIU','Debit MasterCard Unembossed (Non-US)','MLF','MasterCard Agro Card','MNW','MasterCard World Card','MOC','Standard Maestro Social','MOG','Maestro Gold Card','MOP','Maestro Platinum','MOW','World Maestro','MPA','Prepaid Debit Standard Payroll','MPF','MasterCard Prepaid Debit Standard Gift','MPG','Debit MasterCard Standard Prepaid General Spend','MPJ','Prepaid Debit MasterCard Card Gold','MPK','MasterCard Prepaid Government Commercial Card','MPL','Platinum MasterCard Card','MPM','MasterCard Prepaid Debit Standard Consumer Incentive','MPN','MasterCard Prepaid Debit Standard Insurance','MPO','MasterCard Prepaid Debit Standard Offer','MPP','MasterCard Prepaid Card � Commercial Reward Funding','MPQ','MasterCard Prepaid Debit Standard Government Disaster','MPR','MasterCard Prepaid Debit Standard Travel','MPT','MasterCard Prepaid Debit Standard Teen','MPV','MasterCard Prepaid Debit Standard Government','MPW','Debit MasterCard Business Card Prepaid Workplace Business','MPX','MasterCard Prepaid Debit Standard Flex Benefit','MPY','MasterCard Prepaid Debit Standard Employee Incentive','MPZ','MasterCard Prepaid Debit Standard Government Consumer','MRB','MasterCard Prepaid Electronic Business Card (Non-US)','MRC','Prepaid MasterCard Electronic Card (Non-US)','MRG','MasterCard Prepaid Card (Non-US)','MRH','MasterCard Platinum Prepaid Travel (US)','MRJ','Prepaid MasterCard Gold Card','MRK','Prepaid MasterCard Public Sector Commercial Card','MRL','Prepaid MasterCard Electronic Commercial Card (Non-US)','MRO','MasterCard Rewards Only','MRP','Standard Retailer Centric Payments','MRS','Prepaid MasterCard ISIC Student Card','MRW','Prepaid MasterCard Business Card (Non-US)','MSA','Prepaid Maestro Payroll Card','MSB','Maestro Small Business Card','MSF','Prepaid Maestro Gift Card','MSG','Prepaid Maestro Consumer Reloadable Card','MSI','Maestro Student Card','MSJ','Prepaid Maestro Gold','MSM','Prepaid Maestro Consumer Promotion Card','MSN','Prepaid Maestro Insurance Card','MSO','Prepaid Maestro Other Card','MSQ','Unknown','MSR','Prepaid Maestro Travel Card','MST','Prepaid Maestro Teen Card','MSV','Prepaid Maestro Government Benefit Card','MSW','Prepaid Maestro Corporate (Reloadable) Card','MSX','Prepaid Maestro Flex Benefit Card','MSY','Prepaid Maestro Employee Incentive Card','MSZ','Prepaid Maestro Emergency Assistance Card','MTP','MasterCard Platinum Prepaid Travel (UK and Brazil)','MUS','Prepaid Unembossed MasterCard Card','MUW','MasterCard World Domestic Affluent','MWB','World Elite MasterCard Business Card','MWD','World Deferred','MWE','World Elite MasterCard Card','MWO','World Elite MasterCard Corporate Card','MWR','World Retailer Centric Payments','OLB','Maestro Small Business Delayed Debit','OLG','Maestro Gold Delayed Debit','OLP','Maestro Platinum Delayed Debit','OLS','Maestro (Student Card) Delayed Debit','OLW','World Maestro Delayed Debit','PMC','Proprietary Credit Card (Swedish domestic)','PMD','Proprietary Debit Card (Swedish domestic)','PSC','Common Proprietary Swedish Credit Card','PSD','Common Proprietary Swedish Debit Card','PVA','Private Label A','PVB','Private Label B','PVC','Private Label C','PVD','Private Label D','PVE','Private Label E','PVF','Private Label F','PVG','Private Label G','PVH','Private Label H','PVI','Private Label I','PVJ','Private Label J','PVL','Private Label K','SAG','Gold MasterCard Salary Immediate Debit','SAL','Standard Maestro Salary','SAP','Platinum MasterCard Salary Immediate Debit','SAS','Standard MasterCard Salary Immediate Debit','SOS','Standard MasterCard Social Immediate Debit','SUR','Prepaid Unembossed MasterCard Card (Non-US)','TBE','MasterCard Electronic Business Immediate Debit','TCB','MasterCard Corporate Immediate Debit','TCC','MasterCard (mixed BIN) Immediate Debit','TCE','MasterCard (Electronic) Student Card Immediate Debit','TCF','MasterCard Fleet Card Immediate Debit','TCG','Gold MasterCard Card Immediate Debit','TCO','(Corporate) Immediate Debit','TCP','MasterCard Purchasing Card Immeidate Debit','TCS','MasterCard Standard (Unembossed) Card Immediate Debit','TCW','World Signia Immediate Debit','TEB','MasterCard Executive BusinessCard Card Immediate Debit','TEC','MasterCard Electronic Commercial Immediate Debit','TEO','MasterCard Corporate Executive Card Immediate Debit','TNF','MasterCard Public Sector Commercial Card Immediate Debit','TNW','MasterCard New World Immediate Debit','TPB','MasterCard Preferred Business Card Immediate Debit','TPL','Platinum MasterCard Immediate Debit','WBE','World MasterCard Black Edition','1','Consumer Credit � Rewards','2','Commercial Credit','3','Consumer Debit','4','Commercial Debit','5','Prepaid Gift','6','Prepaid ID known','7','Consumer Credit - Premium','8','Consumer Credit � Core','9','Private Label Credit','10','Commercial Credit � Executive Business','11','Consumer Credit � Premium Plus','12','Commercial Prepaid � Non-Reloadable','IB','Non-US','IR','Non-US Reloadable','IS','Non-US Stored Value','RP','US Reloadable','SV','US Stored Value')card_category

from
(
select cpt.*
        ,to_char(creation_date,'HH24')hour_of_day
        ,to_char(creation_date,'D')Day_of_week
        ,(select distinct first_value(payment_service_id) over (order by transaction_id)dup_order from cpg_payment_transaction where account_token = cpt.account_token and division_site_id = cpt.division_site_id and division_order_id = cpt.division_order_id and transaction_id <> cpt.transaction_id and transaction_type = 'Authorize')second_processor
        ,(select distinct first_value(status) over (order by transaction_id)dup_order from cpg_payment_transaction where account_token = cpt.account_token and division_site_id = cpt.division_site_id and division_order_id = cpt.division_order_id and transaction_id <> cpt.transaction_id and transaction_type = 'Authorize')second_attempt_status
        ,(select distinct first_value(transaction_id) over (order by transaction_id)dup_order from cpg_payment_transaction where account_token = cpt.account_token and division_site_id = cpt.division_site_id and division_order_id = cpt.division_order_id and transaction_id <> cpt.transaction_id and transaction_type = 'Authorize')second_transaction_id
        ,Rank() Over (Partition By Account_Token Order By transaction_id)Order_ID_Rank
        ,Rank() Over (Partition By Account_Token,Payment_service_id Order By transaction_id)Rank1
        ,substr(bank_name,instr(bank_name,'cardBrand=')+10,(instr(bank_name,'cardUsage',1,1)-(instr(bank_name,'cardBrand=')+11))) brand
        ,substr(bank_name,instr(bank_name,'cardUsage=')+10,(instr(bank_name,'cardCategory',1,1)-(instr(bank_name,'cardUsage=')+11))) usage1
        ,substr(bank_name,instr(bank_name,'cardCategory=')+13,(instr(bank_name,'cardClass',1,1)-(instr(bank_name,'cardCategory=')+14))) category1
        ,substr(bank_name,instr(bank_name,'cardClass=')+10,(instr(bank_name,'fundingSource',1,1)-(instr(bank_name,'cardClass=')+11))) class1
        ,substr(bank_name,instr(bank_name,'fundingSource=')+14,(instr(bank_name,'countryID',1,1)) - (instr(bank_name,'fundingSource=')+15)) source1

from cpg_payment_transaction cpt

where creation_date > '7/13/2017'
and status in ('Declined', 'Completed')
and transaction_type = 'Authorize'
and division_site_id in ('mfeus','mfeap','mfejp','mfeeu')
and test_mode <> 12
 
 )rpt
 
 where Order_ID_Rank = 1