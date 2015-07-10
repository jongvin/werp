CREATE OR REPLACE FORCE VIEW VIEW_DEPT_CODE_TITLE
(LEVEL_CODE, TITLE_NAME)
AS 
select b.level_code,  
       b.title_name       
from   (select b.level_code, b.title_name from   ( select max(degree) degree from z_code_dept_degree ) a,             
			  z_code_chg_dept_title b         
where  b.degree = a.degree) b;



