<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_no = req.getParameter("arg_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("guarantee_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_guarantee_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_kind",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("guarantee_timeamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amtchange",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_demand_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT GUARANTEE_NO,   " + 
     "         GUARANTEE_TIME,   " + 
     "         GUARANTEE_TIME  key_guarantee_time,   " + 
     "         GUARANTEE_KIND,   " + 
     "         GUARANTEE_TIMEAMT,   " + 
     "         GUARANTEE_AMTCHANGE,   " + 
     "         to_char(GUARANTEE_DEMAND_DATE,'YYYY.MM.DD')  GUARANTEE_DEMAND_DATE " + 
     "    FROM R_GENERAL_GUARANTEE_HISTORY  " + 
     "   WHERE GUARANTEE_NO = " + "'" + arg_no  + "'" + 
     " ORDER BY GUARANTEE_TIME ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>