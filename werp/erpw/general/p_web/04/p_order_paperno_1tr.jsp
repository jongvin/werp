<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_paperno_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_order_title = dSet.indexOfColumn("order_title");
   	int idx_decision_date = dSet.indexOfColumn("decision_date");
   	int idx_send_date = dSet.indexOfColumn("send_date");
   	int idx_order_office = dSet.indexOfColumn("order_office");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_order_paperno ( order_no," + 
                    "input_date," + 
                    "comp_code," + 
                    "order_title," + 
                    "decision_date," + 
                    "send_date," + 
                    "order_office )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_no);
      gpstatement.bindColumn(2, idx_input_date);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_order_title);
      gpstatement.bindColumn(5, idx_decision_date);
      gpstatement.bindColumn(6, idx_send_date);
      gpstatement.bindColumn(7, idx_order_office);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_order_paperno set " + 
                            "order_no=?,  " + 
                            "input_date=?,  " + 
                            "comp_code=?,  " + 
                            "order_title=?,  " + 
                            "decision_date=?,  " + 
                            "send_date=?,  " + 
                            "order_office=?  where order_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_no);
      gpstatement.bindColumn(2, idx_input_date);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_order_title);
      gpstatement.bindColumn(5, idx_decision_date);
      gpstatement.bindColumn(6, idx_send_date);
      gpstatement.bindColumn(7, idx_order_office);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_order_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_order_paperno where order_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_order_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>