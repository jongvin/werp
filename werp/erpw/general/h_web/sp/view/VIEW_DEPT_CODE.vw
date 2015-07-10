CREATE OR REPLACE FORCE VIEW VIEW_DEPT_CODE
(DEPT_CODE, COMP_CODE, COMP_NAME, LEVEL_CODE, TITLE_NAME, 
 LONG_NAME, SHORT_NAME, ENGLISH_NAME, DEPT_PROJ_TAG, USE_TAG, 
 PROCESS_CODE, DEPT_SEQ_KEY, DEGREE, NO_SEQ, PROJ_UNQ_KEY)
AS 
select a.dept_code,     b.comp_code, b.comp_name,    b.level_code, 
       b.title_name,    a.long_name, a.short_name,   a.english_name, 
       a.dept_proj_tag, a.use_tag,   a.process_code, b.dept_seq_key,
       b.degree,        nvl(b.no_seq,0) no_seq ,a.proj_unq_key       
from z_code_dept a, 
(select c.dept_code,b.comp_code,e.comp_name,b.level_code, b.title_name,c.dept_seq_key, 
a.degree,nvl(c.no_seq,0) no_seq  from ( select max(degree) degree from z_code_dept_degree ) a, z_code_chg_dept_title b, z_code_chg_dept_content c,            z_code_comp e where b.degree = a.degree            and c.degree = a.degree and b.dept_seq_key = c.dept_seq_key and b.comp_code = e.comp_code ) b            where a.dept_code = b.dept_code (+);



