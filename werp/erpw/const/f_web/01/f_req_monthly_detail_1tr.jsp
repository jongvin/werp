<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_req_monthly_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_req_unq_num = dSet.indexOfColumn("req_unq_num");
   	int idx_detail_seq = dSet.indexOfColumn("detail_seq");
	int idx_dept_code = dSet.indexOfColumn("dept_code");
	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
	int idx_req_cash = dSet.indexOfColumn("req_cash");
	int idx_req_card = dSet.indexOfColumn("req_card");
	int idx_req_unp = dSet.indexOfColumn("req_unp");
	int idx_plan_amt = dSet.indexOfColumn("plan_amt");
	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
	int idx_add_cash = dSet.indexOfColumn("add_cash");
	int idx_add_card = dSet.indexOfColumn("add_card");
	int idx_add_unp = dSet.indexOfColumn("add_unp");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO f_req_detail ( req_unq_num," + 
                    "detail_seq," + 
                    "dept_code," + 
                    "chg_no_seq," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "req_cash," + 
                    "req_card," + 
                    "req_unp," + 
                    "plan_amt," + 
                    "exe_amt," + 
                    "add_cash," + 
                    "add_card," + 
                    "add_unp)      ";
      sSql = sSql + " VALUES ( :1," + 
										"(select nvl(max(detail_seq),0)+1 from f_req_detail where req_unq_num = :2),"+
										":3,"+
										"(select max(chg_no_seq) from y_chg_degree where approve_class = 4 and dept_code = :4), "+
										":5, :6, :7, :8, :9, :10, :11, :12, :13, :14) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_req_unq_num);
      gpstatement.bindColumn(2, idx_req_unq_num);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_spec_unq_num);
      gpstatement.bindColumn(7, idx_req_cash);
      gpstatement.bindColumn(8, idx_req_card);
      gpstatement.bindColumn(9, idx_req_unp);
      gpstatement.bindColumn(10, idx_plan_amt);
      gpstatement.bindColumn(11, idx_exe_amt);
      gpstatement.bindColumn(12, idx_add_cash);
      gpstatement.bindColumn(13, idx_add_card);
      gpstatement.bindColumn(14, idx_add_unp);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_req_detail set " + 
					" req_unq_num=?," + 
                    " detail_seq=?," + 
                    " dept_code=?," + 
                    " chg_no_seq=?," + 
                    " spec_no_seq=?," + 
                    " spec_unq_num=?," + 
                    " req_cash=?," + 
                    " req_card=?," + 
                    " req_unp=?," + 
                    " plan_amt=?," + 
                    " exe_amt=?," + 
                    " add_cash=?," + 
                    " add_card=?," + 
                    " add_unp=?"+
                            "  where req_unq_num=?  " + 
                            " and detail_seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_req_unq_num);
      gpstatement.bindColumn(2, idx_detail_seq);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_chg_no_seq);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_spec_unq_num);
      gpstatement.bindColumn(7, idx_req_cash);
      gpstatement.bindColumn(8, idx_req_card);
      gpstatement.bindColumn(9, idx_req_unp);
      gpstatement.bindColumn(10, idx_plan_amt);
      gpstatement.bindColumn(11, idx_exe_amt);
      gpstatement.bindColumn(12, idx_add_cash);
      gpstatement.bindColumn(13, idx_add_card);
      gpstatement.bindColumn(14, idx_add_unp);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_req_unq_num);
      gpstatement.bindColumn(16, idx_detail_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
       String sSql = "delete from f_req_detail where req_unq_num=? and detail_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_req_unq_num);
      gpstatement.bindColumn(2, idx_detail_seq);		
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>