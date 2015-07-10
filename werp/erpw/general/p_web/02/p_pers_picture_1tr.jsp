<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
/*session.setAttribute("dir", "http://192.168.1.9:8000/werp/erpw/const/c_web/picture/");*/
session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/general/p_web/picture/");
String dir = (String) session.getAttribute("dir");
      GauceDataSet dSet = req.getGauceDataSet("p_pers_picture_1tr"); 
      gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_update_date = dSet.indexOfColumn("update_date");
   	int idx_url = dSet.indexOfColumn("url");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_d_name = dSet.indexOfColumn("name");
      GauceDataRow[] rowx = dSet.getDataRows();
      int  rowCnt = dSet.getDataRowCnt();
  for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	   if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		  String sSql = " INSERT INTO p_pers_picture ( resident_no," + 
                    "update_date," + 
                    "url )      ";
      sSql = sSql + " VALUES ( :1, :2, :3) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_update_date);
      gpstatement.bindColumn(3, idx_url);
      stmt.executeUpdate();
      stmt.close(); 
      

       String d_resident_no = rows.getString(idx_resident_no);
       String d_name  = rows.getString(idx_d_name);
       
       
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_resident_no + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close(); 
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_picture set " + 
                            "resident_no=?,  " + 
                            "update_date=?,  " + 
                            "url=?  where (resident_no=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_update_date);
      gpstatement.bindColumn(3, idx_url);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_picture where (resident_no=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>