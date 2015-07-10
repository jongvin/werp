<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	 String arg_comp_code1 = req.getParameter("arg_comp_code");     
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_comp_code  = arg_comp_code1.replace('^','%') ;  // ^를 %로 바꿈. url에서는 %를 값으로 넘겨줄수 없으므로  
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,10));
    String query = "  SELECT  view_dept_code.dept_code ," + 
     "          view_dept_code.comp_code ," + 
     "          view_dept_code.comp_name ," + 
     "          view_dept_code.level_code ," + 
     "          view_dept_code.long_name ," + 
     "          view_dept_code.dept_proj_tag ," + 
     "          view_dept_code.use_tag,  " + 
     "          view_dept_code.process_code,  " + 
     "          view_dept_code.degree " +
     "     FROM view_dept_code  " + 
     "     ORDER BY comp_code, title_name, long_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>