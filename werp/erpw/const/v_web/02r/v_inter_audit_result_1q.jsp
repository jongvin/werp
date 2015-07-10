<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_half_year = req.getParameter("arg_half_year");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));


    String query = " select  " +
						"	   part_code , " +
						"	   part_name " +
						"from v_inter_audit_result_master " +
						"where to_char(year,'yyyy') = '" +arg_year+ "' " +
						"     and half_year = '" +arg_half_year+ "' ";

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>