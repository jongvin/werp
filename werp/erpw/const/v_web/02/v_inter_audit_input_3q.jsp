<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_part_code = req.getParameter("arg_part_code");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("point",GauceDataColumn.TB_NUMBER,3));
	 String query = "  SELECT part_code,   " + 
     "         seq , " + 
     "         d_seq , " + 
	  "         contents , " + 
     "         point  " + 
     "    FROM V_INTER_AUDIT_DETAIL  " + 
     "   WHERE  part_code = '"+ arg_part_code +"'" + 
	  "	and seq = " + arg_seq +	" "+
	  "   order by point desc "; 
	  
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>