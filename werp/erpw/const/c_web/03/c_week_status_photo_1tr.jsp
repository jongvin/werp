<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
session.setAttribute("dir", "C://bea//user_projects//domains//cjdwld//applications//werp//erpw//const//c_web//picture//");

//session.setAttribute("dir", "http://192.168.1.9:7778/werp/erpw/const/c_web/picture/");
//session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/const/c_web/picture/");
String dir = (String) session.getAttribute("dir");
     GauceDataSet dSet = req.getGauceDataSet("c_week_status_photo_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_week_date = dSet.indexOfColumn("week_date");
   	int idx_master_confirm = dSet.indexOfColumn("master_confirm");
   	int idx_a_this = dSet.indexOfColumn("a_this");
   	int idx_a_next = dSet.indexOfColumn("a_next");
   	int idx_c_this = dSet.indexOfColumn("c_this");
   	int idx_c_next = dSet.indexOfColumn("c_next");
   	int idx_l_this = dSet.indexOfColumn("l_this");
   	int idx_l_next = dSet.indexOfColumn("l_next");
   	int idx_e_this = dSet.indexOfColumn("e_this");
   	int idx_e_next = dSet.indexOfColumn("e_next");
   	int idx_m_this = dSet.indexOfColumn("m_this");
   	int idx_m_next = dSet.indexOfColumn("m_next");
   	int idx_t_this = dSet.indexOfColumn("t_this");
   	int idx_t_next = dSet.indexOfColumn("t_next");
   	int idx_main_this = dSet.indexOfColumn("main_this");
   	int idx_main_next = dSet.indexOfColumn("main_next");
   	int idx_problem_this = dSet.indexOfColumn("problem_this");
   	int idx_problem_next = dSet.indexOfColumn("problem_next");
   	int idx_photo_addr = dSet.indexOfColumn("photo_addr");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_photo_name = dSet.indexOfColumn("photo_name");
      GauceDataRow[] rowx = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
      String sSql = "update c_week_status set " + 
                            "dept_code=?,  " + 
                            "week_date=?,  " + 
                            "photo_addr=?  where dept_code=? and week_date=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      gpstatement.bindColumn(3, idx_photo_addr);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_week_date);
      stmt.executeUpdate();
      stmt.close();
      
      String d_name  = rows.getString(idx_photo_name);
       
       
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close();     
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_week_status set " + 
                            "dept_code=?,  " + 
                            "week_date=?,  " + 
                            "photo_addr=?  where dept_code=? and week_date=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      gpstatement.bindColumn(3, idx_photo_addr);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_week_date);
      stmt.executeUpdate();
      stmt.close();
      
      String d_name  = rows.getString(idx_photo_name);
       
       
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 FileOutputStream os = new FileOutputStream(dir + d_name);
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close();     
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_week_status where dept_code=? and week_date=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_week_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>