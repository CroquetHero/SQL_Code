=CONCATENATE("INSERT INTO ECO_SETTINGS ",VALUES("'",A2,"','",B2,"','",C2,"','",D2,"','",E2,"','",F2,"','",G2,"','",H2,"','",I2,"','",J2,"','",K2,"','",L2,"');")

select 
REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(rule_id, '(_){2,}', '_'), '_$', ''), '^_', '') rule_id
, 'Tab_' || percentage_allocation || '-' || (group_id - start_setting_id) identifier
, percentage_allocation
, platform_id
, site_id
, payment_method
, billing_country
, bin
, calendar_attempt
, eco_type
, value
from 
(
select 
expiration_date_id
, (select (min(expiration_date_id) - 10) from ECO_SETTINGS) start_setting_id
, parent_id
, case when parent_id = '0' then expiration_date_id else parent_id end group_id
, division_id || '_' || division_site_id || '_' || country_id || '_' || payment_service_id || '_' || payment_method_id || '_' || bin_min rule_id
, case when parent_id = '0' then nvl(weight, '100')
       when parent_id <> '0' then (select nvl(weight, '100') from ECO_SETTINGS es_in where es_in.expiration_date_id = es.parent_id)
       else weight end percentage_allocation
, division_id platform_id
, division_site_id site_id
, payment_method_id payment_method
, country_id billing_country
, bin_min bin
, attempt_number calendar_attempt
, case when date_increment = 0 then 'STALE' else 'ADD_YEARS' end ECO_TYPE
, case when date_increment = 0 then '' else date_increment end value
from ECO_SETTINGS es
)
order by rule_id, identifier, percentage_allocation desc, calendar_attempt