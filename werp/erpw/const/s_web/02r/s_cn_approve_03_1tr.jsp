<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_cn_approve_03_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_rep_name1 = dSet.indexOfColumn("rep_name1");
   	int idx_ctrl_amt = dSet.indexOfColumn("ctrl_amt");
   	int idx_rate = dSet.indexOfColumn("rate");
   	int idx_long_name = dSet.indexOfColumn("long_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CN_APPROVE_03 ( unq_num," + 
                    "no_seq," + 
                    "sbcr_name," + 
                    "rep_name1," + 
                    "ctrl_amt," + 
                    "rate," + 
                    "long_name )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_rep_name1);
      gpstatement.bindColumn(5, idx_ctrl_amt);
      gpstatement.bindColumn(6, idx_rate);
      gpstatement.bindColumn(7, idx_long_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_cn_approve_03 set " + 
                            "unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "sbcr_name=?,  " + 
                            "rep_name1=?,  " + 
                            "ctrl_amt=?,  " + 
                            "rate=?,  " + 
                            "long_name=?  where unq_num=? and no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_rep_name1);
      gpstatement.bindColumn(5, idx_ctrl_amt);
      gpstatement.bindColumn(6, idx_rate);
      gpstatement.bindColumn(7, idx_long_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_unq_num);
      gpstatement.bindColumn(9, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_cn_approve_03 where unq_num=? no_seq=?"; 
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