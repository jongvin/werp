<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_chg_budget_child_1tr");
      gpstatement.gp_dataset = dSet;
   	
	
	
	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_detail_code = dSet.indexOfColumn("detail_code");
   	int idx_res_class = dSet.indexOfColumn("res_class");
   	int idx_mat_code = dSet.indexOfColumn("mat_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_cnt_qty = dSet.indexOfColumn("cnt_qty");
   	int idx_cnt_mat_price = dSet.indexOfColumn("cnt_mat_price");
   	int idx_cnt_mat_amt = dSet.indexOfColumn("cnt_mat_amt");
   	int idx_cnt_lab_price = dSet.indexOfColumn("cnt_lab_price");
   	int idx_cnt_lab_amt = dSet.indexOfColumn("cnt_lab_amt");
   	int idx_cnt_exp_price = dSet.indexOfColumn("cnt_exp_price");
   	int idx_cnt_exp_amt = dSet.indexOfColumn("cnt_exp_amt");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_mat_price = dSet.indexOfColumn("mat_price");
   	int idx_mat_amt = dSet.indexOfColumn("mat_amt");
   	int idx_lab_price = dSet.indexOfColumn("lab_price");
   	int idx_lab_amt = dSet.indexOfColumn("lab_amt");
   	int idx_exp_price = dSet.indexOfColumn("exp_price");
   	int idx_exp_amt = dSet.indexOfColumn("exp_amt");
   	int idx_equ_price = dSet.indexOfColumn("equ_price");
   	int idx_equ_amt = dSet.indexOfColumn("equ_amt");
   	int idx_sub_price = dSet.indexOfColumn("sub_price");
   	int idx_sub_amt = dSet.indexOfColumn("sub_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_cnt_price  = dSet.indexOfColumn("cnt_price");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_price = dSet.indexOfColumn("price");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_approve_yn = dSet.indexOfColumn("approve_yn");
   	int idx_outside_yn = dSet.indexOfColumn("outside_yn");
   	int idx_name_key = dSet.indexOfColumn("name_key");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_chg_budget_detail ( dept_code," + 
                    "chg_no_seq," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "no_seq," + 
                    "detail_code," + 
                    "res_class," + 
                    "mat_code," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "cnt_qty," + 
                    "cnt_mat_price," + 
                    "cnt_mat_amt," + 
                    "cnt_lab_price," + 
                    "cnt_lab_amt," + 
                    "cnt_exp_price," + 
                    "cnt_exp_amt," + 
                    "qty," + 
                    "mat_price," + 
                    "mat_amt," + 
                    "lab_price," + 
                    "lab_amt," + 
                    "exp_price," + 
                    "exp_amt," + 
                    "equ_price," + 
                    "equ_amt," + 
                    "sub_price," + 
                    "sub_amt," + 
                    "remark," + 
                    "input_dt," + 
                    "input_name, " + 
                    "cnt_price,   " +
                    "cnt_amt,     " +
                    "price,      " +
                    "amt,       "  + 
                    "approve_yn, name_key,outside_yn )     ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, TO_DATE(:31,'YYYY.MM.DD'), :32, :33, :34, :35, :36, :37, :38, :39 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_detail_code);
      gpstatement.bindColumn(7, idx_res_class);
      gpstatement.bindColumn(8, idx_mat_code);
      gpstatement.bindColumn(9, idx_name);
      gpstatement.bindColumn(10, idx_ssize);
      gpstatement.bindColumn(11, idx_unit);
      gpstatement.bindColumn(12, idx_cnt_qty);
      gpstatement.bindColumn(13, idx_cnt_mat_price);
      gpstatement.bindColumn(14, idx_cnt_mat_amt);
      gpstatement.bindColumn(15, idx_cnt_lab_price);
      gpstatement.bindColumn(16, idx_cnt_lab_amt);
      gpstatement.bindColumn(17, idx_cnt_exp_price);
      gpstatement.bindColumn(18, idx_cnt_exp_amt);
      gpstatement.bindColumn(19, idx_qty);
      gpstatement.bindColumn(20, idx_mat_price);
      gpstatement.bindColumn(21, idx_mat_amt);
      gpstatement.bindColumn(22, idx_lab_price);
      gpstatement.bindColumn(23, idx_lab_amt);
      gpstatement.bindColumn(24, idx_exp_price);
      gpstatement.bindColumn(25, idx_exp_amt);
      gpstatement.bindColumn(26, idx_equ_price);
      gpstatement.bindColumn(27, idx_equ_amt);
      gpstatement.bindColumn(28, idx_sub_price);
      gpstatement.bindColumn(29, idx_sub_amt);
      gpstatement.bindColumn(30, idx_remark);
      gpstatement.bindColumn(31, idx_input_dt);
      gpstatement.bindColumn(32, idx_input_name);
      gpstatement.bindColumn(33, idx_cnt_price);
      gpstatement.bindColumn(34, idx_cnt_amt);
      gpstatement.bindColumn(35, idx_price);
      gpstatement.bindColumn(36, idx_amt);
      gpstatement.bindColumn(37, idx_approve_yn);
      gpstatement.bindColumn(38, idx_name_key);
      gpstatement.bindColumn(39, idx_outside_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_chg_budget_detail set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "detail_code=?,  " + 
                            "res_class=?,  " + 
                            "mat_code=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "cnt_qty=?,  " + 
                            "cnt_mat_price=?,  " + 
                            "cnt_mat_amt=?,  " + 
                            "cnt_lab_price=?,  " + 
                            "cnt_lab_amt=?,  " + 
                            "cnt_exp_price=?,  " + 
                            "cnt_exp_amt=?,  " + 
                            "qty=?,  " + 
                            "mat_price=?,  " + 
                            "mat_amt=?,  " + 
                            "lab_price=?,  " + 
                            "lab_amt=?,  " + 
                            "exp_price=?,  " + 
                            "exp_amt=?,  " + 
                            "equ_price=?,  " + 
                            "equ_amt=?,  " + 
                            "sub_price=?,  " + 
                            "sub_amt=?,  " + 
                            "remark=?,  " + 
                            "input_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "input_name=?,  " + 
                            "cnt_price=?,  " + 
                            "cnt_amt=?,  " + 
                            "price=?,  " + 
                            "amt=?,  " + 
                            "approve_yn=?, name_key=?,outside_yn=?  " + 
                            "  where (dept_code=? and chg_no_seq=? and spec_no_seq=? and spec_unq_num=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_no_seq);
      gpstatement.bindColumn(6, idx_detail_code);
      gpstatement.bindColumn(7, idx_res_class);
      gpstatement.bindColumn(8, idx_mat_code);
      gpstatement.bindColumn(9, idx_name);
      gpstatement.bindColumn(10, idx_ssize);
      gpstatement.bindColumn(11, idx_unit);
      gpstatement.bindColumn(12, idx_cnt_qty);
      gpstatement.bindColumn(13, idx_cnt_mat_price);
      gpstatement.bindColumn(14, idx_cnt_mat_amt);
      gpstatement.bindColumn(15, idx_cnt_lab_price);
      gpstatement.bindColumn(16, idx_cnt_lab_amt);
      gpstatement.bindColumn(17, idx_cnt_exp_price);
      gpstatement.bindColumn(18, idx_cnt_exp_amt);
      gpstatement.bindColumn(19, idx_qty);
      gpstatement.bindColumn(20, idx_mat_price);
      gpstatement.bindColumn(21, idx_mat_amt);
      gpstatement.bindColumn(22, idx_lab_price);
      gpstatement.bindColumn(23, idx_lab_amt);
      gpstatement.bindColumn(24, idx_exp_price);
      gpstatement.bindColumn(25, idx_exp_amt);
      gpstatement.bindColumn(26, idx_equ_price);
      gpstatement.bindColumn(27, idx_equ_amt);
      gpstatement.bindColumn(28, idx_sub_price);
      gpstatement.bindColumn(29, idx_sub_amt);
      gpstatement.bindColumn(30, idx_remark);
      gpstatement.bindColumn(31, idx_input_dt);
      gpstatement.bindColumn(32, idx_input_name);
      gpstatement.bindColumn(33, idx_cnt_price);
      gpstatement.bindColumn(34, idx_cnt_amt);
      gpstatement.bindColumn(35, idx_price);
      gpstatement.bindColumn(36, idx_amt);
      gpstatement.bindColumn(37, idx_approve_yn);
      gpstatement.bindColumn(38, idx_name_key);
      gpstatement.bindColumn(39, idx_outside_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(40, idx_dept_code);
      gpstatement.bindColumn(41, idx_chg_no_seq);
      gpstatement.bindColumn(42, idx_spec_no_seq);
      gpstatement.bindColumn(43, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_chg_budget_detail where (dept_code=? and chg_no_seq=? and spec_no_seq=? and spec_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }

     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>