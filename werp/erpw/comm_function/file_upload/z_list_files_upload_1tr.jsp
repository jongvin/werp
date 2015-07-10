<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*, com.oreilly.servlet.*, com.oreilly.servlet.multipart.* "%><%@ 
include file ="../conn_tr_pool.jsp"%><%

    MultipartRequest multi = null;
	int sizeLimit = 1024 * 1024 * 50;

    GauceDataSet dSet = req.getGauceDataSet("z_list_files_upload_1tr");
    gpstatement.gp_dataset = dSet;
   	int idx_file_number = dSet.indexOfColumn("file_number");
	int idx_job_code = dSet.indexOfColumn("job_code");
	int idx_intf_title = dSet.indexOfColumn("intf_title");
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

      String upload_dir = (String) session.getAttribute("file_upload_dir");
	  String dir_name = rows.getString(idx_dir_name); 
      String file_name = rows.getString(idx_filename); 

	  String file_path = upload_dir + dir_name + "\\"+ file_name;

	  File Ofile = new File(file_path);
      long Lsize = Ofile.length();
      String Sfile_name = Ofile.getName();
	  String Sfile_path   = Ofile.getPath();

      String sSql = " INSERT INTO Z_LIST_FILES_UPLOAD ( file_number," + 
                    "job_code," + 
		            "intf_title,"+
                    "parent_key," + 
                    "dir_name," + 
                    "filename," + 
                    "file_name_alias," + 
		            "file_path," + 
		            "file_type," + 
		            "file_size," + 
                    "note, save_date )      ";
      sSql = sSql + "  values( sq_z_list_files_upload.nextval , :1,:2, :3, :4, '"+Sfile_name+"', :5, '"+Sfile_path+"', :6,"+Lsize+", :7, sysdate )  "; 
      
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      //gpstatement.bindColumn(1, idx_file_number);
      gpstatement.bindColumn(1, idx_job_code);
	  gpstatement.bindColumn(2, idx_intf_title); 
      gpstatement.bindColumn(3, idx_parent_key);
      gpstatement.bindColumn(4, idx_dir_name);
      //gpstatement.bindColumn(5, idx_filename);
	  gpstatement.bindColumn(5, idx_file_name_alias);
	  gpstatement.bindColumn(6, idx_file_type);
	  //gpstatement.bindColumn(8, idx_file_size);
	  gpstatement.bindColumn(7, idx_note);
      stmt.executeUpdate();
      stmt.close();
     

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "update Z_LIST_FILES_UPLOAD set " + 
                            "file_name_alias=?,  " + 
                            "note=?  " + 
                            " where file_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_file_name_alias);
      gpstatement.bindColumn(2, idx_note);
      gpstatement.bindColumn(3, idx_file_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){

     String upload_dir = (String) session.getAttribute("file_upload_dir");
	 String dir_name = rows.getString(idx_dir_name); 
     String file_name = rows.getString(idx_filename); 

	 String file_path = upload_dir + dir_name + "\\"+ file_name;

     File Ofile = new File(file_path);

     //if (Ofile.exists()) { 
     Ofile.delete();

	 
	
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "delete Z_LIST_FILES_UPLOAD  " +
	                      " where file_number=?";
     stmt = conn.prepareStatement(sSql); 
     gpstatement.gp_stmt = stmt;
     gpstatement.bindColumn(1, idx_file_number);
     stmt.executeUpdate();
     stmt.close();
     
    }
     }
 %><%@ include file="../conn_tr_end.jsp"%>


