<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_sale_key_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_porch = dSet.indexOfColumn("porch");
   	int idx_bedroom1 = dSet.indexOfColumn("bedroom1");
   	int idx_bedroom2 = dSet.indexOfColumn("bedroom2");
   	int idx_bedroom3 = dSet.indexOfColumn("bedroom3");
   	int idx_bedroom4 = dSet.indexOfColumn("bedroom4");
   	int idx_bedroom5 = dSet.indexOfColumn("bedroom5");
   	int idx_bedroom6 = dSet.indexOfColumn("bedroom6");
   	int idx_bedroom7 = dSet.indexOfColumn("bedroom7");
   	int idx_bedroom8 = dSet.indexOfColumn("bedroom8");
   	int idx_bedroom9 = dSet.indexOfColumn("bedroom9");
   	int idx_bedroom10 = dSet.indexOfColumn("bedroom10");
   	int idx_restroom1 = dSet.indexOfColumn("restroom1");
   	int idx_restroom2 = dSet.indexOfColumn("restroom2");
   	int idx_etc_key = dSet.indexOfColumn("etc_key");
   	int idx_out_date = dSet.indexOfColumn("out_date");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_key_1 = dSet.indexOfColumn("key_1");
   	int idx_key_2 = dSet.indexOfColumn("key_2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sale_key ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "porch," + 
                    "bedroom1," + 
                    "bedroom2," + 
                    "bedroom3," + 
                    "bedroom4," + 
                    "bedroom5," + 
                    "bedroom6," + 
                    "bedroom7," + 
                    "bedroom8," + 
                    "bedroom9," + 
                    "bedroom10," + 
                    "restroom1," + 
                    "restroom2," + 
                    "etc_key," + 
                    "out_date," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_porch);
      gpstatement.bindColumn(6, idx_bedroom1);
      gpstatement.bindColumn(7, idx_bedroom2);
      gpstatement.bindColumn(8, idx_bedroom3);
      gpstatement.bindColumn(9, idx_bedroom4);
      gpstatement.bindColumn(10, idx_bedroom5);
      gpstatement.bindColumn(11, idx_bedroom6);
      gpstatement.bindColumn(12, idx_bedroom7);
      gpstatement.bindColumn(13, idx_bedroom8);
      gpstatement.bindColumn(14, idx_bedroom9);
      gpstatement.bindColumn(15, idx_bedroom10);
      gpstatement.bindColumn(16, idx_restroom1);
      gpstatement.bindColumn(17, idx_restroom2);
      gpstatement.bindColumn(18, idx_etc_key);
      gpstatement.bindColumn(19, idx_out_date);
      gpstatement.bindColumn(20, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_key set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "porch=?,  " + 
                            "bedroom1=?,  " + 
                            "bedroom2=?,  " + 
                            "bedroom3=?,  " + 
                            "bedroom4=?,  " + 
                            "bedroom5=?,  " + 
                            "bedroom6=?,  " + 
                            "bedroom7=?,  " + 
                            "bedroom8=?,  " + 
                            "bedroom9=?,  " + 
                            "bedroom10=?,  " + 
                            "restroom1=?,  " + 
                            "restroom2=?,  " + 
                            "etc_key=?,  " + 
                            "out_date=?,  " + 
                            "remark=?  where dept_code=? and sell_code=? and dongho=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_porch);
      gpstatement.bindColumn(6, idx_bedroom1);
      gpstatement.bindColumn(7, idx_bedroom2);
      gpstatement.bindColumn(8, idx_bedroom3);
      gpstatement.bindColumn(9, idx_bedroom4);
      gpstatement.bindColumn(10, idx_bedroom5);
      gpstatement.bindColumn(11, idx_bedroom6);
      gpstatement.bindColumn(12, idx_bedroom7);
      gpstatement.bindColumn(13, idx_bedroom8);
      gpstatement.bindColumn(14, idx_bedroom9);
      gpstatement.bindColumn(15, idx_bedroom10);
      gpstatement.bindColumn(16, idx_restroom1);
      gpstatement.bindColumn(17, idx_restroom2);
      gpstatement.bindColumn(18, idx_etc_key);
      gpstatement.bindColumn(19, idx_out_date);
      gpstatement.bindColumn(20, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_dept_code);
      gpstatement.bindColumn(22, idx_sell_code);
      gpstatement.bindColumn(23, idx_key_1);
      gpstatement.bindColumn(24, idx_key_2);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_key where dept_code=? and sell_code=? and dongho=? and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_key_1);
      gpstatement.bindColumn(4, idx_key_2);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>