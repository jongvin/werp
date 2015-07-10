<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("d_efin_approval_type_itf_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_approval_id = dSet.indexOfColumn("approval_id");
   	int idx_approval_type = dSet.indexOfColumn("approval_type");
   	int idx_approval_type_name = dSet.indexOfColumn("approval_type_name");
   	int idx_approval_id_last = dSet.indexOfColumn("approval_id_last");
   	int idx_approval_id_1 = dSet.indexOfColumn("approval_id_1");
   	int idx_approval_jik_1 = dSet.indexOfColumn("approval_jik_1");
   	int idx_approval_name_1 = dSet.indexOfColumn("approval_name_1");
   	int idx_approval_date_1 = dSet.indexOfColumn("approval_date_1");
   	int idx_approval_status_1 = dSet.indexOfColumn("approval_status_1");
   	int idx_approval_id_2 = dSet.indexOfColumn("approval_id_2");
   	int idx_approval_jik_2 = dSet.indexOfColumn("approval_jik_2");
   	int idx_approval_name_2 = dSet.indexOfColumn("approval_name_2");
   	int idx_approval_date_2 = dSet.indexOfColumn("approval_date_2");
   	int idx_approval_status_2 = dSet.indexOfColumn("approval_status_2");
   	int idx_approval_id_3 = dSet.indexOfColumn("approval_id_3");
   	int idx_approval_jik_3 = dSet.indexOfColumn("approval_jik_3");
   	int idx_approval_name_3 = dSet.indexOfColumn("approval_name_3");
   	int idx_approval_date_3 = dSet.indexOfColumn("approval_date_3");
   	int idx_approval_status_3 = dSet.indexOfColumn("approval_status_3");
   	int idx_approval_id_4 = dSet.indexOfColumn("approval_id_4");
   	int idx_approval_jik_4 = dSet.indexOfColumn("approval_jik_4");
   	int idx_approval_name_4 = dSet.indexOfColumn("approval_name_4");
   	int idx_approval_date_4 = dSet.indexOfColumn("approval_date_4");
   	int idx_approval_status_4 = dSet.indexOfColumn("approval_status_4");
   	int idx_approval_id_5 = dSet.indexOfColumn("approval_id_5");
   	int idx_approval_jik_5 = dSet.indexOfColumn("approval_jik_5");
   	int idx_approval_name_5 = dSet.indexOfColumn("approval_name_5");
   	int idx_approval_date_5 = dSet.indexOfColumn("approval_date_5");
   	int idx_approval_status_5 = dSet.indexOfColumn("approval_status_5");
   	int idx_approval_id_6 = dSet.indexOfColumn("approval_id_6");
   	int idx_approval_jik_6 = dSet.indexOfColumn("approval_jik_6");
   	int idx_approval_name_6 = dSet.indexOfColumn("approval_name_6");
   	int idx_approval_date_6 = dSet.indexOfColumn("approval_date_6");
   	int idx_approval_status_6 = dSet.indexOfColumn("approval_status_6");
   	int idx_approval_id_7 = dSet.indexOfColumn("approval_id_7");
   	int idx_approval_jik_7 = dSet.indexOfColumn("approval_jik_7");
   	int idx_approval_name_7 = dSet.indexOfColumn("approval_name_7");
   	int idx_approval_date_7 = dSet.indexOfColumn("approval_date_7");
   	int idx_approval_status_7 = dSet.indexOfColumn("approval_status_7");
   	int idx_approval_id_8 = dSet.indexOfColumn("approval_id_8");
   	int idx_approval_jik_8 = dSet.indexOfColumn("approval_jik_8");
   	int idx_approval_name_8 = dSet.indexOfColumn("approval_name_8");
   	int idx_approval_date_8 = dSet.indexOfColumn("approval_date_8");
   	int idx_approval_status_8 = dSet.indexOfColumn("approval_status_8");
   	int idx_approval_id_9 = dSet.indexOfColumn("approval_id_9");
   	int idx_approval_jik_9 = dSet.indexOfColumn("approval_jik_9");
   	int idx_approval_name_9 = dSet.indexOfColumn("approval_name_9");
   	int idx_approval_date_9 = dSet.indexOfColumn("approval_date_9");
   	int idx_approval_status_9 = dSet.indexOfColumn("approval_status_9");
   	int idx_approval_id_10 = dSet.indexOfColumn("approval_id_10");
   	int idx_approval_jik_10 = dSet.indexOfColumn("approval_jik_10");
   	int idx_approval_name_10 = dSet.indexOfColumn("approval_name_10");
   	int idx_approval_date_10 = dSet.indexOfColumn("approval_date_10");
   	int idx_approval_status_10 = dSet.indexOfColumn("approval_status_10");
   	int idx_approval_id_11 = dSet.indexOfColumn("approval_id_11");
   	int idx_approval_jik_11 = dSet.indexOfColumn("approval_jik_11");
   	int idx_approval_name_11 = dSet.indexOfColumn("approval_name_11");
   	int idx_approval_date_11 = dSet.indexOfColumn("approval_date_11");
   	int idx_approval_status_11 = dSet.indexOfColumn("approval_status_11");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO efin_approval_type_itf  ( approval_id," + 
                    "approval_type," + 
                    "approval_type_name," + 
                    "approval_id_last," + 
                    "approval_id_1," + 
                    "approval_jik_1," + 
                    "approval_name_1," + 
                    "approval_date_1," + 
                    "approval_status_1," + 
                    "approval_id_2," + 
                    "approval_jik_2," + 
                    "approval_name_2," + 
                    "approval_date_2," + 
                    "approval_status_2," + 
                    "approval_id_3," + 
                    "approval_jik_3," + 
                    "approval_name_3," + 
                    "approval_date_3," + 
                    "approval_status_3," + 
                    "approval_id_4," + 
                    "approval_jik_4," + 
                    "approval_name_4," + 
                    "approval_date_4," + 
                    "approval_status_4," + 
                    "approval_id_5," + 
                    "approval_jik_5," + 
                    "approval_name_5," + 
                    "approval_date_5," + 
                    "approval_status_5," + 
                    "approval_id_6," + 
                    "approval_jik_6," + 
                    "approval_name_6," + 
                    "approval_date_6," + 
                    "approval_status_6," + 
                    "approval_id_7," + 
                    "approval_jik_7," + 
                    "approval_name_7," + 
                    "approval_date_7," + 
                    "approval_status_7," + 
                    "approval_id_8," + 
                    "approval_jik_8," + 
                    "approval_name_8," + 
                    "approval_date_8," + 
                    "approval_status_8," + 
                    "approval_id_9," + 
                    "approval_jik_9," + 
                    "approval_name_9," + 
                    "approval_date_9," + 
                    "approval_status_9," + 
                    "approval_id_10," + 
                    "approval_jik_10," + 
                    "approval_name_10," + 
                    "approval_date_10," + 
                    "approval_status_10," + 
                    "approval_id_11," + 
                    "approval_jik_11," + 
                    "approval_name_11," + 
                    "approval_date_11," + 
                    "approval_status_11 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_approval_id);
      gpstatement.bindColumn(2, idx_approval_type);
      gpstatement.bindColumn(3, idx_approval_type_name);
      gpstatement.bindColumn(4, idx_approval_id_last);
      gpstatement.bindColumn(5, idx_approval_id_1);
      gpstatement.bindColumn(6, idx_approval_jik_1);
      gpstatement.bindColumn(7, idx_approval_name_1);
      gpstatement.bindColumn(8, idx_approval_date_1);
      gpstatement.bindColumn(9, idx_approval_status_1);
      gpstatement.bindColumn(10, idx_approval_id_2);
      gpstatement.bindColumn(11, idx_approval_jik_2);
      gpstatement.bindColumn(12, idx_approval_name_2);
      gpstatement.bindColumn(13, idx_approval_date_2);
      gpstatement.bindColumn(14, idx_approval_status_2);
      gpstatement.bindColumn(15, idx_approval_id_3);
      gpstatement.bindColumn(16, idx_approval_jik_3);
      gpstatement.bindColumn(17, idx_approval_name_3);
      gpstatement.bindColumn(18, idx_approval_date_3);
      gpstatement.bindColumn(19, idx_approval_status_3);
      gpstatement.bindColumn(20, idx_approval_id_4);
      gpstatement.bindColumn(21, idx_approval_jik_4);
      gpstatement.bindColumn(22, idx_approval_name_4);
      gpstatement.bindColumn(23, idx_approval_date_4);
      gpstatement.bindColumn(24, idx_approval_status_4);
      gpstatement.bindColumn(25, idx_approval_id_5);
      gpstatement.bindColumn(26, idx_approval_jik_5);
      gpstatement.bindColumn(27, idx_approval_name_5);
      gpstatement.bindColumn(28, idx_approval_date_5);
      gpstatement.bindColumn(29, idx_approval_status_5);
      gpstatement.bindColumn(30, idx_approval_id_6);
      gpstatement.bindColumn(31, idx_approval_jik_6);
      gpstatement.bindColumn(32, idx_approval_name_6);
      gpstatement.bindColumn(33, idx_approval_date_6);
      gpstatement.bindColumn(34, idx_approval_status_6);
      gpstatement.bindColumn(35, idx_approval_id_7);
      gpstatement.bindColumn(36, idx_approval_jik_7);
      gpstatement.bindColumn(37, idx_approval_name_7);
      gpstatement.bindColumn(38, idx_approval_date_7);
      gpstatement.bindColumn(39, idx_approval_status_7);
      gpstatement.bindColumn(40, idx_approval_id_8);
      gpstatement.bindColumn(41, idx_approval_jik_8);
      gpstatement.bindColumn(42, idx_approval_name_8);
      gpstatement.bindColumn(43, idx_approval_date_8);
      gpstatement.bindColumn(44, idx_approval_status_8);
      gpstatement.bindColumn(45, idx_approval_id_9);
      gpstatement.bindColumn(46, idx_approval_jik_9);
      gpstatement.bindColumn(47, idx_approval_name_9);
      gpstatement.bindColumn(48, idx_approval_date_9);
      gpstatement.bindColumn(49, idx_approval_status_9);
      gpstatement.bindColumn(50, idx_approval_id_10);
      gpstatement.bindColumn(51, idx_approval_jik_10);
      gpstatement.bindColumn(52, idx_approval_name_10);
      gpstatement.bindColumn(53, idx_approval_date_10);
      gpstatement.bindColumn(54, idx_approval_status_10);
      gpstatement.bindColumn(55, idx_approval_id_11);
      gpstatement.bindColumn(56, idx_approval_jik_11);
      gpstatement.bindColumn(57, idx_approval_name_11);
      gpstatement.bindColumn(58, idx_approval_date_11);
      gpstatement.bindColumn(59, idx_approval_status_11);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update efin_approval_type_itf  set " + 
                            "approval_id=?,  " + 
                            "approval_type=?,  " + 
                            "approval_type_name=?,  " + 
                            "approval_id_last=?,  " + 
                            "approval_id_1=?,  " + 
                            "approval_jik_1=?,  " + 
                            "approval_name_1=?,  " + 
                            "approval_date_1=?,  " + 
                            "approval_status_1=?,  " + 
                            "approval_id_2=?,  " + 
                            "approval_jik_2=?,  " + 
                            "approval_name_2=?,  " + 
                            "approval_date_2=?,  " + 
                            "approval_status_2=?,  " + 
                            "approval_id_3=?,  " + 
                            "approval_jik_3=?,  " + 
                            "approval_name_3=?,  " + 
                            "approval_date_3=?,  " + 
                            "approval_status_3=?,  " + 
                            "approval_id_4=?,  " + 
                            "approval_jik_4=?,  " + 
                            "approval_name_4=?,  " + 
                            "approval_date_4=?,  " + 
                            "approval_status_4=?,  " + 
                            "approval_id_5=?,  " + 
                            "approval_jik_5=?,  " + 
                            "approval_name_5=?,  " + 
                            "approval_date_5=?,  " + 
                            "approval_status_5=?,  " + 
                            "approval_id_6=?,  " + 
                            "approval_jik_6=?,  " + 
                            "approval_name_6=?,  " + 
                            "approval_date_6=?,  " + 
                            "approval_status_6=?,  " + 
                            "approval_id_7=?,  " + 
                            "approval_jik_7=?,  " + 
                            "approval_name_7=?,  " + 
                            "approval_date_7=?,  " + 
                            "approval_status_7=?,  " + 
                            "approval_id_8=?,  " + 
                            "approval_jik_8=?,  " + 
                            "approval_name_8=?,  " + 
                            "approval_date_8=?,  " + 
                            "approval_status_8=?,  " + 
                            "approval_id_9=?,  " + 
                            "approval_jik_9=?,  " + 
                            "approval_name_9=?,  " + 
                            "approval_date_9=?,  " + 
                            "approval_status_9=?,  " + 
                            "approval_id_10=?,  " + 
                            "approval_jik_10=?,  " + 
                            "approval_name_10=?,  " + 
                            "approval_date_10=?,  " + 
                            "approval_status_10=?,  " + 
                            "approval_id_11=?,  " + 
                            "approval_jik_11=?,  " + 
                            "approval_name_11=?,  " + 
                            "approval_date_11=?,  " + 
                            "approval_status_11=?  where approval_id=? and approval_type = ?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_approval_id);
      gpstatement.bindColumn(2, idx_approval_type);
      gpstatement.bindColumn(3, idx_approval_type_name);
      gpstatement.bindColumn(4, idx_approval_id_last);
      gpstatement.bindColumn(5, idx_approval_id_1);
      gpstatement.bindColumn(6, idx_approval_jik_1);
      gpstatement.bindColumn(7, idx_approval_name_1);
      gpstatement.bindColumn(8, idx_approval_date_1);
      gpstatement.bindColumn(9, idx_approval_status_1);
      gpstatement.bindColumn(10, idx_approval_id_2);
      gpstatement.bindColumn(11, idx_approval_jik_2);
      gpstatement.bindColumn(12, idx_approval_name_2);
      gpstatement.bindColumn(13, idx_approval_date_2);
      gpstatement.bindColumn(14, idx_approval_status_2);
      gpstatement.bindColumn(15, idx_approval_id_3);
      gpstatement.bindColumn(16, idx_approval_jik_3);
      gpstatement.bindColumn(17, idx_approval_name_3);
      gpstatement.bindColumn(18, idx_approval_date_3);
      gpstatement.bindColumn(19, idx_approval_status_3);
      gpstatement.bindColumn(20, idx_approval_id_4);
      gpstatement.bindColumn(21, idx_approval_jik_4);
      gpstatement.bindColumn(22, idx_approval_name_4);
      gpstatement.bindColumn(23, idx_approval_date_4);
      gpstatement.bindColumn(24, idx_approval_status_4);
      gpstatement.bindColumn(25, idx_approval_id_5);
      gpstatement.bindColumn(26, idx_approval_jik_5);
      gpstatement.bindColumn(27, idx_approval_name_5);
      gpstatement.bindColumn(28, idx_approval_date_5);
      gpstatement.bindColumn(29, idx_approval_status_5);
      gpstatement.bindColumn(30, idx_approval_id_6);
      gpstatement.bindColumn(31, idx_approval_jik_6);
      gpstatement.bindColumn(32, idx_approval_name_6);
      gpstatement.bindColumn(33, idx_approval_date_6);
      gpstatement.bindColumn(34, idx_approval_status_6);
      gpstatement.bindColumn(35, idx_approval_id_7);
      gpstatement.bindColumn(36, idx_approval_jik_7);
      gpstatement.bindColumn(37, idx_approval_name_7);
      gpstatement.bindColumn(38, idx_approval_date_7);
      gpstatement.bindColumn(39, idx_approval_status_7);
      gpstatement.bindColumn(40, idx_approval_id_8);
      gpstatement.bindColumn(41, idx_approval_jik_8);
      gpstatement.bindColumn(42, idx_approval_name_8);
      gpstatement.bindColumn(43, idx_approval_date_8);
      gpstatement.bindColumn(44, idx_approval_status_8);
      gpstatement.bindColumn(45, idx_approval_id_9);
      gpstatement.bindColumn(46, idx_approval_jik_9);
      gpstatement.bindColumn(47, idx_approval_name_9);
      gpstatement.bindColumn(48, idx_approval_date_9);
      gpstatement.bindColumn(49, idx_approval_status_9);
      gpstatement.bindColumn(50, idx_approval_id_10);
      gpstatement.bindColumn(51, idx_approval_jik_10);
      gpstatement.bindColumn(52, idx_approval_name_10);
      gpstatement.bindColumn(53, idx_approval_date_10);
      gpstatement.bindColumn(54, idx_approval_status_10);
      gpstatement.bindColumn(55, idx_approval_id_11);
      gpstatement.bindColumn(56, idx_approval_jik_11);
      gpstatement.bindColumn(57, idx_approval_name_11);
      gpstatement.bindColumn(58, idx_approval_date_11);
      gpstatement.bindColumn(59, idx_approval_status_11);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(60, idx_approval_id);
      gpstatement.bindColumn(61, idx_approval_type);

      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from efin_approval_type_itf  where approval_id=? and approval_type = ?";   
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_approval_id);
      gpstatement.bindColumn(2, idx_approval_type);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>