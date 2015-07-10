<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
       String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("rank_code",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("key_1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("key_2",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("draw_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
    String query = "select dept_code," + 
     "       rank_code," + 
	 "       dept_code key_1," + 
     "       rank_code key_2," + 
     "       to_char(draw_date,'yyyy.mm.dd') draw_date," + 
     "		 to_char(refund_date,'yyyy.mm.dd') refund_date," + 
     "		 to_char(contract_date,'yyyy.mm.dd') contract_date" + 
     "  from h_subs_regist" + 
        " where dept_code = '" + arg_dept_code + "'" +
	 " order by rank_code" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>