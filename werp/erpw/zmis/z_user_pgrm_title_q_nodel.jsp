<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_seq_key  = req.getParameter("arg_seq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL, 18, 0));
    String query = "  SELECT  count(z_user_pgrm_content.user_seq_key) tot_cnt    FROM z_user_pgrm_content " + 
                   "   WHERE ( z_user_pgrm_content.user_seq_key = " + arg_seq_key + " )       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>