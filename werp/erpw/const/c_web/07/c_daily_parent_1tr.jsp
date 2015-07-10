<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_daily_parent_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_weather_1 = dSet.indexOfColumn("weather_1");
   	int idx_weather_2 = dSet.indexOfColumn("weather_2");
   	int idx_heat_1 = dSet.indexOfColumn("heat_1");
   	int idx_heat_2 = dSet.indexOfColumn("heat_2");
   	int idx_bigo = dSet.indexOfColumn("bigo");
   	int idx_next_bigo = dSet.indexOfColumn("next_bigo");
   	int idx_master_confirm = dSet.indexOfColumn("master_confirm");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_daily_parent ( dept_code," + 
                    "yymmdd," + 
                    "weather_1," + 
                    "weather_2," + 
                    "heat_1," + 
                    "heat_2," + 
                    "bigo," + 
                    "next_bigo,master_confirm,remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_weather_1);
      gpstatement.bindColumn(4, idx_weather_2);
      gpstatement.bindColumn(5, idx_heat_1);
      gpstatement.bindColumn(6, idx_heat_2);
      gpstatement.bindColumn(7, idx_bigo);
      gpstatement.bindColumn(8, idx_next_bigo);
      gpstatement.bindColumn(9, idx_master_confirm);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_daily_parent set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "weather_1=?,  " + 
                            "weather_2=?,  " + 
                            "heat_1=?,  " + 
                            "heat_2=?,  " + 
                            "bigo=?,  " + 
                            "next_bigo=?,master_confirm=? ,remark=? where dept_code=? and yymmdd=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_weather_1);
      gpstatement.bindColumn(4, idx_weather_2);
      gpstatement.bindColumn(5, idx_heat_1);
      gpstatement.bindColumn(6, idx_heat_2);
      gpstatement.bindColumn(7, idx_bigo);
      gpstatement.bindColumn(8, idx_next_bigo);
      gpstatement.bindColumn(9, idx_master_confirm);
      gpstatement.bindColumn(10, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_yymmdd);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_daily_parent where dept_code=? and yymmdd=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>