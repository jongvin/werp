<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("chg_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.sbcr_code,   " + 
     					"          c.sbcr_name,   " + 
     					"          a.CHG_AMT  " + 
     					"     FROM M_VENDER_EST a,   " + 
     					"          s_sbcr  c" + 
     					"    WHERE c.sbcr_code = a.sbcr_code " + 
     					"      and a.estimateyymm = '" + arg_date + "'"  + 
     					"      and a.estimateseq = " + arg_seq + 
     					"      and a.CHOICETAG = 'Y' " + 
     					" ORDER BY c.sbcr_code  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>