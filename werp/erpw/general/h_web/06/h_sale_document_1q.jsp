<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_from_date = req.getParameter("as_from_date");
     String as_to_date   = req.getParameter("as_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("issue_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("issue_document",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("issue_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("issuer",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("issue_reason",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("key_1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("key_2",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_3",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("key_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_5",GauceDataColumn.TB_STRING,18));
    String query = "select a.dept_code," + 
     "	   b.long_name," + 
     "	   a.sell_code," + 
     "	   a.dongho," + 
     "	   nvl(a.seq, 0) seq," + 
     "	   to_char(a.issue_date, 'yyyy.mm.dd') issue_date," + 
     "	   a.issue_document," + 
     "	   a.issue_no," + 
     "	   a.issuer," + 
     "	   a.issue_reason," + 
     "	   a.remark," + 
     "      a.dept_code key_1," + 
     "	   a.sell_code key_2," + 
     "	   a.dongho key_3," + 
     "	   nvl(a.seq, 0) key_4," + 
     "	   to_char(a.issue_date, 'yyyy.mm.dd') key_5" +
     "  from h_sale_document a," + 
     "       h_code_dept b" + 
     " where a.dept_code = b.dept_code" + 
     "   and a.issue_date between '" + as_from_date + "' and '" + as_to_date +    "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>