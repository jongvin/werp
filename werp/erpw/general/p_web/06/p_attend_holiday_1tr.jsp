<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_attend_holiday_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_holiday = dSet.indexOfColumn("holiday");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_holiday_tag = dSet.indexOfColumn("holiday_tag");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_input_emp = dSet.indexOfColumn("input_emp");
   	int idx_update_date = dSet.indexOfColumn("update_date");
   	int idx_update_emp = dSet.indexOfColumn("update_emp");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_attend_holiday ( holiday," + 
                    "contents," + 
                    "holiday_tag," + 
                    "input_date," + 
                    "input_emp," + 
                    "update_date," + 
                    "update_emp )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_holiday);
      gpstatement.bindColumn(2, idx_contents);
      gpstatement.bindColumn(3, idx_holiday_tag);
      gpstatement.bindColumn(4, idx_input_date);
      gpstatement.bindColumn(5, idx_input_emp);
      gpstatement.bindColumn(6, idx_update_date);
      gpstatement.bindColumn(7, idx_update_emp);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_attend_holiday set " + 
                            "holiday=?,  " + 
                            "contents=?,  " + 
                            "holiday_tag=?,  " + 
                            "input_date=?,  " + 
                            "input_emp=?,  " + 
                            "update_date=?,  " + 
                            "update_emp=?  where holiday=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_holiday);
      gpstatement.bindColumn(2, idx_contents);
      gpstatement.bindColumn(3, idx_holiday_tag);
      gpstatement.bindColumn(4, idx_input_date);
      gpstatement.bindColumn(5, idx_input_emp);
      gpstatement.bindColumn(6, idx_update_date);
      gpstatement.bindColumn(7, idx_update_emp);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_holiday);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_attend_holiday where holiday=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_holiday);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>