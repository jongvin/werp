<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("guarantee_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("seal_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("membership_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.GUARANTEE_NO,   " + 
     "         a.ORDER_NO,   " + 
     "         a.SEAL_NO,   " + 
     "         a.CONST_NAME,   " + 
     "         to_char(a.CONST_START_DATE,'YYYY.MM.DD') CONST_START_DATE,   " + 
     "         to_char(a.CONST_END_DATE,'YYYY.MM.DD')   CONST_END_DATE, " + 
     "         a.CONST_AMT,   " + 
     "         a.REMARK,   " + 
     "         a.MEMBERSHIP_NO," + 
     "			b.order_name," + 
     "			c.membership_name  " + 
     "    FROM R_GENERAL_GUARANTEE_JOINT  a," + 
     "			r_code_order b," + 
     "			r_code_membership c" + 
     "   WHERE a.order_no = b.order_no (+) " +
     "    AND  a.membership_no = c.membership_no (+) " +
     "    AND  to_char(a.CONST_START_DATE,'YYYY') <= " + "'" + arg_year + "'" + 
     "	 AND  to_char(a.CONST_END_DATE,'YYYY') >= " + "'" + arg_year  + "'" + 
     " order by a.GUARANTEE_NO asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>