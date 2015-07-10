<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_progress_amt_parent_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_progress_cnt = dSet.indexOfColumn("progress_cnt");
   	int idx_request_date = dSet.indexOfColumn("request_date");
   	int idx_request_amt = dSet.indexOfColumn("request_amt");
   	int idx_request_vat = dSet.indexOfColumn("request_vat");
   	int idx_bigo = dSet.indexOfColumn("bigo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_progress_amt_parent ( dept_code," + 
                    "progress_cnt," + 
                    "request_date," + 
                    "request_amt," + 
                    "request_vat," + 
                    "bigo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      gpstatement.bindColumn(3, idx_request_date);
      gpstatement.bindColumn(4, idx_request_amt);
      gpstatement.bindColumn(5, idx_request_vat);
      gpstatement.bindColumn(6, idx_bigo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_progress_amt_parent set " + 
                            "dept_code=?,  " + 
                            "progress_cnt=?,  " + 
                            "request_date=?,  " + 
                            "request_amt=?,  " + 
                            "request_vat=?,  " + 
                            "bigo=?  where dept_code=? and progress_cnt=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      gpstatement.bindColumn(3, idx_request_date);
      gpstatement.bindColumn(4, idx_request_amt);
      gpstatement.bindColumn(5, idx_request_vat);
      gpstatement.bindColumn(6, idx_bigo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_progress_cnt);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_progress_amt_parent where dept_code=? and progress_cnt=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>