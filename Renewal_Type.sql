select display_name
        ,(case when initial_is_automatic = 1 then 'Automatic'
        when initial_is_automatic = 0 then 'Manual' else 'Other' end)is_automatic
        ,(case when display_name like '%Trial%' then substr(display_name, instr(display_name,'-',1,2)+2, (instr(display_name,',',1,1) - instr(display_name,'-',1,2)) - 2)
        else substr(display_name, instr(display_name,'-',1,1)+2, (instr(display_name,',',1,1) - instr(display_name,'-',1,1)) - 2) end)PC_Num
        ,count(requisition_id)units
--select initial_is_automatic,requisition_id
from sub_subscription_li_item ssli, req_line_item rli, cat_product_data cpd

where ssli.req_line_item_id = rli.line_item_id
and rli.product_data_id = cpd.product_data_id
and ssli.creation_date > '10/1/2017'
and ssli.line_item_type = 'ORIGINAL'
and rli.site_id = 'avast'
and locale = 'en_US'
--and display_name = 'Avast Internet Security - 1 PC, 1 Year'

group by display_name
        ,(case when initial_is_automatic = 1 then 'Automatic'
        when initial_is_automatic = 0 then 'Manual' else 'Other' end)
        ,(case when display_name like '%Trial%' then substr(display_name, instr(display_name,'-',1,2)+2, (instr(display_name,',',1,1) - instr(display_name,'-',1,2)) - 2)
        else substr(display_name, instr(display_name,'-',1,1)+2, (instr(display_name,',',1,1) - instr(display_name,'-',1,1)) - 2) end)
        
        order by units desc