<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_key = req.getParameter("arg_group_key");
     String arg_user_key = req.getParameter("arg_user_key");
     String arg_emp_name = req.getParameter("arg_emp_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("user_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("group_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("string_user_key",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,5,0));
    String query = "  SELECT  z_user.user_key user_key ," + 
     "          z_user.user_name user_name," + 
     "          z_authority_user.name name," + 
     "          z_user.empno empno," + 
     "          z_code_dept.long_name long_name,   " + 
     "          z_user.group_key group_key, " + 
     "          z_user.empno key_empno, " + 
     "          to_char(z_user.user_key) string_user_key, " + 
     "          z_user.no_seq " +
     "         FROM z_authority_user ," + 
     "              z_user ," + 
     "              z_code_dept,  " + 
     "				  z_user_group  " + 
     "         WHERE z_user.empno = z_authority_user.empno  " + 
     "           and z_authority_user.dept_code = z_code_dept.dept_code(+)  " + 
     "           and z_user.user_key = z_user_group.user_key(+) " +
     "           and z_user.group_key = " + arg_group_key + "    " + 
     "           and (z_user.user_key = " + arg_user_key + "  or 0 = " + arg_user_key + " )   " ;
      
      if(! arg_emp_name.equals("")) {   //검색조건으로 찾기 
		   query += " and z_authority_user.name like '" + arg_emp_name + "' ";
		}
		
     query += " ORDER BY  z_authority_user.name, z_user_group.user_group_name   ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>