select month
        ,(select status from cpg_payment_transaction where 
        ,rec_flag
        ,Number_Attempt_Per_Token
        ,Retry_Attempt
        ,Number_Of_Submits
        ,payment_service_id
        ,count(Division_Order_Id)units

from
(
select month
        ,status
        ,rec_flag
        ,Rank() Over (Partition By Account_Token Order By Creation_Date)Number_Attempt_Per_Token
        ,Rank() Over (Partition By Division_Order_Id,Account_Token,Rank1 Order By Creation_Date)Retry_Attempt
        ,transaction_id
        ,payment_service_id
        ,Rank1 Number_Of_Submits
        ,Division_Order_Id
        
        from
(
select to_char(creation_date, 'MM/YYYY')month
        ,status
        ,creation_date
        ,(case when custom_data like '%recurring%' then 'Recurring' else 'Non-Recurring' end)rec_flag
        ,account_token
        ,division_order_id
        ,payment_service_id
        ,Rank() Over (Partition By Account_Token,Division_Order_Id Order By Creation_Date)Rank
        ,Rank() Over (Partition By Division_Order_Id,Account_Token,Payment_service_id Order By Creation_Date)Rank1
        ,transaction_id

from cpg_payment_transaction

where creation_date > '3/1/2016'
and status in ('Declined', 'Completed')
and division_site_id = 'ncsoft'
and payment_service_id in ('litle', 'mes', 'firstdata') 
and payment_method_id in ('MasterCard', 'Visa')
--and bank_name = 'Chase Bank USA, National Association'
and account_token = '56413452600000000000007560030403'
and division_order_id = '10896684534'

)

)

group by month
        ,status
        ,rec_flag
        ,Number_Attempt_Per_Token
        ,Retry_Attempt
        ,Number_Of_Submits
        ,payment_service_id