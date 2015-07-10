<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("t_budget_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sum_code = dSet.indexOfColumn("sum_code");
   	int idx_parent_sum_code = dSet.indexOfColumn("parent_sum_code");
   	int idx_direct_class = dSet.indexOfColumn("direct_class");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_invest_class = dSet.indexOfColumn("invest_class");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_cnt_mat_amt = dSet.indexOfColumn("cnt_mat_amt");
   	int idx_cnt_lab_amt = dSet.indexOfColumn("cnt_lab_amt");
   	int idx_cnt_exp_amt = dSet.indexOfColumn("cnt_exp_amt");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_mat_amt = dSet.indexOfColumn("mat_amt");
   	int idx_lab_amt = dSet.indexOfColumn("lab_amt");
   	int idx_exp_amt = dSet.indexOfColumn("exp_amt");
   	int idx_equ_amt = dSet.indexOfColumn("equ_amt");
   	int idx_sub_amt = dSet.indexOfColumn("sub_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO T_BUDGET_PARENT ( dept_code," + 
                    "chg_no_seq," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "sum_code," + 
                    "parent_sum_code," + 
                    "direct_class," + 
                    "wbs_code," + 
                    "llevel," + 
                    "invest_class," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "cnt_amt," + 
                    "cnt_mat_amt," + 
                    "cnt_lab_amt," + 
                    "cnt_exp_amt," + 
                    "amt," + 
                    "mat_amt," + 
                    "lab_amt," + 
                    "exp_amt," + 
                    "equ_amt," + 
                    "sub_amt," + 
                    "remark," + 
                    "input_dt" + 
                    "input_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_no_seq);
      gpstatement.bindColumn(5, idx_sum_code);
      gpstatement.bindColumn(6, idx_parent_sum_code);
      gpstatement.bindColumn(7, idx_direct_class);
      gpstatement.bindColumn(8, idx_wbs_code);
      gpstatement.bindColumn(9, idx_llevel);
      gpstatement.bindColumn(10, idx_invest_class);
      gpstatement.bindColumn(11, idx_name);
      gpstatement.bindColumn(12, idx_ssize);
      gpstatement.bindColumn(13, idx_unit);
      gpstatement.bindColumn(14, idx_cnt_amt);
      gpstatement.bindColumn(15, idx_cnt_mat_amt);
      gpstatement.bindColumn(16, idx_cnt_lab_amt);
      gpstatement.bindColumn(17, idx_cnt_exp_amt);
      gpstatement.bindColumn(18, idx_amt);
      gpstatement.bindColumn(19, idx_mat_amt);
      gpstatement.bindColumn(20, idx_lab_amt);
      gpstatement.bindColumn(21, idx_exp_amt);
      gpstatement.bindColumn(22, idx_equ_amt);
      gpstatement.bindColumn(23, idx_sub_amt);
      gpstatement.bindColumn(24, idx_remark);
      gpstatement.bindColumn(25, idx_input_dt);
      gpstatement.bindColumn(26, idx_input_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update t_budget_parent set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "sum_code=?,  " + 
                            "parent_sum_code=?,  " + 
                            "direct_class=?,  " + 
                            "wbs_code=?,  " + 
                            "llevel=?,  " + 
                            "invest_class=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "cnt_amt=?,  " + 
                            "cnt_mat_amt=?,  " + 
                            "cnt_lab_amt=?,  " + 
                            "cnt_exp_amt=?,  " + 
                            "amt=?,  " + 
                            "mat_amt=?,  " + 
                            "lab_amt=?,  " + 
                            "exp_amt=?,  " + 
                            "equ_amt=?,  " + 
                            "sub_amt=?,  " + 
                            "remark=?,  " + 
                            "input_dt=?,  " + 
                            "input_name=?  where dept_code=? " +
                            " and chg_no_seq=? " +
                            " and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_no_seq);
      gpstatement.bindColumn(5, idx_sum_code);
      gpstatement.bindColumn(6, idx_parent_sum_code);
      gpstatement.bindColumn(7, idx_direct_class);
      gpstatement.bindColumn(8, idx_wbs_code);
      gpstatement.bindColumn(9, idx_llevel);
      gpstatement.bindColumn(10, idx_invest_class);
      gpstatement.bindColumn(11, idx_name);
      gpstatement.bindColumn(12, idx_ssize);
      gpstatement.bindColumn(13, idx_unit);
      gpstatement.bindColumn(14, idx_cnt_amt);
      gpstatement.bindColumn(15, idx_cnt_mat_amt);
      gpstatement.bindColumn(16, idx_cnt_lab_amt);
      gpstatement.bindColumn(17, idx_cnt_exp_amt);
      gpstatement.bindColumn(18, idx_amt);
      gpstatement.bindColumn(19, idx_mat_amt);
      gpstatement.bindColumn(20, idx_lab_amt);
      gpstatement.bindColumn(21, idx_exp_amt);
      gpstatement.bindColumn(22, idx_equ_amt);
      gpstatement.bindColumn(23, idx_sub_amt);
      gpstatement.bindColumn(24, idx_remark);
      gpstatement.bindColumn(25, idx_input_dt);
      gpstatement.bindColumn(26, idx_input_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(27, idx_dept_code);
      gpstatement.bindColumn(28, idx_chg_no_seq);
      gpstatement.bindColumn(29, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from t_budget_parent where dept_code=? " +
                            " and chg_no_seq=? " +
                            " and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>