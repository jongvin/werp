<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("comp_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_comp_date",GauceDataColumn.TB_STRING,18));
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
     dSet.addDataColumn(new GauceDataColumn("choice_tag01",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag02",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag03",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag04",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag05",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag06",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag07",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag08",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag09",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag10",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag11",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag12",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag13",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag14",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_tag15",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tender_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("survey_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.RECEIVE_CODE," + 
     "                       to_char(a.COMP_DATE,'YYYY.MM.DD') comp_date," + 
     "                       to_char(a.COMP_DATE,'YYYY.MM.DD')   key_comp_date," + 
     "                       NVL(a.PLAN_AMT01,0) PLAN_AMT01," + 
     "                       NVL(a.PLAN_AMT02,0) PLAN_AMT02," + 
     "                       NVL(a.PLAN_AMT03,0) PLAN_AMT03," + 
     "                       NVL(a.PLAN_AMT04,0) PLAN_AMT04," + 
     "                       NVL(a.PLAN_AMT05,0) PLAN_AMT05," + 
     "                       NVL(a.PLAN_AMT06,0) PLAN_AMT06," + 
     "                       NVL(a.PLAN_AMT07,0) PLAN_AMT07," + 
     "                       NVL(a.PLAN_AMT08,0) PLAN_AMT08," + 
     "                       NVL(a.PLAN_AMT09,0) PLAN_AMT09," + 
     "                       NVL(a.PLAN_AMT10,0) PLAN_AMT10," + 
     "                       NVL(a.PLAN_AMT11,0) PLAN_AMT11," + 
     "                       NVL(a.PLAN_AMT12,0) PLAN_AMT12," + 
     "                       NVL(a.PLAN_AMT13,0) PLAN_AMT13," + 
     "                       NVL(a.PLAN_AMT14,0) PLAN_AMT14," + 
     "                       NVL(a.PLAN_AMT15,0) PLAN_AMT15," + 
     "                       a.CHOICE_TAG01," + 
     "                       a.CHOICE_TAG02," + 
     "                       a.CHOICE_TAG03," + 
     "                       a.CHOICE_TAG04," + 
     "                       a.CHOICE_TAG05," + 
     "                       a.CHOICE_TAG06," + 
     "                       a.CHOICE_TAG07," + 
     "                       a.CHOICE_TAG08," + 
     "                       a.CHOICE_TAG09," + 
     "                       a.CHOICE_TAG10," + 
     "                       a.CHOICE_TAG11," + 
     "                       a.CHOICE_TAG12," + 
     "                       a.CHOICE_TAG13," + 
     "                       a.CHOICE_TAG14," + 
     "                       a.CHOICE_TAG15," + 
     "                       nvl(a.RATE,0) rate," + 
     " 			              b.name      ," +
     "                       to_char(b.tender_date,'YYYY.MM.DD') tender_date, " +
     "                       nvl(b.survey_amt,0) survey_amt, " +
     "                       c.order_name " +
     "                  FROM R_TENDER_PLANAMT  a," + 
     "              			  R_RECEIVE_CODE b,    " +
     "                       r_code_order c " +
     "                 WHERE b.order_no = c.order_no (+) " +
     "                   and a.RECEIVE_CODE = b.receive_code (+) " +
     "              order by a.comp_date desc," + 
     "                       a.receive_code asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>