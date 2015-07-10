<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_degree_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_edu_year = dSet.indexOfColumn("edu_year");
   	int idx_edu_code = dSet.indexOfColumn("edu_code");
   	int idx_edu_degree = dSet.indexOfColumn("edu_degree");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_end_date = dSet.indexOfColumn("end_date");
   	int idx_edu_day = dSet.indexOfColumn("edu_day");
   	int idx_edu_time = dSet.indexOfColumn("edu_time");
   	int idx_edu_place = dSet.indexOfColumn("edu_place");
   	int idx_edu_person = dSet.indexOfColumn("edu_person");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_edu_degree ( edu_year," + 
                    "edu_code," + 
                    "edu_degree," + 
                    "start_date," + 
                    "end_date," + 
                    "edu_day," + 
                    "edu_time," + 
                    "edu_place," + 
                    "edu_person )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      gpstatement.bindColumn(4, idx_start_date);
      gpstatement.bindColumn(5, idx_end_date);
      gpstatement.bindColumn(6, idx_edu_day);
      gpstatement.bindColumn(7, idx_edu_time);
      gpstatement.bindColumn(8, idx_edu_place);
      gpstatement.bindColumn(9, idx_edu_person);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_edu_degree set " + 
                            "edu_year=?,  " + 
                            "edu_code=?,  " + 
                            "edu_degree=?,  " + 
                            "start_date=?,  " + 
                            "end_date=?,  " + 
                            "edu_day=?,  " + 
                            "edu_time=?,  " + 
                            "edu_place=?,  " + 
                            "edu_person=?  where edu_year=? and edu_code=? and edu_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      gpstatement.bindColumn(4, idx_start_date);
      gpstatement.bindColumn(5, idx_end_date);
      gpstatement.bindColumn(6, idx_edu_day);
      gpstatement.bindColumn(7, idx_edu_time);
      gpstatement.bindColumn(8, idx_edu_place);
      gpstatement.bindColumn(9, idx_edu_person);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_edu_year);
      gpstatement.bindColumn(11, idx_edu_code);
      gpstatement.bindColumn(12, idx_edu_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_edu_degree where edu_year=? and edu_code=? and edu_degree=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>