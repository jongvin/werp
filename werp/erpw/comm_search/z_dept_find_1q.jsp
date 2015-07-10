<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_empno     = req.getParameter("arg_empno");
     String arg_authority_dept = req.getParameter("arg_authority_dept");
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
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,10,0));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  view_dept_code.dept_code ," + 
     "          view_dept_code.comp_code ," +
     "          view_dept_code.comp_name ," + 
     "          view_dept_code.level_code ," + 
     "          view_dept_code.long_name ," + 
     "          view_dept_code.dept_proj_tag ," + 
     "          view_dept_code.use_tag,  " + 
     "          view_dept_code.process_code,  " + 
     "          view_dept_code.degree, " + 
     "          view_dept_code.proj_unq_key " + 
     "     FROM view_dept_code,  ";
     if ( arg_authority_dept.equals("A") ) {
     	   query = query + " z_authority_user " ;
     }
     else  {   
     	   query = query + " z_authority_userprojcode " ;
     }	   
     query = query + " " + 
     "     WHERE (( view_dept_code.long_name like " + "'" + arg_dept_name + "'" + ") " +  
     "          or  ( view_dept_code.dept_code like " + "'" + arg_dept_code + "'" + " ))  and     " + 
     "            ( view_dept_code.dept_proj_tag = 'P' )    and  ";
     if ( arg_authority_dept.equals("0") ) {
     	   query = query + " z_authority_userprojcode.empno(+) = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_userprojcode.dept_code(+) " ;
     }
     else if ( arg_authority_dept.equals("A") ) {
     		query = query + " z_authority_user.empno = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_user.dept_code " ;
     	 
     }
     else 
     {
     		query = query + " z_authority_userprojcode.empno = '" + arg_empno + "' and  " +
     		                " view_dept_code.dept_code = z_authority_userprojcode.dept_code " ;
     	}
     query = query + "         order by   view_dept_code.dept_code      " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>