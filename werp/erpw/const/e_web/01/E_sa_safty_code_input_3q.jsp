<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%>
<%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class_tag = req.getParameter("arg_class_tag");
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("safety_code",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("child_name",GauceDataColumn.TB_STRING,50));
      dSet.addDataColumn(new GauceDataColumn("tmp_code",GauceDataColumn.TB_STRING,30));

    String query = " select											" +
				   " class_tag , safety_code , child_name,			" +
				   " substr(safety_code,3,2) as tmp_code			" +
				   " from e_safety_code_child						" +  
				   " where class_tag in ("+ arg_class_tag +  ") and " +
				   " substr(safety_code,0,2) = '" + arg_code +	  "'" +
				   " order by safety_code asc						" ;

%>
<%@
include file="../../../comm_function/conn_q_end.jsp"%>