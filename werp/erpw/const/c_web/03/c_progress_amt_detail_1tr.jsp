<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_progress_amt_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_progress_cnt = dSet.indexOfColumn("progress_cnt");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_accept_date = dSet.indexOfColumn("accept_date");
   	int idx_accept_amt = dSet.indexOfColumn("accept_amt");
   	int idx_accept_vat = dSet.indexOfColumn("accept_vat");
   	int idx_bigo = dSet.indexOfColumn("bigo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_progress_amt_detail ( dept_code," + 
                    "progress_cnt," + 
                    "no_seq," + 
                    "accept_date," + 
                    "accept_amt," + 
                    "accept_vat," + 
                    "bigo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_accept_date);
      gpstatement.bindColumn(5, idx_accept_amt);
      gpstatement.bindColumn(6, idx_accept_vat);
      gpstatement.bindColumn(7, idx_bigo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_progress_amt_detail set " + 
                            "dept_code=?,  " + 
                            "progress_cnt=?,  " + 
                            "no_seq=?,  " + 
                            "accept_date=?,  " + 
                            "accept_amt=?,  " + 
                            "accept_vat=?,  " + 
                            "bigo=?  where dept_code=? and progress_cnt=? and no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_accept_date);
      gpstatement.bindColumn(5, idx_accept_amt);
      gpstatement.bindColumn(6, idx_accept_vat);
      gpstatement.bindColumn(7, idx_bigo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_progress_cnt);
      gpstatement.bindColumn(10, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_progress_amt_detail where dept_code=? and progress_cnt=? and no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_progress_cnt);
      gpstatement.bindColumn(3, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>