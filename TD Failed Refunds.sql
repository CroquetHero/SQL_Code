select distinct division_order_id
,failed_refund_date
,failed_refund_Amount
,Refund_amount
,nvl(settle_amount,0) + nvl(Rev_amount,0) - nvl(CB_amount,0) - nvl(Refund_amount,0)Net
,(case when nvl(settle_amount,0) + nvl(Rev_amount,0) - nvl(CB_amount,0) - nvl(Refund_amount,0) < 0 then 'Previously under 0'
when nvl(settle_amount,0) + nvl(Rev_amount,0) - nvl(CB_amount,0) - nvl(Refund_amount,0) = 0 then 'Net 0'
when failed_refund_amount = refund_amount then 'Double Refund'
when CB_Date < failed_refund_date then 'Refund Post CB'
else 'Other' end)Failed_Reason

from
(
select division_order_id
,creation_date failed_refund_date
,request_money_amount failed_refund_Amount
,(select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'ChargeBack' and status = 'Completed')CB_Date
,(select sum(response_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and creation_date < rpt.creation_date and transaction_type = 'Settle' and status = 'Completed')settle_amount
,(select sum(response_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and creation_date < rpt.creation_date and transaction_type = 'Refund' and status = 'Completed')Refund_amount
,(select sum(response_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and creation_date < rpt.creation_date and transaction_type = 'ChargeBack' and status = 'Completed')CB_amount
,(select sum(response_money_amount) from cpg_payment_transaction where division_order_id = rpt.division_order_id and creation_date < rpt.creation_date and transaction_type = 'ChargeBackRevrs' and status = 'Completed')Rev_amount

from cpg_payment_transaction rpt

where transaction_type = 'Refund'
and status = 'Failed'
and response_code_1 = '206'
and division_order_id in ('10387220775','10373547776','10393815175','10393815175','15063788471','10392576675','15060146971','10409540275','10430003576','10395875275','10449408976','10432241576','10430274476','10383499375','10430722676','10398633676','10125546278','10408964175','10454008776','10416111875','10442963476','10462994276','10392166475','10457926576','10468597776','10127223977','10425998675','10469313776','10429846275','10432201175','10419541575','10420076975','10475299276','10435970075','10472254876','10469432176','10468024276','10432723975','10418147575','10477326176','10438240775','10482541776','10459134776','10477066276','10482368076','10476750276','10487245876','10482178276','10484363576','10445337775','10378767375','10380349875','10443980175','10486831476','10482178276','10442379575','10479481276','10483978376','10473578876','10445394975','10487245876','10442379575','10126042477','10443980175','10136125477','10469091476','10472875176','10492734376','10455716475','10492734376','10455377475','10432732876','15064318371','15035218171','10135973277','10132394178','10131489678','10133239078','10134796377','10134174977','10459197776','10132717678','10135899077','10134263877','10420417775','10132406178','10455484076','10130051078','10136102077','10134945677','10133017178','10460608076','10456406376','10124542878','10133409978','10136018077','10136140277','10135689677','10135994977','10415422975','10413520775','10450040776','10135892877','10135822877','10125488878','10133085678','10135713977','10135945177','10133386778','10135795877','10131643978','10135319677','10134002677','10135720277','10135306877','10418745975','10133479078','10457642275','10490393976','10431165775','10130668278','10465190975','10494025775','10444131576','10436795276','10437294775','10364090375','10330162475','10358067175','10316243075','10241014775','10482564876','10378647075','10231056275','14742049571','10471536676','10442340275','10135563377','10497629675','10469065475','10495474976','10469065475','10494499675')
and creation_date = (select min(creation_date) from cpg_payment_transaction where division_order_id = rpt.division_order_id and transaction_type = 'Refund' and status = 'Failed' and response_code_1 = '206')
--and division_order_id = '10482564876'

)

order by Failed_Reason

