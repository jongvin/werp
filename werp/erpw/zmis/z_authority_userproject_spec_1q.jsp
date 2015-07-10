<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_empno = req.getParameter("arg_empno");
     String arg_proj_unq_key = req.getParameter("arg_proj_unq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.empno,   " + 
     "         a.proj_unq_key,   " + 
     "         a.spec_no_seq," + 
     "         b.name" + 
     "    FROM z_authority_userproject_spec a," + 
     "         r_a_code_cash_parent b" + 
     "    where a.empno = '" + arg_empno + "' " + 
     "      and a.proj_unq_key =  " + arg_proj_unq_key + "  " + 
     "      and a.spec_no_seq = b.spec_no_seq " + 
     "    order by b.sum_code     ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>