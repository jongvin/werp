<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("cy_amount",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("py_amount",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  " + 
                 " select a.account_name,  " +  
                 "        a.cy_amount,  " +  
                 "        a.py_amount  " +  
                 " from efin_eis_is_ytd a " + 
                 " where group_id = '" + arg_group_id+"'" + 
                 " order by a.account_seq  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>