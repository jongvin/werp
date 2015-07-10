<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_chg_progress_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
	int idx_chg_class = dSet.indexOfColumn("chg_class");
	int idx_chg_title = dSet.indexOfColumn("chg_title");
	int idx_approve_class = dSet.indexOfColumn("approve_class");
	int idx_work_dt = dSet.indexOfColumn("work_dt");
	int idx_chg_const_start_date = dSet.indexOfColumn("chg_const_start_date");
   	int idx_chg_const_end_date = dSet.indexOfColumn("chg_const_end_date");
	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
	int idx_amt = dSet.indexOfColumn("amt");
	int idx_remark = dSet.indexOfColumn("remark");
	int idx_app_yn = dSet.indexOfColumn("app_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_chg_progress ( dept_code," +
			        "chg_seq,"+
			        "chg_no_seq," + 
					"chg_degree,"+
					"chg_class,"+
					"chg_title,"+
					"approve_class,"+
					"work_dt,"+
                    "chg_const_start_date," + 
                    "chg_const_end_date,"+
					"remark,"+
					" app_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_seq);
      gpstatement.bindColumn(3, idx_chg_no_seq);
	  gpstatement.bindColumn(4, idx_chg_degree);
	  gpstatement.bindColumn(5, idx_chg_class);
	  gpstatement.bindColumn(6, idx_chg_title);
	  gpstatement.bindColumn(7, idx_approve_class);
	  gpstatement.bindColumn(8, idx_work_dt);
	  gpstatement.bindColumn(9, idx_chg_const_start_date);
      gpstatement.bindColumn(10, idx_chg_const_end_date);
	  gpstatement.bindColumn(11, idx_remark);
	  gpstatement.bindColumn(12, idx_app_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_chg_progress set " + 
                            "approve_class=?,  " + 
                            "work_dt=?,  " + 
                            "remark=?,  " + 
							" app_yn=? "+
                            " where dept_code=? and chg_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_approve_class);
      gpstatement.bindColumn(2, idx_work_dt);
      gpstatement.bindColumn(3, idx_remark);
	  gpstatement.bindColumn(4, idx_app_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_chg_progress where dept_code=? and chg_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>