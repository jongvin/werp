<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_sido = req.getParameter("arg_sido");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("zipcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sido",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("gugun",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,43));
     dSet.addDataColumn(new GauceDataColumn("bunji",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  z_code_zip.seq ," + 
     "          z_code_zip.zipcode ," + 
     "          z_code_zip.sido ," + 
     "          z_code_zip.gugun ," + 
     "          z_code_zip.dong ," + 
     "          z_code_zip.bunji ," + 
     "          z_code_zip.remark     FROM z_code_zip        " + 
     "          where z_code_zip.sido = '" + arg_sido + "'      " + 
     "         order by z_code_zip.zipcode " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>