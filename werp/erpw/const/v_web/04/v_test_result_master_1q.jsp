<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("v_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("status",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("status1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("feed_back",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("outline",GauceDataColumn.TB_STRING,1000));

    String query = "  SELECT to_char(a.yymm,	'yyyymmdd') yymm,					" + 
     "                       to_char(a.yymm,	'yyyy.mm') v_yymm,				" +
     "                       a.status,													" +
     "                       decode(a.status,1,'�ۼ���',2,'Ȯ��')	status1, " +
     "                       a.feed_back,												" + 
     "                       a.remark ,       										" +
     "                       a.outline        										" +
     "                  FROM v_test_result_master a   							" +
	  "			  where a.yymm in ( select yymm from v_test_result )		" +
     "              ORDER BY a.yymm DESC         									";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>