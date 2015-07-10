<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
/*session.setAttribute("dir", "http://192.168.1.9:8000/werp/erpw/const/c_web/picture/");*/
session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/const/c_web/picture/");
String dir = (String) session.getAttribute("dir");
      GauceDataSet dSet = req.getGauceDataSet("c_prgs_picture_1tr"); 
      gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_c_unq_num = dSet.indexOfColumn("c_unq_num");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_url = dSet.indexOfColumn("url");
   	int idx_memo = dSet.indexOfColumn("memo");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_d_name = dSet.indexOfColumn("name");
      GauceDataRow[] rowx = dSet.getDataRows();
      int  rowCnt = dSet.getDataRowCnt();
  for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	   if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		  String sSql = " INSERT INTO c_prgs_picture ( dept_code," + 
                    "c_unq_num," + 
                    "yymmdd," + 
                    "spec_no_seq," + 
                    "url," + 
                    "memo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 , :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_c_unq_num);
      gpstatement.bindColumn(3, idx_yymmdd);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_url);
      gpstatement.bindColumn(6, idx_memo);
      stmt.executeUpdate();
      stmt.close(); 
      

       String d_dept_code = rows.getString(idx_dept_code);
       String d_c_unq_num  = rows.getString(idx_c_unq_num);
       String d_name  = rows.getString(idx_d_name);
       
       
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_dept_code + "_" + d_c_unq_num + "_" + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close(); 
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_prgs_picture set " + 
                            "dept_code=?,  " + 
                            "c_unq_num=?,  " + 
                            "yymmdd=?,  " + 
                            "spec_no_seq=?,  " + 
                            "url=?,  " + 
                            "memo=?  where (dept_code=? and c_unq_num=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_c_unq_num);
      gpstatement.bindColumn(3, idx_yymmdd);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_url);
      gpstatement.bindColumn(6, idx_memo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_c_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_prgs_picture where (dept_code=? and c_unq_num=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_c_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>