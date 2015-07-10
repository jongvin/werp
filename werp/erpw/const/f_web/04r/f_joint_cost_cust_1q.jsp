<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
    String query = "   SELECT a.cust_code,       " + 
				       "          b.cust_name        " +         
				       "     FROM f_uni_cont a,      " +
				       "          z_code_cust_code b " +  
				       "    WHERE a.cust_code = b.cust_code " +
				       "      AND a.dept_code = '" + arg_dept_code + "' " +
				       " ORDER BY a.company_tag desc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>