<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_plan_result_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_key_yymmdd = dSet.indexOfColumn("key_yymmdd");
   	int idx_k_yymmdd = dSet.indexOfColumn("k_yymmdd");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_status = dSet.indexOfColumn("status");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_make_dt = dSet.indexOfColumn("make_dt");
   	int idx_user_no = dSet.indexOfColumn("user_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_test_result ( yymm," + 
                    "dept_code," + 
                    "status," + 
                    "remark," + 
                    "make_dt," + 
                    "user_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key_yymmdd);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_status);
      gpstatement.bindColumn(4, idx_remark);
      gpstatement.bindColumn(5, idx_make_dt);
      gpstatement.bindColumn(6, idx_user_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_test_result set " + 
                            "yymm=?,  " + 
                            "dept_code=?,  " + 
                            "status=? , " + 
                            "remark=? , " + 
                            "make_dt=?,  " + 
                            "user_no=? " + 
									 " where yymm=? and dept_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key_yymmdd);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_status);
      gpstatement.bindColumn(4, idx_remark);
      gpstatement.bindColumn(5, idx_make_dt);
      gpstatement.bindColumn(6, idx_user_no);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_k_yymmdd);
      gpstatement.bindColumn(8, idx_dept_code);
      stmt.executeUpdate();
      stmt.close(); 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_test_result where yymm=? and dept_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_k_yymmdd);
      gpstatement.bindColumn(2, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>