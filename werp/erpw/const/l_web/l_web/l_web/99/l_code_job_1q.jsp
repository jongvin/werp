<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("job_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_text",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  l_code_job.job_code ," + 
     "          l_code_job.job_name ," + 
     "          l_code_job.unitcost  ," +
     "         '' comp_text " +
     "   FROM l_code_job        " + 
     "   ORDER BY  l_code_job.job_code        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>