<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_ord_result_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_div_name = dSet.indexOfColumn("div_name");
   	int idx_m_1 = dSet.indexOfColumn("m_1");
   	int idx_m_2 = dSet.indexOfColumn("m_2");
   	int idx_m_3 = dSet.indexOfColumn("m_3");
   	int idx_m_4 = dSet.indexOfColumn("m_4");
   	int idx_m_5 = dSet.indexOfColumn("m_5");
   	int idx_m_6 = dSet.indexOfColumn("m_6");
   	int idx_m_7 = dSet.indexOfColumn("m_7");
   	int idx_m_8 = dSet.indexOfColumn("m_8");
   	int idx_m_9 = dSet.indexOfColumn("m_9");
   	int idx_m_10 = dSet.indexOfColumn("m_10");
   	int idx_m_11 = dSet.indexOfColumn("m_11");
   	int idx_m_12 = dSet.indexOfColumn("m_12");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_ord_result ( work_year," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "div_name," + 
                    "m_1," + 
                    "m_2," + 
                    "m_3," + 
                    "m_4," + 
                    "m_5," + 
                    "m_6," + 
                    "m_7," + 
                    "m_8," + 
                    "m_9," + 
                    "m_10," + 
                    "m_11," + 
                    "m_12 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_div_name);
      gpstatement.bindColumn(5, idx_m_1);
      gpstatement.bindColumn(6, idx_m_2);
      gpstatement.bindColumn(7, idx_m_3);
      gpstatement.bindColumn(8, idx_m_4);
      gpstatement.bindColumn(9, idx_m_5);
      gpstatement.bindColumn(10, idx_m_6);
      gpstatement.bindColumn(11, idx_m_7);
      gpstatement.bindColumn(12, idx_m_8);
      gpstatement.bindColumn(13, idx_m_9);
      gpstatement.bindColumn(14, idx_m_10);
      gpstatement.bindColumn(15, idx_m_11);
      gpstatement.bindColumn(16, idx_m_12);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_ord_result set " + 
                            "work_year=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "div_name=?,  " + 
                            "m_1=?,  " + 
                            "m_2=?,  " + 
                            "m_3=?,  " + 
                            "m_4=?,  " + 
                            "m_5=?,  " + 
                            "m_6=?,  " + 
                            "m_7=?,  " + 
                            "m_8=?,  " + 
                            "m_9=?,  " + 
                            "m_10=?,  " + 
                            "m_11=?,  " + 
                            "m_12=?  where work_year=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_div_name);
      gpstatement.bindColumn(5, idx_m_1);
      gpstatement.bindColumn(6, idx_m_2);
      gpstatement.bindColumn(7, idx_m_3);
      gpstatement.bindColumn(8, idx_m_4);
      gpstatement.bindColumn(9, idx_m_5);
      gpstatement.bindColumn(10, idx_m_6);
      gpstatement.bindColumn(11, idx_m_7);
      gpstatement.bindColumn(12, idx_m_8);
      gpstatement.bindColumn(13, idx_m_9);
      gpstatement.bindColumn(14, idx_m_10);
      gpstatement.bindColumn(15, idx_m_11);
      gpstatement.bindColumn(16, idx_m_12);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_work_year);
      gpstatement.bindColumn(18, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_ord_result where work_year=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>