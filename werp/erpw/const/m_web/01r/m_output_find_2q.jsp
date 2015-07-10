<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 
      String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     "          	      b.long_name ," + 
     "          	      to_char(a.yymmdd, 'yyyy.mm.dd') yymmdd ," + 
     "          	      a.seq " +
     "                  FROM m_input a, z_code_dept b	" +
     "                 WHERE a.dept_code = b.dept_code(+) " +
     "                   and inouttypecode = '3'  " +
	  "						 and long_name like '"+arg_name+ "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>