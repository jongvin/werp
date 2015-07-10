<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_code_price_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_price_class = dSet.indexOfColumn("price_class");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_price1 = dSet.indexOfColumn("price1");
   	int idx_price2 = dSet.indexOfColumn("price2");
   	int idx_price3 = dSet.indexOfColumn("price3");
   	int idx_price4 = dSet.indexOfColumn("price4");
   	int idx_price5 = dSet.indexOfColumn("price5");
   	int idx_price6 = dSet.indexOfColumn("price6");
   	int idx_price7 = dSet.indexOfColumn("price7");
   	int idx_price8 = dSet.indexOfColumn("price8");
   	int idx_price9 = dSet.indexOfColumn("price9");
   	int idx_price10 = dSet.indexOfColumn("price10");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_MTR_PRICE ( price_class," + 
                    "mtrcode," + 
                    "price1," + 
                    "price2," + 
                    "price3," + 
                    "price4," + 
                    "price5," + 
                    "price6," + 
                    "price7," + 
                    "price8," + 
                    "price9," + 
                    "price10," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_price_class);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_price1);
      gpstatement.bindColumn(4, idx_price2);
      gpstatement.bindColumn(5, idx_price3);
      gpstatement.bindColumn(6, idx_price4);
      gpstatement.bindColumn(7, idx_price5);
      gpstatement.bindColumn(8, idx_price6);
      gpstatement.bindColumn(9, idx_price7);
      gpstatement.bindColumn(10, idx_price8);
      gpstatement.bindColumn(11, idx_price9);
      gpstatement.bindColumn(12, idx_price10);
      gpstatement.bindColumn(13, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_mtr_price set " + 
                            "price_class=?,  " + 
                            "mtrcode=?,  " + 
                            "price1=?,  " + 
                            "price2=?,  " + 
                            "price3=?,  " + 
                            "price4=?,  " + 
                            "price5=?,  " + 
                            "price6=?,  " + 
                            "price7=?,  " + 
                            "price8=?,  " + 
                            "price9=?,  " + 
                            "price10=?,  " + 
                            "remark=?  where price_class=? " +
                            "            and mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_price_class);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_price1);
      gpstatement.bindColumn(4, idx_price2);
      gpstatement.bindColumn(5, idx_price3);
      gpstatement.bindColumn(6, idx_price4);
      gpstatement.bindColumn(7, idx_price5);
      gpstatement.bindColumn(8, idx_price6);
      gpstatement.bindColumn(9, idx_price7);
      gpstatement.bindColumn(10, idx_price8);
      gpstatement.bindColumn(11, idx_price9);
      gpstatement.bindColumn(12, idx_price10);
      gpstatement.bindColumn(13, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_price_class);
      gpstatement.bindColumn(15, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_mtr_price where price_class=? " +
                            "            and mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_price_class);
      gpstatement.bindColumn(2, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>