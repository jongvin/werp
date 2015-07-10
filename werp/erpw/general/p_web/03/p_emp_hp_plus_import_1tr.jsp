<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_hp_plus_import_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_employ_degree = dSet.indexOfColumn("employ_degree");
   	int idx_appl_no = dSet.indexOfColumn("appl_no");
   	int idx_appl_name = dSet.indexOfColumn("appl_name");
   	int idx_appl_part = dSet.indexOfColumn("appl_part");
   	int idx_appl_part2 = dSet.indexOfColumn("appl_part2");
   	int idx_car_tag = dSet.indexOfColumn("car_tag");
   	int idx_sex = dSet.indexOfColumn("sex");
   	int idx_appl_date = dSet.indexOfColumn("appl_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_emp_applicant ( employ_degree," + 
                    "appl_no," + 
                    "appl_name," + 
                    "appl_part," + 
                    "appl_part2," + 
                    "car_tag," + 
                    "sex," + 
                    "appl_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_appl_no);
      gpstatement.bindColumn(3, idx_appl_name);
      gpstatement.bindColumn(4, idx_appl_part);
      gpstatement.bindColumn(5, idx_appl_part2);
      gpstatement.bindColumn(6, idx_car_tag);
      gpstatement.bindColumn(7, idx_sex);
      gpstatement.bindColumn(8, idx_appl_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_emp_applicant where employ_degree=? and appl_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>