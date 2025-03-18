SELECT table_name,owner,column_name

FROM ALL_tab_columns 

WHERE column_name LIKE '%SHIPPING%'

ORDER BY TABLE_NAME,COLUMN_NAME