<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_degree = req.getParameter("arg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_NUMBER,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("closing_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  b.employ_degree ," + 
     "          a.interview_degree ," + 
     "          a.remark,      " +
     "          a.closing_tag      " +
     "    FROM p_emp_inter_degree a, p_emp_degree b    " +
     "  where a.employ_degree = b.employ_degree  and  " +
     "        b.employ_degree = '" + arg_degree   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>