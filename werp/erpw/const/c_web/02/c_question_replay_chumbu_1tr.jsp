<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
/*session.setAttribute("dir", "http://192.168.1.9:7778/werp/erpw/const/c_web/picture/");*/
session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/const/c_web/picture/");
String dir = (String) session.getAttribute("dir");
      GauceDataSet dSet = req.getGauceDataSet("c_question_replay_chumbu_1tr"); 
      gpstatement.gp_dataset = dSet;
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_d_name = dSet.indexOfColumn("name");
      GauceDataRow[] rowx = dSet.getDataRows();
      int  rowCnt = dSet.getDataRowCnt();
  for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	   if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
      
       String d_name  = rows.getString(idx_d_name);
       
       
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close(); 
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
  }
 }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>