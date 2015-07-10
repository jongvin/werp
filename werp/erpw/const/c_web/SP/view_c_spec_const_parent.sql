CREATE VIEW view_c_spec_const_parent
    (yymm,sum_code,parent_sum_code,dept_code,long_name,use_tag,no_seq,
    cnt_result_amt,cnt_result_mat_amt,cnt_result_lab_amt,
    cnt_result_exp_amt,result_amt,result_mat_amt,result_sub_amt,
    result_lab_amt,result_equ_amt,result_exp_amt,cost_amt,cost_mat_amt,
    cost_sub_amt,cost_lab_amt,cost_equ_amt,cost_exp_amt,wbs_code,
    pre_result_amt,pre_result_rate,ls_cnt_result_amt,
    ls_cnt_result_mat_amt,ls_cnt_result_lab_amt,ls_cnt_result_exp_amt,
    ls_result_amt,ls_result_mat_amt,ls_result_sub_amt,ls_result_lab_amt,
    ls_result_equ_amt,ls_result_exp_amt,ls_cost_amt,ls_cost_mat_amt,
    ls_cost_sub_amt,ls_cost_lab_amt,ls_cost_equ_amt,ls_cost_exp_amt,
    cnt_amt,cnt_mat_amt,cnt_lab_amt,cnt_exp_amt,amt,mat_amt,lab_amt,
    exp_amt,equ_amt,sub_amt,proj_pos,proj_charge,chg_const_start_date,chg_const_end_date)
  AS SELECT c_spec_const_parent.yymm, c_spec_class_parent.sum_code, 
        c_spec_class_parent.parent_sum_code, c_spec_const_parent.dept_code, 
        z_code_dept.long_name, z_code_dept.use_tag, c_spec_class_child.no_seq,
        c_spec_const_parent.cnt_result_amt, c_spec_const_parent.cnt_result_mat_amt, 
        c_spec_const_parent.cnt_result_lab_amt, c_spec_const_parent.cnt_result_exp_amt, 
        c_spec_const_parent.result_amt, c_spec_const_parent.result_mat_amt,
        c_spec_const_parent.result_sub_amt, c_spec_const_parent.result_lab_amt, 
        c_spec_const_parent.result_equ_amt, c_spec_const_parent.result_exp_amt, 
        c_spec_const_parent.cost_amt, c_spec_const_parent.cost_mat_amt, 
        c_spec_const_parent.cost_sub_amt, c_spec_const_parent.cost_lab_amt,
        c_spec_const_parent.cost_equ_amt, c_spec_const_parent.cost_exp_amt,
        c_spec_const_parent.wbs_code, c_spec_const_parent.pre_result_amt,
        c_spec_const_parent.pre_result_rate, c_spec_const_parent.ls_cnt_result_amt,
        c_spec_const_parent.ls_cnt_result_mat_amt, c_spec_const_parent.ls_cnt_result_lab_amt, 
        c_spec_const_parent.ls_cnt_result_exp_amt, c_spec_const_parent.ls_result_amt, 
        c_spec_const_parent.ls_result_mat_amt, c_spec_const_parent.ls_result_sub_amt, 
        c_spec_const_parent.ls_result_lab_amt, c_spec_const_parent.ls_result_equ_amt, 
        c_spec_const_parent.ls_result_exp_amt, c_spec_const_parent.ls_cost_amt, 
        c_spec_const_parent.ls_cost_mat_amt, c_spec_const_parent.ls_cost_sub_amt, 
        c_spec_const_parent.ls_cost_lab_amt, c_spec_const_parent.ls_cost_equ_amt, 
        c_spec_const_parent.ls_cost_exp_amt, c_spec_const_parent.cnt_amt, 
        c_spec_const_parent.cnt_mat_amt, c_spec_const_parent.cnt_lab_amt, 
        c_spec_const_parent.cnt_exp_amt, c_spec_const_parent.amt, 
        c_spec_const_parent.mat_amt, c_spec_const_parent.lab_amt, 
        c_spec_const_parent.exp_amt, c_spec_const_parent.equ_amt, 
        c_spec_const_parent.sub_amt, 
        z_code_dept.proj_pos,z_code_dept.proj_charge, 
        z_code_dept.chg_const_start_date,z_code_dept.chg_const_end_date 
    FROM c_spec_class_child, c_spec_const_parent, 
         y_budget_parent, z_code_dept, 
         c_spec_class_parent 
     WHERE ( c_spec_class_child.spec_no_seq = c_spec_class_parent.spec_no_seq ) 
       and ( c_spec_class_child.dept_code = z_code_dept.dept_code ) 
       and ( c_spec_const_parent.dept_code = c_spec_class_child.dept_code ) 
       and ( c_spec_const_parent.dept_code = y_budget_parent.dept_code ) 
       and ( c_spec_const_parent.spec_no_seq = y_budget_parent.spec_no_seq ) 
       and ( ( y_budget_parent.sum_code = '01' ) )
;