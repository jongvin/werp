<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("detail",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  sbcr_unq_num ," + 
					    "          seq ," + 
					    "          seq key_seq," + 
					    "          to_char(e_date,'YYYY.MM.DD') e_date ," + 
					    "          detail ," + 
					    "          remark  " +
					    "     FROM s_req_company_history " +
					    "    WHERE SBCR_UNQ_NUM = " + arg_unq_num +
					    " ORDER BY seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>