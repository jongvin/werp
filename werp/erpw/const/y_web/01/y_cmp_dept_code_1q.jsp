<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cmp_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("key_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.dept_code,   " + 
     "         a.no_seq,   " + 
     "         a.cmp_dept_code," + 
     "         b.long_name," + 
     "         a.no_seq key_no_seq  " + 
     "    FROM y_cmp_dept_code a," + 
     "         z_code_dept b" + 
     "   WHERE a.dept_code = '" + arg_dept_code + "' " + 
     "     and a.cmp_dept_code = b.dept_code (+)  " + 
     "   ORDER BY a.no_seq ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>