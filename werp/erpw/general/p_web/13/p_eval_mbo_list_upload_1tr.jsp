<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/general/p_web/picture/");
String dir = (String) session.getAttribute("dir");
      GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_list_upload_1tr"); 
      gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_upload_date = dSet.indexOfColumn("upload_date");
   	int idx_url = dSet.indexOfColumn("url");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_file_name = dSet.indexOfColumn("file_name");
   	int idx_d_name_file = dSet.indexOfColumn("name_file");      
      GauceDataRow[] rowx = dSet.getDataRows();
      int  rowCnt = dSet.getDataRowCnt();
  for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	   if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
      String sSql = "update p_eval_mbo_list set " + 
                            "upload_date=TO_DATE(?,'yyyy.mm.dd hh24:mi:ss'),  " + 
                            "url=?  where eval_code=? and eval_year=? and eval_degree=? and self_evaluator=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_upload_date);
      gpstatement.bindColumn(2, idx_url);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_eval_code);
      gpstatement.bindColumn(4, idx_eval_year);
      gpstatement.bindColumn(5, idx_eval_degree);
      gpstatement.bindColumn(6, idx_self_evaluator);
      stmt.executeUpdate();
      stmt.close();
      
       String d_self_evaluator  = rows.getString(idx_self_evaluator);
       String d_name  = rows.getString(idx_d_name_file); 
      
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_self_evaluator + d_name );
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close();		 
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>