<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("a",GauceDataColumn.TB_STRING,1));
    String query = "SELECT 'A' a 		" +
					    "  from dual	"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>