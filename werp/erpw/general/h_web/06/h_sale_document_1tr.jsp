<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_sale_document_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_issue_date = dSet.indexOfColumn("issue_date");
   	int idx_issue_document = dSet.indexOfColumn("issue_document");
   	int idx_issue_no = dSet.indexOfColumn("issue_no");
   	int idx_issuer = dSet.indexOfColumn("issuer");
   	int idx_issue_reason = dSet.indexOfColumn("issue_reason");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_key_1 = dSet.indexOfColumn("key_1");
   	int idx_key_2 = dSet.indexOfColumn("key_2");
   	int idx_key_3 = dSet.indexOfColumn("key_3");
   	int idx_key_4 = dSet.indexOfColumn("key_4");
   	int idx_key_5 = dSet.indexOfColumn("key_5");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sale_document ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "issue_date," + 
                    "issue_document," + 
                    "issue_no," + 
                    "issuer," + 
                    "issue_reason," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_issue_date);
      gpstatement.bindColumn(6, idx_issue_document);
      gpstatement.bindColumn(7, idx_issue_no);
      gpstatement.bindColumn(8, idx_issuer);
      gpstatement.bindColumn(9, idx_issue_reason);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_document set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "issue_date=?,  " + 
                            "issue_document=?,  " + 
                            "issue_no=?,  " + 
                            "issuer=?,  " + 
                            "issue_reason=?,  " + 
                            "remark=?  " + 
                      "where dept_code  =? " +
                        "and sell_code  =? " +
                        "and dongho     =? " +
                        "and seq        =? " +
                        "and issue_date =? " ; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_issue_date);
      gpstatement.bindColumn(6, idx_issue_document);
      gpstatement.bindColumn(7, idx_issue_no);
      gpstatement.bindColumn(8, idx_issuer);
      gpstatement.bindColumn(9, idx_issue_reason);
      gpstatement.bindColumn(10, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_key_1);
      gpstatement.bindColumn(12, idx_key_2);
      gpstatement.bindColumn(13, idx_key_3);
      gpstatement.bindColumn(14, idx_key_4);
      gpstatement.bindColumn(15, idx_key_5);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_document where dept_code=? and sell_code=? and dongho=? and seq=? and issue_date=?";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_1);
      gpstatement.bindColumn(2, idx_key_2);
      gpstatement.bindColumn(3, idx_key_3);
      gpstatement.bindColumn(4, idx_key_4);
      gpstatement.bindColumn(5, idx_key_5);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>