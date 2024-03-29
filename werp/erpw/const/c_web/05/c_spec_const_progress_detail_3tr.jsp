<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_spec_const_progress_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_cnt_result_qty = dSet.indexOfColumn("cnt_result_qty");
   	int idx_cnt_result_rate = dSet.indexOfColumn("cnt_result_rate");
   	int idx_cnt_result_mat_amt = dSet.indexOfColumn("cnt_result_mat_amt");
   	int idx_cnt_result_lab_amt = dSet.indexOfColumn("cnt_result_lab_amt");
   	int idx_cnt_result_exp_amt = dSet.indexOfColumn("cnt_result_exp_amt");
   	int idx_cnt_result_amt = dSet.indexOfColumn("cnt_result_amt");
   	int idx_result_qty = dSet.indexOfColumn("result_qty");
   	int idx_result_rate = dSet.indexOfColumn("result_rate");
   	int idx_cost_qty = dSet.indexOfColumn("cost_qty1");
   	int idx_cost_amt = dSet.indexOfColumn("cost_amt1");
   	int idx_ls_cost_qty = dSet.indexOfColumn("ls_cost_qty1");
   	int idx_ls_cost_amt = dSet.indexOfColumn("ls_cost_amt1");
   	int idx_result_mat_amt = dSet.indexOfColumn("result_mat_amt");
   	int idx_result_lab_amt = dSet.indexOfColumn("result_lab_amt");
   	int idx_result_exp_amt = dSet.indexOfColumn("result_exp_amt");
   	int idx_result_equ_amt = dSet.indexOfColumn("result_equ_amt");
   	int idx_result_sub_amt = dSet.indexOfColumn("result_sub_amt");
   	int idx_result_amt = dSet.indexOfColumn("result_amt");
   	int idx_pre_result_amt = dSet.indexOfColumn("pre_result_amt");
   	int idx_sup_qty = dSet.indexOfColumn("sup_qty");
   	int idx_sup_unit_amt = dSet.indexOfColumn("sup_unit_amt");
   	int idx_sup_unit_fix = dSet.indexOfColumn("sup_unit_fix");
   	int idx_mat_unit_fix = dSet.indexOfColumn("mat_unit_fix");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO C_SPEC_CONST_DETAIL ( dept_code," + 
                    "yymm," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "cnt_result_qty," + 
                    "cnt_result_rate," + 
                    "cnt_result_mat_amt," + 
                    "cnt_result_lab_amt," + 
                    "cnt_result_exp_amt," + 
                    "cnt_result_amt," + 
                    "result_qty," + 
                    "result_rate," + 
                    "result_mat_amt," + 
                    "result_lab_amt," + 
                    "result_exp_amt," + 
                    "result_equ_amt," + 
                    "result_sub_amt," + 
                    "result_amt, " + 
                    "cost_qty, " + 
                    "cost_amt, " + 
                    "ls_cost_qty, " + 
                    "ls_cost_amt, " + 
		"pre_result_amt,sup_qty,sup_unit_amt,sup_unit_fix,mat_unit_fix,remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24 ,:25 ,:26 ,:27 , :28) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_cnt_result_qty);
      gpstatement.bindColumn(6, idx_cnt_result_rate);
      gpstatement.bindColumn(7, idx_cnt_result_mat_amt);
      gpstatement.bindColumn(8, idx_cnt_result_lab_amt);
      gpstatement.bindColumn(9, idx_cnt_result_exp_amt);
      gpstatement.bindColumn(10, idx_cnt_result_amt);
      gpstatement.bindColumn(11, idx_result_qty);
      gpstatement.bindColumn(12, idx_result_rate);
      gpstatement.bindColumn(13, idx_cost_qty);
      gpstatement.bindColumn(14, idx_cost_amt);
      gpstatement.bindColumn(15, idx_ls_cost_qty);
      gpstatement.bindColumn(16, idx_ls_cost_amt);
      gpstatement.bindColumn(17, idx_result_mat_amt);
      gpstatement.bindColumn(18, idx_result_lab_amt);
      gpstatement.bindColumn(19, idx_result_exp_amt);
      gpstatement.bindColumn(20, idx_result_equ_amt);
      gpstatement.bindColumn(21, idx_result_sub_amt);
      gpstatement.bindColumn(22, idx_result_amt);
      gpstatement.bindColumn(23, idx_pre_result_amt);
      gpstatement.bindColumn(24, idx_sup_qty);
      gpstatement.bindColumn(25, idx_sup_unit_amt);
      gpstatement.bindColumn(26, idx_sup_unit_fix);
      gpstatement.bindColumn(27, idx_mat_unit_fix);
      gpstatement.bindColumn(28, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_const_detail set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "cnt_result_qty=?,  " + 
                            "cnt_result_rate=?,  " + 
                            "cnt_result_mat_amt=?,  " + 
                            "cnt_result_lab_amt=?,  " + 
                            "cnt_result_exp_amt=?,  " + 
                            "cnt_result_amt=?,  " + 
                            "result_qty=?,  " + 
                            "result_rate=?,  " + 
                            "result_mat_amt=?,  " + 
                            "result_lab_amt=?,  " + 
                            "result_exp_amt=?,  " + 
                            "result_equ_amt=?,  " + 
                            "result_sub_amt=?,  " + 
                            "result_amt=?,  " + 
									 "cost_qty=?, " +
	                         "cost_amt=?, " +
									 "ls_cost_qty=?, " +
	                         "ls_cost_amt=?, " +
								 "pre_result_amt=?,sup_qty=?,sup_unit_amt=?,sup_unit_fix=?,mat_unit_fix=?,remark=?  " + 
                            " where (dept_code=? and yymm=? and spec_no_seq=? and spec_unq_num=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_cnt_result_qty);
      gpstatement.bindColumn(6, idx_cnt_result_rate);
      gpstatement.bindColumn(7, idx_cnt_result_mat_amt);
      gpstatement.bindColumn(8, idx_cnt_result_lab_amt);
      gpstatement.bindColumn(9, idx_cnt_result_exp_amt);
      gpstatement.bindColumn(10, idx_cnt_result_amt);
      gpstatement.bindColumn(11, idx_result_qty);
      gpstatement.bindColumn(12, idx_result_rate);
      gpstatement.bindColumn(13, idx_cost_qty);
      gpstatement.bindColumn(14, idx_cost_amt);
      gpstatement.bindColumn(15, idx_ls_cost_qty);
      gpstatement.bindColumn(16, idx_ls_cost_amt);
      gpstatement.bindColumn(17, idx_result_mat_amt);
      gpstatement.bindColumn(18, idx_result_lab_amt);
      gpstatement.bindColumn(19, idx_result_exp_amt);
      gpstatement.bindColumn(20, idx_result_equ_amt);
      gpstatement.bindColumn(21, idx_result_sub_amt);
      gpstatement.bindColumn(22, idx_result_amt);
      gpstatement.bindColumn(23, idx_pre_result_amt);
      gpstatement.bindColumn(24, idx_sup_qty);
      gpstatement.bindColumn(25, idx_sup_unit_amt);
      gpstatement.bindColumn(26, idx_sup_unit_fix);
      gpstatement.bindColumn(27, idx_mat_unit_fix);
      gpstatement.bindColumn(28, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(29, idx_dept_code);
      gpstatement.bindColumn(30, idx_yymm);
      gpstatement.bindColumn(31, idx_spec_no_seq);
      gpstatement.bindColumn(32, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_const_detail where (dept_code=? and yymm=? and spec_no_seq=? and spec_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>