<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_parent_key = req.getParameter("arg_parent_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("file_number",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("job_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("parent_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("dir_name",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("filename",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_name_alias",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_path",GauceDataColumn.TB_STRING,256));
	 dSet.addDataColumn(new GauceDataColumn("file_type",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("file_size",GauceDataColumn.TB_DECIMAL,13));
	 dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_DECIMAL,13,0));
	String query =  " SELECT FILE_NUMBER, "+
	                      "              JOB_CODE, "+
						  "              PARENT_KEY, "+
						  "              DIR_NAME,  "+
						  "              FILENAME,  "+
						  "              FILE_NAME_ALIAS, "+ 
                          "              FILE_PATH, "+ 
						  "              FILE_TYPE,  "+
						  "              FILE_SIZE,   "+
                          "              NOTE "+
                          "    FROM Z_LIST_FILES_UPLOAD"+
						  "   where  parent_key = '"+ arg_parent_key+ "'";


%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>