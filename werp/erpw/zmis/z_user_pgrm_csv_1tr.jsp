<%@ page session="true" contentType="text/html;charset=EUC_KR" import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_tr_pool.jsp"%><%
     session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/menu/"); 
     String dir = (String) session.getAttribute("dir");
      GauceDataSet dSet = req.getGauceDataSet("z_user_pgrm_csv_1tr");
      gpstatement.gp_dataset = dSet;
      GauceDataRow[] rowx = dSet.getDataRows();
    	GauceDataRow rows = dSet.getDataRow(0); 
      gpstatement.gp_row = 0;
   	int idx_cdir = dSet.indexOfColumn("cdir");
      int idx_name = dSet.indexOfColumn("name");
       String d_name  = rows.getString(idx_name);
		 InputStream is = (InputStream) rowx[0].getInputStream(idx_cdir);
		 FileOutputStream os = new FileOutputStream(dir + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close(); 
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>