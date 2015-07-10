<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_code = req.getParameter("arg_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("plan_amt01",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt02",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt03",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt04",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt05",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt06",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt07",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt08",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt09",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt12",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt13",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt14",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt15",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("survey_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tender_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT nvl(a.PLAN_AMT01,0)   PLAN_AMT01," + 
     "                       nvl(a.PLAN_AMT02,0)   PLAN_AMT02," + 
     "                       nvl(a.PLAN_AMT03,0)   PLAN_AMT03," + 
     "                       nvl(a.PLAN_AMT04,0)   PLAN_AMT04," + 
     "                       nvl(a.PLAN_AMT05,0)   PLAN_AMT05," + 
     "                       nvl(a.PLAN_AMT06,0)   PLAN_AMT06," + 
     "                       nvl(a.PLAN_AMT07,0)   PLAN_AMT07," + 
     "                       nvl(a.PLAN_AMT08,0)   PLAN_AMT08," + 
     "                       nvl(a.PLAN_AMT09,0)   PLAN_AMT09," + 
     "                       nvl(a.PLAN_AMT10,0)   PLAN_AMT10," + 
     "                       nvl(a.PLAN_AMT11,0)   PLAN_AMT11," + 
     "                       nvl(a.PLAN_AMT12,0)   PLAN_AMT12," + 
     "                       nvl(a.PLAN_AMT13,0)   PLAN_AMT13," + 
     "                       nvl(a.PLAN_AMT14,0)   PLAN_AMT14," + 
     "                       nvl(a.PLAN_AMT15,0)   PLAN_AMT15," + 
     "                       nvl(a.RATE,0) RATE," + 
     "		                 b.name," + 
     "                       nvl(b.survey_amt,0) survey_amt," + 
     "		              	  to_char(b.tender_date,'YYYY.MM.DD') tender_date," + 
     "		              	  c.order_name" + 
     "    FROM R_TENDER_PLANAMT  a," + 
     "			R_RECEIVE_CODE b," + 
     "			R_CODE_ORDER c" + 
     "   WHERE b.order_no     = c.order_no (+)" + 
     "     AND a.RECEIVE_CODE = b.receive_code (+)" + 
     "     AND a.RECEIVE_CODE = " + "'" + arg_code + "'" + 
     "     AND a.COMP_DATE    = " + "'" + arg_date + "'" + 
     "                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>