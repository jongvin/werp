<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("issue_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("commission",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inspect_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("creditor",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("status",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cancel_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("refund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("duty_id",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SEQ,   " + 
     "                       SEQ  key_seq,   " + 
     "                       KIND,   " + 
     "                       to_char(ISSUE_DATE,'YYYY.MM.DD') ISSUE_DATE,  " + 
     "                       AMT,   " + 
     "                       COMMISSION,   " + 
     "                       to_char(INSPECT_DATE,'YYYY.MM.DD')   INSPECT_DATE, " + 
     "                       CREDITOR,   " + 
     "                       STATUS,   " + 
     "                       to_char(CANCEL_DATE,'YYYY.MM.DD')  CANCEL_DATE, " + 
     "                       REFUND_AMT,   " + 
     "                       DUTY_ID  " + 
     "                  FROM H_DEPT_GUARANTEE  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code  + "'" + 
     "              ORDER BY SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>