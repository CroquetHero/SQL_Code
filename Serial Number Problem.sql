select nnc.message

from req_line_item rli,ntf_notification_content nnc, ntf_notification nn

where RLI.requisition_id = nn.requisition_id
and nn.notification_id = nnc.notification_id
and rli.requisition_id = '11638019872'
AND NN.EVENT_NAME = 'User Order Confirmation event'