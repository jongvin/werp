<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_progress_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_plan_mm_per = dSet.indexOfColumn("plan_mm_per");
   	int idx_plan_mm_amt = dSet.indexOfColumn("plan_mm_amt");
   	int idx_real_mm_per = dSet.indexOfColumn("real_mm_per");
   	int idx_real_mm_amt = dSet.indexOfColumn("real_mm_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_progress_detail ( dept_code," + 
                    "chg_no_seq," + 
                    "wbs_code," + 
                    "year," + 
                    "plan_mm_per," + 
                    "plan_mm_amt," + 
                    "real_mm_per," + 
                    "real_mm_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      gpstatement.bindColumn(4, idx_year);
      gpstatement.bindColumn(5, idx_plan_mm_per);
      gpstatement.bindColumn(6, idx_plan_mm_amt);
      gpstatement.bindColumn(7, idx_real_mm_per);
      gpstatement.bindColumn(8, idx_real_mm_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_progress_detail set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "wbs_code=?,  " + 
                            "year=?,  " + 
                            "plan_mm_per=?,  " + 
                            "plan_mm_amt=?,  " + 
                            "real_mm_per=?,  " + 
                            "real_mm_amt=?  where dept_code=? and chg_no_seq=? and wbs_code=? and year=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      gpstatement.bindColumn(4, idx_year);
      gpstatement.bindColumn(5, idx_plan_mm_per);
      gpstatement.bindColumn(6, idx_plan_mm_amt);
      gpstatement.bindColumn(7, idx_real_mm_per);
      gpstatement.bindColumn(8, idx_real_mm_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_chg_no_seq);
      gpstatement.bindColumn(11, idx_wbs_code);
      gpstatement.bindColumn(12, idx_year);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_progress_detail  where dept_code=? and chg_no_seq=? and wbs_code=? and year=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_wbs_code);
      gpstatement.bindColumn(4, idx_year);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>