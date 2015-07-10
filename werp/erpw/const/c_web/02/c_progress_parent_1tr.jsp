<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_progress_parent_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_invest_class = dSet.indexOfColumn("invest_class");
   	int idx_plan_per = dSet.indexOfColumn("plan_per");
   	int idx_plan_amt = dSet.indexOfColumn("plan_amt");
   	int idx_real_per = dSet.indexOfColumn("real_per");
   	int idx_real_amt = dSet.indexOfColumn("real_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_progress_parent ( dept_code," + 
                    "chg_no_seq," + 
                    "wbs_code," + 
                    "seq," + 
                    "invest_class," + 
                    "plan_per," + 
                    "plan_amt," + 
                    "real_per," + 
                    "real_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_invest_class);
      gpstatement.bindColumn(6, idx_plan_per);
      gpstatement.bindColumn(7, idx_plan_amt);
      gpstatement.bindColumn(8, idx_real_per);
      gpstatement.bindColumn(9, idx_real_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_progress_parent set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "wbs_code=?,  " + 
                            "seq=?,  " + 
                            "invest_class=?,  " + 
                            "plan_per=?,  " + 
                            "plan_amt=?,  " + 
                            "real_per=?,  " + 
                            "real_amt=?  where dept_code=? and chg_no_seq=? and wbs_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_invest_class);
      gpstatement.bindColumn(6, idx_plan_per);
      gpstatement.bindColumn(7, idx_plan_amt);
      gpstatement.bindColumn(8, idx_real_per);
      gpstatement.bindColumn(9, idx_real_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_chg_no_seq);
      gpstatement.bindColumn(12, idx_wbs_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_progress_parent where dept_code=? and chg_no_seq=? and wbs_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>