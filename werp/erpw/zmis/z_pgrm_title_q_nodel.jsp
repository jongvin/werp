<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_seq_key  = req.getParameter("arg_seq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL, 18, 0));
    String query = "  SELECT  count(z_pgrm_content.pgrm_above_key) tot_cnt    FROM z_pgrm_content " + 
                   "   WHERE ( z_pgrm_content.pgrm_above_key = " + arg_seq_key + " )       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>