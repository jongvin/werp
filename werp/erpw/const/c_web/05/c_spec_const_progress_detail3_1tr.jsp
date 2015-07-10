<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_spec_const_progress_detail3_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_cnt_result_qty = dSet.indexOfColumn("cnt_result_qty");
   	int idx_cnt_result_rate = dSet.indexOfColumn("cnt_result_rate");
   	int idx_cnt_result_amt = dSet.indexOfColumn("cnt_result_amt");
   	int idx_result_qty = dSet.indexOfColumn("result_qty");
   	int idx_result_rate = dSet.indexOfColumn("result_rate");
   	int idx_result_amt = dSet.indexOfColumn("result_amt");
   	int idx_pre_result_amt = dSet.indexOfColumn("pre_result_amt");
   	int idx_sup_qty = dSet.indexOfColumn("sup_qty");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_cost_qty = dSet.indexOfColumn("cost_qty");
   	int idx_cost_amt = dSet.indexOfColumn("cost_amt");
   	int idx_cost_rate = dSet.indexOfColumn("cost_rate");
   	int idx_ls_cost_qty = dSet.indexOfColumn("ls_cost_qty");
   	int idx_ls_cost_amt = dSet.indexOfColumn("ls_cost_amt");
   	int idx_ls_cost_rate = dSet.indexOfColumn("ls_cost_rate");

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
                    "cnt_result_amt," + 
                    "result_qty," + 
                    "result_rate," + 
                    "result_amt, " + 
                    "pre_result_amt,  sup_qty ,remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(5, idx_cnt_result_qty);
      gpstatement.bindColumn(6, idx_cnt_result_rate);
      gpstatement.bindColumn(7, idx_cnt_result_amt);
      gpstatement.bindColumn(8, idx_result_qty);
      gpstatement.bindColumn(9, idx_result_rate);
      gpstatement.bindColumn(10, idx_result_amt);
      gpstatement.bindColumn(11, idx_pre_result_amt);
      gpstatement.bindColumn(12, idx_sup_qty);
      gpstatement.bindColumn(13, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update c_spec_const_detail set " + 
  /*                          "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "cnt_result_qty=?,  " + 
                            "cnt_result_rate=?,  " + 
                            "cnt_result_amt=?,  " + 
                            "result_qty=?,  " + 
                            "result_rate=?,  " + 
                            "result_amt=?,  " + 
								    "pre_result_amt=?, "+ 
									 "sup_qty=?, "+
	                         "remark=? , " +*/
	 								 "cost_qty=?," +
									 "cost_amt=?" +
//									 "cost_rate=?" + 
//									 "ls_cost_qty=?," +
//									 "ls_cost_amt=?," + 
//									 "ls_cost_rate=?" + 
                            " where (dept_code=? and yymm=? and spec_no_seq=? and spec_unq_num=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
/*      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_spec_unq_num);
      gpstatement.bindColumn(1, idx_cnt_result_qty);
      gpstatement.bindColumn(2, idx_cnt_result_rate);
      gpstatement.bindColumn(3, idx_cnt_result_amt);
      gpstatement.bindColumn(4, idx_result_qty);
      gpstatement.bindColumn(5, idx_result_rate);
      gpstatement.bindColumn(6, idx_result_amt);
      gpstatement.bindColumn(7, idx_pre_result_amt);
      gpstatement.bindColumn(8, idx_sup_qty);
      gpstatement.bindColumn(9, idx_remark); */
		gpstatement.bindColumn(1, idx_cost_qty);
      gpstatement.bindColumn(2, idx_cost_amt);
//	   gpstatement.bindColumn(3, idx_cost_rate);
/*		gpstatement.bindColumn(1, idx_ls_cost_qty);
      gpstatement.bindColumn(2, idx_ls_cost_amt);
	   gpstatement.bindColumn(1, idx_ls_cost_rate); */
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_yymm);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from c_spec_const_detail where (dept_code=? and yymm=? and spec_no_seq=? and spec_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
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