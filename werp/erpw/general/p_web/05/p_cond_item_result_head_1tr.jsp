<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_cond_item_result_head_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_item_code_1 = dSet.indexOfColumn("item_code_1");
   	int idx_item_check_1 = dSet.indexOfColumn("item_check_1");
   	int idx_item_name_1 = dSet.indexOfColumn("item_name_1");
   	int idx_item_code_2 = dSet.indexOfColumn("item_code_2");
   	int idx_item_check_2 = dSet.indexOfColumn("item_check_2");
   	int idx_item_name_2 = dSet.indexOfColumn("item_name_2");
   	int idx_item_code_3 = dSet.indexOfColumn("item_code_3");
   	int idx_item_check_3 = dSet.indexOfColumn("item_check_3");
   	int idx_item_name_3 = dSet.indexOfColumn("item_name_3");
   	int idx_item_code_4 = dSet.indexOfColumn("item_code_4");
   	int idx_item_check_4 = dSet.indexOfColumn("item_check_4");
   	int idx_item_name_4 = dSet.indexOfColumn("item_name_4");
   	int idx_item_code_5 = dSet.indexOfColumn("item_code_5");
   	int idx_item_check_5 = dSet.indexOfColumn("item_check_5");
   	int idx_item_name_5 = dSet.indexOfColumn("item_name_5");
   	int idx_item_code_6 = dSet.indexOfColumn("item_code_6");
   	int idx_item_check_6 = dSet.indexOfColumn("item_check_6");
   	int idx_item_name_6 = dSet.indexOfColumn("item_name_6");
   	int idx_item_code_7 = dSet.indexOfColumn("item_code_7");
   	int idx_item_check_7 = dSet.indexOfColumn("item_check_7");
   	int idx_item_name_7 = dSet.indexOfColumn("item_name_7");
   	int idx_item_code_8 = dSet.indexOfColumn("item_code_8");
   	int idx_item_check_8 = dSet.indexOfColumn("item_check_8");
   	int idx_item_name_8 = dSet.indexOfColumn("item_name_8");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_cond_item_result_head ( no_seq," + 
                    "seq," + 
                    "item_code_1," + 
                    "item_check_1," + 
                    "item_name_1," + 
                    "item_code_2," + 
                    "item_check_2," + 
                    "item_name_2," + 
                    "item_code_3," + 
                    "item_check_3," + 
                    "item_name_3," + 
                    "item_code_4," + 
                    "item_check_4," + 
                    "item_name_4," + 
                    "item_code_5," + 
                    "item_check_5," + 
                    "item_name_5," + 
                    "item_code_6," + 
                    "item_check_6," + 
                    "item_name_6," + 
                    "item_code_7," + 
                    "item_check_7," + 
                    "item_name_7," + 
                    "item_code_8," + 
                    "item_check_8," + 
                    "item_name_8 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_item_code_1);
      gpstatement.bindColumn(4, idx_item_check_1);
      gpstatement.bindColumn(5, idx_item_name_1);
      gpstatement.bindColumn(6, idx_item_code_2);
      gpstatement.bindColumn(7, idx_item_check_2);
      gpstatement.bindColumn(8, idx_item_name_2);
      gpstatement.bindColumn(9, idx_item_code_3);
      gpstatement.bindColumn(10, idx_item_check_3);
      gpstatement.bindColumn(11, idx_item_name_3);
      gpstatement.bindColumn(12, idx_item_code_4);
      gpstatement.bindColumn(13, idx_item_check_4);
      gpstatement.bindColumn(14, idx_item_name_4);
      gpstatement.bindColumn(15, idx_item_code_5);
      gpstatement.bindColumn(16, idx_item_check_5);
      gpstatement.bindColumn(17, idx_item_name_5);
      gpstatement.bindColumn(18, idx_item_code_6);
      gpstatement.bindColumn(19, idx_item_check_6);
      gpstatement.bindColumn(20, idx_item_name_6);
      gpstatement.bindColumn(21, idx_item_code_7);
      gpstatement.bindColumn(22, idx_item_check_7);
      gpstatement.bindColumn(23, idx_item_name_7);
      gpstatement.bindColumn(24, idx_item_code_8);
      gpstatement.bindColumn(25, idx_item_check_8);
      gpstatement.bindColumn(26, idx_item_name_8);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_cond_item_result_head set " + 
                            "no_seq=?,  " + 
                            "seq=?,  " + 
                            "item_code_1=?,  " + 
                            "item_check_1=?,  " + 
                            "item_name_1=?,  " + 
                            "item_code_2=?,  " + 
                            "item_check_2=?,  " + 
                            "item_name_2=?,  " + 
                            "item_code_3=?,  " + 
                            "item_check_3=?,  " + 
                            "item_name_3=?,  " + 
                            "item_code_4=?,  " + 
                            "item_check_4=?,  " + 
                            "item_name_4=?,  " + 
                            "item_code_5=?,  " + 
                            "item_check_5=?,  " + 
                            "item_name_5=?,  " + 
                            "item_code_6=?,  " + 
                            "item_check_6=?,  " + 
                            "item_name_6=?,  " + 
                            "item_code_7=?,  " + 
                            "item_check_7=?,  " + 
                            "item_name_7=?,  " + 
                            "item_code_8=?,  " + 
                            "item_check_8=?,  " + 
                            "item_name_8=?  where no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_item_code_1);
      gpstatement.bindColumn(4, idx_item_check_1);
      gpstatement.bindColumn(5, idx_item_name_1);
      gpstatement.bindColumn(6, idx_item_code_2);
      gpstatement.bindColumn(7, idx_item_check_2);
      gpstatement.bindColumn(8, idx_item_name_2);
      gpstatement.bindColumn(9, idx_item_code_3);
      gpstatement.bindColumn(10, idx_item_check_3);
      gpstatement.bindColumn(11, idx_item_name_3);
      gpstatement.bindColumn(12, idx_item_code_4);
      gpstatement.bindColumn(13, idx_item_check_4);
      gpstatement.bindColumn(14, idx_item_name_4);
      gpstatement.bindColumn(15, idx_item_code_5);
      gpstatement.bindColumn(16, idx_item_check_5);
      gpstatement.bindColumn(17, idx_item_name_5);
      gpstatement.bindColumn(18, idx_item_code_6);
      gpstatement.bindColumn(19, idx_item_check_6);
      gpstatement.bindColumn(20, idx_item_name_6);
      gpstatement.bindColumn(21, idx_item_code_7);
      gpstatement.bindColumn(22, idx_item_check_7);
      gpstatement.bindColumn(23, idx_item_name_7);
      gpstatement.bindColumn(24, idx_item_code_8);
      gpstatement.bindColumn(25, idx_item_check_8);
      gpstatement.bindColumn(26, idx_item_name_8);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(27, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_cond_item_result_head where no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>