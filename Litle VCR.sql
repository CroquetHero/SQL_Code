select Order_ID
,case_Num
,sub_ID
--,division_site_id
--,payment_amount
,recent_order
,(select cpg_creation_date from rcn_payment_transaction where BD2.recent_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)recent_Date
,(select payment_amount from rcn_payment_transaction where BD2.recent_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)recent_amount
,(select payment_processor_name from rcn_payment_transaction where BD2.recent_order = division_order_id and transaction_type = 'Settle' and status = 'Completed' and rownum < 2)recent_proc
,(select reference_number from rcn_payment_transaction where BD2.recent_order = division_order_id and transaction_type = 'Fund' and status = 'Completed' and payment_amount > 0 and rownum < 2)recent_ARN
,recent_order_type

from
(
select division_order_id Order_ID
,sub_ID
,division_site_id
,payment_amount
,case_Num
,(select distinct first_value(platform_order_id) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where BD.sub_ID = subscription_id and BD.division_order_id <> platform_order_id)recent_order
,(select distinct first_value(subscription_type_code) over (order by src_create_dttm desc) from SUB_SEG_EXPIRE_DNORM where BD.sub_ID = subscription_id and BD.division_order_id <> platform_order_id)recent_order_type

from
(
select division_order_id
,division_site_id
,payment_amount
,reference_number case_Num
,(select min(subscription_id) from SUB_SEG_EXPIRE_DNORM where rpt.division_order_id = platform_order_id)sub_ID

from rcn_payment_transaction rpt

where creation_date > sysdate - 10
and transaction_type = 'ChargeBack'
and status = 'Completed'
and payment_processor_name = 'litle'
and reference_number in ('27791635635744','27792159089441','27792157911943','27792158654245','27792159056143','27792158628843','27792367305746','27792367977148','27792367311645','27792367321743','27792363318842','27792363384547','27792365759142','27792367957942','27792363297848','27792367973949','27792368416344','27792366909241','27792368409240','27792365715441','27792367954345','27792367935146','27792367308542','27792583123048','27792586696743','27792589073346','27792589069245','27792588511544','27792585565949','27792588593849','27792584516349','27792586778046','27792587810046','27792584552740','27792585592547','27792784511546','27792784528243','27792784233042','27792783118848','27792783913347','27792783674543','27792784524143','27792783128441','27792783612048','27792784246044','27792785141343','27792784584444','27792784808249','27792784854649','27792945944842','27792946551745','27792945038249','27792945910744','27792945951045','27792946547040','27792945010941','27792945926641','27792944257048','27792945671940','27792945672146','27792945962745','27792945965649','27792944250142','27792944198044','27792946197044','27792945650043','27792946525343','27792944707141','27792945597749','27792945934546','27792946290344','27792945906742','27792944746248','27792946531242','27792945350842','27792945948744','27792945951649','27792945345743','27792945633148','27792945951847','27792946580843','27792945936541','27792945088947','27793000242346','27792999501241','27792999514640','27792999546949','27793000202944','27793000216845','27793000244540','27793000287747','27793125417245','27793125411545','27793124981340','27793124966549','27793125424449','27793124987941','27793125425644')

)BD

)BD2

order by recent_proc
