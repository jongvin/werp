<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("progress_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT p_emp_degree.employ_degree," + 
     "             to_char(p_emp_degree.start_date,'YYYY.MM.DD') start_date," + 
     "             to_char(p_emp_degree.end_date,'YYYY.MM.DD') end_date," + 
     "             p_emp_degree.remark," + 
     "             p_emp_degree.progress_tag   FROM p_emp_degree         " +
     " ORDER BY employ_degree DESC ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>