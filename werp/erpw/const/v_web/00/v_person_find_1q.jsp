<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
     String arg_not_in = req.getParameter("arg_not_in");

     arg_name = "%" + arg_name + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("position_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));

    String query = " select  " +
						"		position , " +
						"		decode(position,1,'감사원',2,'선임감사원') position_name , " +
						"		emp_no , " +
						"		name  " +
						" from v_ins_person " +
						" where name like '"+ arg_name + "'"  + 
						"       and emp_no not in (' '" + arg_not_in + ") " +
						" ORDER BY position ASC " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>