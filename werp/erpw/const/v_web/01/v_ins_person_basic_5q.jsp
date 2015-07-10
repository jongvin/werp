<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("obtain_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("licenss_item",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("reg_number",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("issue_organ",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.emp_no,													" + 
     "                       a.seq,														" + 
     "                       to_char(a.obtain_dt, 'yyyy.mm.dd') obtain_dt,  	" + 
     "                       a.licenss_item,											" + 
     "                       a.reg_number,											" + 
     "                       a.issue_organ,											" + 
     "                       a.grade,													" + 
     "                       a.remark        										" +
     "						FROM v_ip_license a   										" +
     "                 WHERE a.emp_no = '" + arg_emp_no + "'      			" +
     "				  ORDER BY a.emp_no ASC,											" + 
     "                       a.seq ASC         										";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>