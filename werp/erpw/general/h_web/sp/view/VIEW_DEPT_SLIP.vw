CREATE OR REPLACE FORCE VIEW VIEW_DEPT_SLIP
(DEPT_CODE, COMP_CODE, COMP_NAME, LEVEL_CODE, TITLE_NAME, 
 LONG_NAME, BONBU_CODE, BONBU_NAME, SHORT_NAME, ENGLISH_NAME, 
 DEPT_PROJ_TAG, USE_TAG, PROCESS_CODE, DEPT_SEQ_KEY, DEGREE, 
 NO_SEQ)
AS 
select a.dept_code,b.comp_code,b.comp_name,b.level_code, b.title_name,a.long_name,
		 decode(a.dept_proj_tag, 'P', a.dept_code, b.bonbu_code) bonbu_code,
		 decode(a.dept_proj_tag, 'P', a.short_name, b.bonbu_name) bonbu_name,		    
		a.short_name,a.english_name, a.dept_proj_tag,a.use_tag,a.process_code,          
		b.dept_seq_key,b.degree,nvl(b.no_seq,0) no_seq      
from z_code_dept a,         
		( select c.dept_code,b.comp_code,e.comp_name,b.level_code,          
					decode(c.dept_code, 'A01729', 'A01729', 
					   decode( substr(c.dept_code,1,4), 'A017', 'A01799', b.comp_code || '9999')) bonbu_code,      
					decode(c.dept_code, 'A01729', '기술연구소', 
					   decode( substr(c.dept_code,1,4), 'A017', '기술본부', '본사')) bonbu_name,      
					b.title_name,c.dept_seq_key,a.degree,nvl(c.no_seq,0) no_seq
			from ( select max(degree) degree from z_code_dept_degree ) a,                 
					z_code_chg_dept_title b,                  
					z_code_chg_dept_content c,                  
					z_code_comp e              
			where b.degree = a.degree                
			  and c.degree = a.degree               
			  and b.dept_seq_key = c.dept_seq_key                
			  and b.comp_code = e.comp_code ) b      
where a.dept_code = b.dept_code (+);



