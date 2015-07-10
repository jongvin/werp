<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_02_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_rep_name1 = dSet.indexOfColumn("rep_name1");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_rate = dSet.indexOfColumn("rate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL_02 ( unq_num," + 
                    "no_seq," + 
                    "sbcr_name," + 
                    "rep_name1," + 
                    "amt," + 
                    "rate )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_rep_name1);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_rate);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval_02 set " + 
                            "unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "sbcr_name=?,  " + 
                            "rep_name1=?,  " + 
                            "amt=?,  " + 
                            "rate=?  where unq_num=? and no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_rep_name1);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_rate);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_unq_num);
      gpstatement.bindColumn(8, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_approval_02 where unq_num=? and no_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>