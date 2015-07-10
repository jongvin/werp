<%@ page session="true"  import="com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../conn_tr_pool.jsp"%><%

     GauceDataSet dSet = req.getGauceDataSet("z_list_files_upload_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_file_number = dSet.indexOfColumn("file_number");
	int idx_job_code = dSet.indexOfColumn("job_code");
	int idx_parent_key = dSet.indexOfColumn("parent_key");
	int idx_dir_name = dSet.indexOfColumn("dir_name");
	int idx_filename = dSet.indexOfColumn("filename");
	int idx_file_name_alias = dSet.indexOfColumn("file_name_alias");
	int idx_file_path = dSet.indexOfColumn("file_path");
	int idx_file_type = dSet.indexOfColumn("file_type");
	int idx_file_size = dSet.indexOfColumn("file_size");
	int idx_note = dSet.indexOfColumn("note");
	int idx_s_file = dSet.indexOfColumn("s_file");
   	
      GauceDataRow[] rowx = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
      String sSql = " INSERT INTO Z_LIST_FILES_UPLOAD ( file_number," + 
                    "job_code," + 
                    "parent_key," + 
                    "dir_name," + 
                    "filename," + 
                    "file_name_alias," + 
		            "file_path," + 
		            "file_type," + 
		            "file_size," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) "; 
    
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_file_number);
      gpstatement.bindColumn(2, idx_job_code);
      gpstatement.bindColumn(3, idx_parent_key);
      gpstatement.bindColumn(4, idx_dir_name);
      gpstatement.bindColumn(5, idx_filename);
	  gpstatement.bindColumn(6, idx_file_name_alias);
	  gpstatement.bindColumn(7, idx_file_path);
	  gpstatement.bindColumn(8, idx_file_type);
	  gpstatement.bindColumn(9, idx_file_size);
	  gpstatement.bindColumn(10, idx_bigo);
      stmt.executeUpdate();
      stmt.close();
      
     /* String d_name  = rows.getString(idx_filename);
       
      InputStream is = (InputStream) rowx[i].getInputStream(idx_s_file);

	  FileOutputStream os = new FileOutputStream(dir + d_name);
	  	 CommonUtil.copy(is, os);
	  	 is.close();
	   	 os.close();     
 */
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     
    }
     }
 %><%@ include file="../conn_tr_end.jsp"%>