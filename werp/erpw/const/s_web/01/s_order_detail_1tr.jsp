<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_order_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_detail_unq_num = dSet.indexOfColumn("detail_unq_num");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_res_class = dSet.indexOfColumn("res_class");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unit = dSet.indexOfColumn("unit");
   	int idx_cnt_qty = dSet.indexOfColumn("cnt_qty");
   	int idx_cnt_price = dSet.indexOfColumn("cnt_price");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_exe_qty = dSet.indexOfColumn("exe_qty");
   	int idx_exe_price = dSet.indexOfColumn("exe_price");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_sub_qty = dSet.indexOfColumn("sub_qty");
   	int idx_sub_price = dSet.indexOfColumn("sub_price");
   	int idx_sub_amt = dSet.indexOfColumn("sub_amt");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_lab_class = dSet.indexOfColumn("lab_class");
   	int idx_mat_price = dSet.indexOfColumn("mat_price");
   	int idx_mat_amt = dSet.indexOfColumn("mat_amt");
   	int idx_lab_price = dSet.indexOfColumn("lab_price");
   	int idx_lab_amt = dSet.indexOfColumn("lab_amt");
   	int idx_exp_price = dSet.indexOfColumn("exp_price");
   	int idx_exp_amt = dSet.indexOfColumn("exp_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_order_detail ( dept_code," + 
                    "order_number," + 
                    "spec_no_seq," + 
                    "detail_unq_num," + 
                    "seq," + 
                    "res_class," + 
                    "spec_unq_num," + 
                    "name," + 
                    "ssize," + 
                    "unit," + 
                    "cnt_qty," + 
                    "cnt_price," + 
                    "cnt_amt," + 
                    "exe_qty," + 
                    "exe_price," + 
                    "exe_amt," + 
                    "sub_qty," + 
                    "sub_price," + 
                    "sub_amt," + 
                    "note," + 
                    "lab_class," + 
                    "mat_price," + 
                    "mat_amt," + 
                    "lab_price," + 
                    "lab_amt," + 
                    "exp_price," + 
                    "exp_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_detail_unq_num);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_res_class);
      gpstatement.bindColumn(7, idx_spec_unq_num);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unit);
      gpstatement.bindColumn(11, idx_cnt_qty);
      gpstatement.bindColumn(12, idx_cnt_price);
      gpstatement.bindColumn(13, idx_cnt_amt);
      gpstatement.bindColumn(14, idx_exe_qty);
      gpstatement.bindColumn(15, idx_exe_price);
      gpstatement.bindColumn(16, idx_exe_amt);
      gpstatement.bindColumn(17, idx_sub_qty);
      gpstatement.bindColumn(18, idx_sub_price);
      gpstatement.bindColumn(19, idx_sub_amt);
      gpstatement.bindColumn(20, idx_note);
      gpstatement.bindColumn(21, idx_lab_class);
      gpstatement.bindColumn(22, idx_mat_price);
      gpstatement.bindColumn(23, idx_mat_amt);
      gpstatement.bindColumn(24, idx_lab_price);
      gpstatement.bindColumn(25, idx_lab_amt);
      gpstatement.bindColumn(26, idx_exp_price);
      gpstatement.bindColumn(27, idx_exp_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_order_detail set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "spec_no_seq=?,  " + 
                            "detail_unq_num=?,  " + 
                            "seq=?,  " + 
                            "res_class=?,  " + 
                            "spec_unq_num=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unit=?,  " + 
                            "cnt_qty=?,  " + 
                            "cnt_price=?,  " + 
                            "cnt_amt=?,  " + 
                            "exe_qty=?,  " + 
                            "exe_price=?,  " + 
                            "exe_amt=?,  " + 
                            "sub_qty=?,  " + 
                            "sub_price=?,  " + 
                            "sub_amt=?,  " + 
                            "note=?,  " + 
                            "lab_class=?,  " + 
                            "mat_price=?,  " + 
                            "mat_amt=?,  " + 
                            "lab_price=?,  " + 
                            "lab_amt=?,  " + 
                            "exp_price=?,  " + 
                            "exp_amt=?  where (dept_code=? and order_number=? and spec_no_seq=? and detail_unq_num=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_detail_unq_num);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_res_class);
      gpstatement.bindColumn(7, idx_spec_unq_num);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unit);
      gpstatement.bindColumn(11, idx_cnt_qty);
      gpstatement.bindColumn(12, idx_cnt_price);
      gpstatement.bindColumn(13, idx_cnt_amt);
      gpstatement.bindColumn(14, idx_exe_qty);
      gpstatement.bindColumn(15, idx_exe_price);
      gpstatement.bindColumn(16, idx_exe_amt);
      gpstatement.bindColumn(17, idx_sub_qty);
      gpstatement.bindColumn(18, idx_sub_price);
      gpstatement.bindColumn(19, idx_sub_amt);
      gpstatement.bindColumn(20, idx_note);
      gpstatement.bindColumn(21, idx_lab_class);
      gpstatement.bindColumn(22, idx_mat_price);
      gpstatement.bindColumn(23, idx_mat_amt);
      gpstatement.bindColumn(24, idx_lab_price);
      gpstatement.bindColumn(25, idx_lab_amt);
      gpstatement.bindColumn(26, idx_exp_price);
      gpstatement.bindColumn(27, idx_exp_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(28, idx_dept_code);
      gpstatement.bindColumn(29, idx_order_number);
      gpstatement.bindColumn(30, idx_spec_no_seq);
      gpstatement.bindColumn(31, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_order_detail where (dept_code=? and order_number=? and spec_no_seq=? and detail_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>