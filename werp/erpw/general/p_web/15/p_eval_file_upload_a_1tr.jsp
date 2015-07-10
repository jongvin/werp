<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
session.setAttribute("dir", "/appdata/wiseadon/iAS/9.0.4/j2ee/werp/applications/werp/werp/erpw/general/p_web/file/");
String dir = (String) session.getAttribute("dir");
	  GauceDataSet dSet = req.getGauceDataSet("p_eval_file_upload_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_file_code = dSet.indexOfColumn("file_code");
   	int idx_self_comp_code = dSet.indexOfColumn("self_comp_code");
   	int idx_self_dept_code = dSet.indexOfColumn("self_dept_code");
   	int idx_self_grade_code = dSet.indexOfColumn("self_grade_code");
   	int idx_fir_evaluator = dSet.indexOfColumn("fir_evaluator");
   	int idx_fir_comp_code = dSet.indexOfColumn("fir_comp_code");
   	int idx_fir_dept_code = dSet.indexOfColumn("fir_dept_code");
   	int idx_fir_grade_code = dSet.indexOfColumn("fir_grade_code");
   	int idx_sec_evaluator = dSet.indexOfColumn("sec_evaluator");
   	int idx_sec_comp_code = dSet.indexOfColumn("sec_comp_code");
   	int idx_sec_dept_code = dSet.indexOfColumn("sec_dept_code");
   	int idx_sec_grade_code = dSet.indexOfColumn("sec_grade_code");
   	int idx_write_date = dSet.indexOfColumn("write_date");
   	int idx_url = dSet.indexOfColumn("url");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_file_name = dSet.indexOfColumn("file_name");
   	int idx_d_name_file = dSet.indexOfColumn("name_file");      
      GauceDataRow[] rowx = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_file_upload ( eval_code," + 
                    "eval_degree," + 
                    "self_evaluator," + 
                    "file_code," + 
                    "self_comp_code," + 
                    "self_dept_code," + 
                    "self_grade_code," + 
                    "fir_evaluator," + 
                    "fir_comp_code," + 
                    "fir_dept_code," + 
                    "fir_grade_code," + 
                    "sec_evaluator," + 
                    "sec_comp_code," + 
                    "sec_dept_code," + 
                    "sec_grade_code," + 
                    "write_date," + 
                    "url )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, TO_DATE(:16,'yyyy.mm.dd hh24:mi:ss'), :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_file_code);
      gpstatement.bindColumn(5, idx_self_comp_code);
      gpstatement.bindColumn(6, idx_self_dept_code);
      gpstatement.bindColumn(7, idx_self_grade_code);
      gpstatement.bindColumn(8, idx_fir_evaluator);
      gpstatement.bindColumn(9, idx_fir_comp_code);
      gpstatement.bindColumn(10, idx_fir_dept_code);
      gpstatement.bindColumn(11, idx_fir_grade_code);
      gpstatement.bindColumn(12, idx_sec_evaluator);
      gpstatement.bindColumn(13, idx_sec_comp_code);
      gpstatement.bindColumn(14, idx_sec_dept_code);
      gpstatement.bindColumn(15, idx_sec_grade_code);
      gpstatement.bindColumn(16, idx_write_date);
      gpstatement.bindColumn(17, idx_url);
      stmt.executeUpdate();
      stmt.close();
      
       String d_self_evaluator  = rows.getString(idx_self_evaluator);
       String d_file_name  = rows.getString(idx_file_name);
       String d_name  = rows.getString(idx_d_name_file); 
      
		 InputStream is = (InputStream) rowx[i].getInputStream(idx_cdir);

		 /*FileOutputStream os = new FileOutputStream(dir + d_self_evaluator + '_' + d_file_name +  d_name );*/
		 FileOutputStream os = new FileOutputStream(dir + d_self_evaluator +  d_name );
		 CommonUtil.copy(is, os);
		 is.close();
		 os.close();
		 		 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_file_upload set " + 
                            "eval_code=?,  " + 
                            "eval_degree=?,  " + 
                            "self_evaluator=?,  " + 
                            "file_code=?,  " + 
                            "self_comp_code=?,  " + 
                            "self_dept_code=?,  " + 
                            "self_grade_code=?,  " + 
                            "fir_evaluator=?,  " + 
                            "fir_comp_code=?,  " + 
                            "fir_dept_code=?,  " + 
                            "fir_grade_code=?,  " + 
                            "sec_evaluator=?,  " + 
                            "sec_comp_code=?,  " + 
                            "sec_dept_code=?,  " + 
                            "sec_grade_code=?,  " + 
                            "write_date=TO_DATE(?,'yyyy.mm.dd hh24:mi:ss'),  " + 
                            "url=?  where eval_code=?, eval_degree=?, self_evaluator=?, file_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_file_code);
      gpstatement.bindColumn(5, idx_self_comp_code);
      gpstatement.bindColumn(6, idx_self_dept_code);
      gpstatement.bindColumn(7, idx_self_grade_code);
      gpstatement.bindColumn(8, idx_fir_evaluator);
      gpstatement.bindColumn(9, idx_fir_comp_code);
      gpstatement.bindColumn(10, idx_fir_dept_code);
      gpstatement.bindColumn(11, idx_fir_grade_code);
      gpstatement.bindColumn(12, idx_sec_evaluator);
      gpstatement.bindColumn(13, idx_sec_comp_code);
      gpstatement.bindColumn(14, idx_sec_dept_code);
      gpstatement.bindColumn(15, idx_sec_grade_code);
      gpstatement.bindColumn(16, idx_write_date);
      gpstatement.bindColumn(17, idx_url);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_eval_code);
      gpstatement.bindColumn(19, idx_eval_degree);
      gpstatement.bindColumn(20, idx_self_evaluator);
      gpstatement.bindColumn(21, idx_file_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_file_upload where eval_code=?, eval_degree=?, self_evaluator=?, file_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_file_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>