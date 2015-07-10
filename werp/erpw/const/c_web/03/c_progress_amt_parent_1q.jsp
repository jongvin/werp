<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("progress_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  c_progress_amt_parent.dept_code ," + 
     "          c_progress_amt_parent.progress_cnt ," + 
     "          to_char(c_progress_amt_parent.request_date,'yyyy.mm.dd') request_date," + 
     "          c_progress_amt_parent.request_amt ," + 
     "          c_progress_amt_parent.request_vat ," + 
     "          c_progress_amt_parent.bigo  " + 
     "      FROM c_progress_amt_parent  " + 
     "      WHERE ( c_progress_amt_parent.dept_code = '" + arg_dept_code + "' )   " + 
     "      ORDER BY c_progress_amt_parent.progress_cnt ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>