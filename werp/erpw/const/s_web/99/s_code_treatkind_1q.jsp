<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)-
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("treatkind_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("treatkind_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("key_treatkind_code",GauceDataColumn.TB_STRING,30));    // key�� update�ϱ����� ����key
    String query = "  SELECT  s_code_treatkind.treatkind_code ," + 
     "          s_code_treatkind.treatkind_name, " +
     "	    s_code_treatkind.treatkind_code key_treatkind_code " +  // key�� update�ϱ����� ����key
     "    FROM s_code_treatkind " +
     "      ORDER BY s_code_treatkind.treatkind_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>