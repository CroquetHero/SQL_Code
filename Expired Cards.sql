select auth_date
      ,cb_status
      ,count(division_order_id)units
      
      from 
(
select division_order_id
      ,trunc(creation_date)auth_date
      ,(case when (select message from cpg_log where division_order_id = cl.division_order_id and source_method_name = 'processTransaction' and message like '%Created ChargeBack transaction%'and rownum < 2) is not null then 'CB' else 'No CB' end)cb_status

from cpg_log cl

where creation_date between '01-mar-15' and '06-mar-15'
and source_method_name = 'checkExpirationDate'
and payment_method_id = 'Visa'

--and division_order_id = '13419471200'

--order by creation_date

)

group by auth_date
      ,cb_status