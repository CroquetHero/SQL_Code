select ss.subscription_id
,rr.requisition_id
,ss.site_id
,trunc(ssl.creation_Date)day

from sub_subscription_log ssl, sub_subscription ss,sub_subscription_li_item SSLI, REQ_LINE_ITEM rli,req_requisition rr
where ssl.subscription_id = ss.subscription_id
and ssli.subscription_id = ss.subscription_id
and ssli.req_line_item_id = rli.line_item_id
and rr.requisition_id = rli.requisition_id
AND ssl.creation_Date between '12/21/2016' and '12/28/2016'
and ssl.EVENT_SOURCE='ModifySubRenewalDateExecutionHandler'
and ss.site_id like 'kasper%'
and ssl.action= 'ACTION_SUBSCRIPTION_EXP_DATE_CHANGE'
and rr.state_id = '7'
