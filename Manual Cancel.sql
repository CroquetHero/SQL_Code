select seg.platform_order_id
,seg.sub_comp_status_key
,c.sub_comp_status_code
,seg.sub_trans_status_key
,t.sub_comp_status_code

from sub_seg_expire_dnorm seg, sub_comp_status_hlp c, sub_comp_status_hlp t

where seg.sub_comp_status_key = c.sub_comp_status_key
and seg.sub_trans_status_key = t.sub_comp_status_key
and seg.platform_order_id in ('11522839000','11524098700')--,'11527388700','11527492100','11532033000','11532057700','11538309100','12175063725','12641233200','12644568000','12644691800','25246979224','25247069724','25249158424','25252089424','25252362524','25252928624','25253949124','25254307824','25254633524','25254662724','25256400924','25257037824','25259446624','25260537024','11507409400','11523412800','11524813200','11526922700','11531711300','12178843325','12641056800','12641120600','12641203600','12641369500','12641387600','12641394400','12641532000','12644621700','12644737900','25246787024','25247076024','25247529424','25247857924','25251979724','25252302024','25254260524','25254463724','25255613724','25259336624','25259906524','11523077700','11523239100','11523279900','11531711900','11533036000','12641177300','12641557900','12641676700','12644607400','12649169300','13064800200','25247493724','25248371224','25248603324','25252689924','25253177624','25253184124','25253460024','25254484524','25255055724','25256615524','25256671724','25256737024','25256860924','25260082224','11522899800','11523834000','11526844800','11527020500','11527644600','11531096400','11557913200','12641497800','12641570000','12641576000','12644766000','12644954300','12649218100','25246495024','25247405024','25247680524','25247816824','25248455524','25249837924','25252715524','25252839924','25253843424','25254628924','25260211424','11434566300','11523533400','11531097100','12641646600','12644891800','12648695200','12648730200','13023976200','25246744024','25246973224','25247741124','25248546624','25249562424','25252986224','25253142024','25257170424','25260605624','11527381100','11527506500','12641054600','12644842500','12644845100','12644941900','12644996600','25246579424','25249446624','25249728024','25251842124','25254081124','25254258224','25254847924','25259111924','25259666324','25260659224','11522948900','11523291800','11523402000','11558080600','12641310600','12641621100','12648803100','25247267524','25250375524','25254198124','25255650424','25255811124','25257508724','25259798024','25260404924','11373654100','11418613800','11523796900','11527375700','11531446000','11532029000','11547151300','25246926124','25247387124','25249130724','25250389524','25253081124','25253948324','25254027724','25254945524','25254984024','25256346624','25259848124','25259900624','25259902124','25260038124','25260548524')
