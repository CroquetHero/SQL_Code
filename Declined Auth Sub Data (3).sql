select distinct auth_date
      ,sub_length
      ,site_id
      ,Customer_attrition
      ,'Declined'
      ,payment_method_id
      ,processor
  --    ,'Inf'
      ,auth_code
   --   ,'No CB'
  --    ,'No Refund'
      ,units*decline_count units
      
      from
(
select auth_date
      ,sub_length
      ,site_id
      ,Customer_attrition
      ,'Declined'
      ,payment_method_id
      ,processor
   --   ,'Inf'
      ,auth_code
   --   ,'No CB'
   --   ,'No Refund'
      ,decline_count
      ,count(subscription_id)units
      ,sum(usd)usd
      
      from
(
select auth_date
      ,Customer_attrition
    --  ,decline_count
      ,(case when sub_length = 7 then 'One Week'
             when sub_length between 28 and 32 then 'One Week'
             when sub_length between 58 and 61 then 'Two Months'
             when sub_length between 89 and 92 then 'Three Months'
             when sub_length between 346 and 373 then 'One Year'
             when sub_length between 722 and 750 then 'Two Years'
             when sub_length between 1091 and 1103 then 'Three Years'
             else 'Other' end)sub_length    
      ,(select distinct division_site_id from rcn_auth_trans where division_order_id = order_id)site_id
      ,(select max(response_code) from rcn_auth_trans where division_order_id = order_id)auth_code
      ,(select distinct payment_method_id from rcn_auth_trans where division_order_id = order_id and rownum < 2)payment_method_id
      ,(select distinct payment_processor_name from rcn_auth_trans where division_order_id = order_id and rownum < 2)processor
      ,subscription_id
      ,order_id
      ,(select count(cpg_transaction_id) from rcn_auth_trans where division_order_id = order_id and status in ('Failed', 'Declined'))decline_count
      ,usd
      
      from
(
select distinct subscription_id
      ,platform_order_id order_id
      ,(select max(purchased_duration_dt) from sub_seg_expiring_sfact where subscription_id = spfd.subscription_id) - (select max(activation_dt) from sub_seg_expiring_sfact where subscription_id = spfd.subscription_id) sub_length
      ,trunc(src_create_dttm)auth_date
      ,(select count(platform_order_id) + 1 from sub_seg_expiring_sfact where subscription_id = spfd.subscription_id)Customer_attrition
      ,(select to_char(min(src_create_dttm), 'HH24') from sub_pmt_fail_dfact where subscription_id = spfd.subscription_id)auth_hour
      ,decode((select transaction_currency from rcn_auth_trans where division_order_id = platform_order_id and rownum < 2), 'USD', (select payment_amount from rcn_auth_trans where division_order_id = platform_order_id and rownum < 2), ((select payment_amount from rcn_auth_trans where division_order_id = platform_order_id and rownum < 2)/(select der.exchange_rate_num from Currency_exchange_sfact_vw der where trunc(src_create_dttm) = der.effective_date and (select transaction_currency from rcn_auth_trans where division_order_id = platform_order_id and rownum < 2) = der.to_currency_code and rownum < 2))) as usd

   --   ,(select count(platform_order_id)from sub_pmt_fail_dfact where subscription_id = spfd.subscription_id)decline_count

from sub_pmt_fail_dfact spfd

where src_create_dttm between '21-jul-14' and sysdate
--and src_create_dttm = (select min(src_create_dttm) from sub_pmt_fail_dfact where subscription_id = spfd.subscription_id)
--and subscription_id = '1681094009'

)
--where (select distinct division_site_id from rcn_auth_trans where division_order_id = order_id) = 'tmamer'
--and sub_length between 720 and 735
--and customer_attrition > 2
)
where site_id is not null
--and site_id = 'tmamer'
--and sub_length > 1000
--and customer_attrition > 2

group by auth_date
      ,sub_length
      ,site_id
      ,Customer_attrition
      ,'Declined'
      ,payment_method_id
      ,processor
      ,'Inf'
      ,auth_code
      ,'No CB'
      ,'No Refund'
      ,decline_count
      
      )
      
      