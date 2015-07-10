<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_license_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_license_code = dSet.indexOfColumn("license_code");
   	int idx_license_name = dSet.indexOfColumn("license_name");
   	int idx_license_type_code = dSet.indexOfColumn("license_type_code");
   	int idx_license_area_code = dSet.indexOfColumn("license_area_code");
   	int idx_eval_yn = dSet.indexOfColumn("eval_yn");
   	int idx_old_license_code = dSet.indexOfColumn("old_license_code");
   	int idx_sort_order = dSet.indexOfColumn("sort_order");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_license ( license_code," + 
                    "license_name," + 
                    "license_type_code," + 
                    "license_area_code," + 
                    "eval_yn," + 
                    "old_license_code," + 
                    "sort_order )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_code);
      gpstatement.bindColumn(2, idx_license_name);
      gpstatement.bindColumn(3, idx_license_type_code);
      gpstatement.bindColumn(4, idx_license_area_code);
      gpstatement.bindColumn(5, idx_eval_yn);
      gpstatement.bindColumn(6, idx_old_license_code);
      gpstatement.bindColumn(7, idx_sort_order);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_license set " + 
                            "license_code=?,  " + 
                            "license_name=?,  " + 
                            "license_type_code=?,  " + 
                            "license_area_code=?,  " + 
                            "eval_yn=?,  " + 
                            "old_license_code=?,  " + 
                            "sort_order=?  where license_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_code);
      gpstatement.bindColumn(2, idx_license_name);
      gpstatement.bindColumn(3, idx_license_type_code);
      gpstatement.bindColumn(4, idx_license_area_code);
      gpstatement.bindColumn(5, idx_eval_yn);
      gpstatement.bindColumn(6, idx_old_license_code);
      gpstatement.bindColumn(7, idx_sort_order);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_license_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_license where license_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_license_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>