select * from 
(    select data1.units ,round(data2.stdv,3)stdv ,round(data2.med,3) past_6_week_median , ( case when data1.units = 0 and num < 3 then 0 when data1.units > (data2.med + (2*data2.stdv)) then 1 when data1.units < (data2.med - (2*data2.stdv)) then 1 when data1.units = 0 and data2.med <> 0 then 1 else 0  end ) control
     from (select  count(transaction_id) units
             from cpg_payment_transaction rpt
             where creation_date between trunc(sysdate) -1 and trunc(sysdate) and transaction_type = 'ChargeBack' and payment_service_id in ('paypalExpress', 'paypalAdaptive') and status = 'Completed'
            ) data1
        ,
            (select stddev(units)stdv, avg(units)med, sum(decode(units, '0',0,1)) as num 
             from
                   ( select dates.day#, dates.week#, nvl(data1.units,0) units
                     from
                     ( select  to_char(date1, 'D') day# ,to_char(date1, 'WW') week# 
                       from ( SELECT trunc(to_date(sysdate-50), 'Day') + (rownum -1) date1 FROM dual CONNECT BY LEVEL <= trunc(to_date(sysdate -2),'Day') - trunc(to_date(sysdate-50), 'Day') + 1) where to_char(date1,'D') = to_char(sysdate,'D')- 1
                      )    dates           
             left outer join
                    ( select to_char(rpt.creation_date, 'D') day# ,to_char(rpt.creation_date, 'WW') week# ,count(transaction_id) units
                       from cpg_payment_transaction rpt
                       where creation_date between trunc(sysdate) -50 and trunc(sysdate) -1 and to_char(creation_date,'D') = to_char(sysdate,'D')- 1 and payment_service_id in ('paypalExpress', 'paypalAdaptive') and transaction_type = 'ChargeBack' and status = 'Completed'
                       group by to_char(rpt.creation_date, 'D') ,to_char(rpt.creation_date, 'WW')    )  data1
            on dates.day# = data1.day#
            and dates.week# = data1.week#  )        
            ) data2
    )
where control = '1'