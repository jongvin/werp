CREATE VIEW view_dept_code (dept_code,comp_code,comp_name,level_code,title_name,long_name,
                            short_name,english_name,dept_proj_tag,use_tag,process_code,dept_seq_key,degree,no_seq) AS
 select a.dept_code,b.comp_code,b.comp_name,b.level_code, b.title_name,a.long_name,
        a.short_name,a.english_name, a.dept_proj_tag,a.use_tag,a.process_code,
        b.dept_seq_key,b.degree,nvl(b.no_seq,0) no_seq
    from z_code_dept a, 
      ( select c.dept_code,b.comp_code,e.comp_name,b.level_code, 
               b.title_name,c.dept_seq_key,a.degree,nvl(c.no_seq,0) no_seq 
           from ( select max(degree) degree from z_code_dept_degree ) a,
               z_code_chg_dept_title b, 
               z_code_chg_dept_content c, 
               z_code_comp e 
           where b.degree = a.degree 
             and c.degree = a.degree
             and b.dept_seq_key = c.dept_seq_key 
             and b.comp_code = e.comp_code ) b 
   where a.dept_code = b.dept_code (+)