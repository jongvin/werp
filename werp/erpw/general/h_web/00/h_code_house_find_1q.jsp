<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
	  String arg_prog = req.getParameter("arg_prog");
	  String arg_empno     = req.getParameter("arg_empno");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  b.dept_code ," + 
     "                        b.long_name ," + 
     "                        a.sell_code, " +
     "                        c.code_name  " + 
     "                   FROM h_code_house a, " +
     "                        h_code_dept b, " + 
     "                        h_code_common c " + 
     "                  WHERE a.dept_code = b.dept_code " +
     "                    and c.code_div = '03' " +
     "                    and a.sell_code = c.code " +
     "                    and ( b.long_name like " + "'" + arg_dept_name + "'" + 
     "                     or   b.dept_code like " + "'" + arg_dept_code + "'" + " )  " +
	  "                    and nvl(b.process_code, ' ') like decode( '"+arg_prog+"', 'Y' , '01', '%') "+
	  "						  and (a.dept_code in (select dept_code "+
	  "																              from z_authority_userprojcode"+
	  "																           where empno = '"+arg_empno+"')"+
	  "						           or ( "+
	  "							               (select count(*) "+
	  "								                from z_authority_userprojcode  "+
	  "								             where empno = '"+arg_empno+"') = 0	  "+
	  "								          and																					  "+
	  "								            a.dept_code like '%'											  "+
	  "							 )																														"+
	  "					  )																																 "+
	  "               order by b.long_name asc     " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>