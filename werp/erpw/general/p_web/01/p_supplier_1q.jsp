<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("inco_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("inco_num",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("resi_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("resi_num",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("pens_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("pens_num",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("medi_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("medi_num",GauceDataColumn.TB_STRING,15));
    String query = "  SELECT  comp_code ,  " + 
     "         				   inco_name ,  " +
     "         				   inco_num ,  " +
     "         				   resi_name ,  " +
     "         				   resi_num ,  " +
     "         				   pens_name ,  " +
     "         				   pens_num ,  " +
     "         				   medi_name ,  " +
     "         				   medi_num   " +
     "			  			 FROM p_code_supplier     " +
     "               order by comp_code   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>