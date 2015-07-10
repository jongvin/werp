<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_spec_sum_code_plan_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_cnt_plan_amt = dSet.indexOfColumn("cnt_plan_amt");
   	int idx_plan_amt = dSet.indexOfColumn("plan_amt");
   	int idx_ls_cnt_plan_amt = dSet.indexOfColumn("ls_cnt_plan_amt");
   	int idx_ls_plan_amt = dSet.indexOfColumn("ls_plan_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_spec_sum_code_plan ( dept_code," + 
                    "yymm," + 
                    "spec_no_seq," + 
                    "cnt_plan_amt," + 
                    "plan_amt,    " +
                    "ls_cnt_plan_amt,      " + 
                    "ls_plan_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ,:6, :7) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_cnt_plan_amt);
      gpstatement.bindColumn(5, idx_plan_amt);
      gpstatement.bindColumn(6, idx_ls_cnt_plan_amt);
      gpstatement.bindColumn(7, idx_ls_plan_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_sum_code_plan set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "spec_no_seq=?,  " + 
                            "cnt_plan_amt=?,  " + 
                            "plan_amt=?, " + 
                            "ls_cnt_plan_amt=?, " + 
                            "ls_plan_amt=? " + 
                            "  where (dept_code=? and yymm=? and spec_no_seq=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_cnt_plan_amt);
      gpstatement.bindColumn(5, idx_plan_amt);
      gpstatement.bindColumn(6, idx_ls_cnt_plan_amt);
      gpstatement.bindColumn(7, idx_ls_plan_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_yymm);
      gpstatement.bindColumn(10, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_sum_code_plan where (dept_code=? and yymm=? and spec_no_seq=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>