<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("loan_request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_sol_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_duty_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("loan_duty_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.BANK_HEAD_CODE,   " + 
     "                       to_char(a.LOAN_REQUEST_DATE,'YYYY.MM.DD') loan_request_date,   " + 
     "                       a.LOAN_REQUEST_AMT,   " + 
     "                       to_char(a.GUARANTEE_SOL_DATE,'YYYY.MM.DD') guarantee_sol_date,   " + 
     "                       a.LOAN_DUTY_NAME,   " + 
     "                       a.LOAN_DUTY_PHONE,   " + 
     "                       a.REMARK ,  " + 
     "                       b.bank_main_name bank_head_name" +
     "                  FROM H_SALE_LOAN a , " + 
     "							  t_bank_main b " +
     "                 WHERE ( a.bank_head_code = b.bank_main_code (+) ) AND " +
     "                       ( a.dept_code = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( a.sell_code = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( a.DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( a.SEQ = " + "'" + arg_seq + "'" + " )         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>