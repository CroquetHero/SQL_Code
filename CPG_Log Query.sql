select auth_status
      ,division_site_id
      ,(case when exp_year < 2014 then 'Expired'
             when exp_year >= 2015 then 'Good'
             when exp_year = 2014 and exp_month <= to_char(auth_date, 'MM') then 'Expired'
             else 'Good' end)Card_Status
     ,exp_month
     ,exp_year
     
     from
(
select division_order_id
    --  ,message
      ,(case when (select message from cpg_log where division_order_id = cl.division_order_id and message = ' Declined to authorize with firstdata'and rownum < 2)is not null then 'Declined' else 'Completed' end)auth_status
      ,division_site_id
      ,trunc(creation_date)auth_date
      ,substr(message, 35, 2)exp_month
      ,(substr(message, 37, 2)+ 1997)exp_year

from cpg_log cl

where division_id <> 'netgiro'
and division_site_id = 'tmamer'
and source_method_name = 'checkExpirationDate'

)

where exp_year > 2013
and exp_month > 4