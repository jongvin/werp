<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_parent_key = req.getParameter("arg_parent_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("file_number",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("job_code",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("intf_title",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("parent_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("dir_name",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("filename",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_name_alias",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_path",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_type",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("file_size",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("s_file",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("save_date1",GauceDataColumn.TB_STRING,10));
	String query =  " SELECT FILE_NUMBER, "+
	                      "              JOB_CODE, "+
						  "              INTF_TITLE,"+
						  "              PARENT_KEY, "+
						  "              DIR_NAME,  "+
						  "              FILENAME,  "+
						  "              FILE_NAME_ALIAS, "+ 
                          "              FILE_PATH, "+ 
						  "              FILE_TYPE,  "+
						  "              FILE_SIZE,   "+
                          "              NOTE, "+
						  "              to_char(save_date,'yyyy.mm.dd') save_date1, "+
						  "          ' '   s_file"+
                          "    FROM Z_LIST_FILES_UPLOAD"+
						  "   where  parent_key = '"+ arg_parent_key+ "' order by save_date desc";


%><%@ 
include file="../conn_q_end.jsp"%>