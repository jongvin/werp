<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
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
     "                       decode(a.status,1,'작성중',2,'확정')	status1, " +
     "                       a.feed_back,												" + 
     "                       a.remark ,       										" +
     "                       a.outline        										" +
     "                  FROM v_test_result_master a   							" +
	  "			  where a.yymm in ( select yymm from v_test_result )		" +
     "              ORDER BY a.yymm DESC         									";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>