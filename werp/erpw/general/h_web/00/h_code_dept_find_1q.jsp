<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  dept_code ," + 
     "                        long_name ," + 
     "                        addr1,  " + 
     "                        addr2  " + 
     "                   FROM h_code_dept  " + 
     "                  WHERE ( long_name like " + "'" + arg_dept_name + "'" + 
     "                     or   dept_code like " + "'" + arg_dept_code + "'" + " )  " +
     "               order by dept_code asc     " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>