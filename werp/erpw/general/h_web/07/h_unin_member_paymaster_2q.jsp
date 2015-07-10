<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_union_code = req.getParameter("arg_union_code");
     String arg_union_id = req.getParameter("arg_union_id");
     String arg_union_seq = req.getParameter("arg_union_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("int_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("month_interest",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("interest_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("payer_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("interest_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("repay_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       UNION_CODE,   " + 
     "                       UNION_ID,   " + 
     "                       UNION_SEQ,   " + 
     "                       PAY_DEGREE,   " + 
     "                       to_char(PAY_DATE,'YYYY.MM.DD') pay_date,   " + 
     "                       PAY_AMT,   " + 
     "                       INT_DIV,   " + 
     "                       MONTH_INTEREST,   " + 
     "                       INTEREST_DAY,   " + 
     "                       TOT_AMT,   " + 
     "                       F_PAY_YN,  " + 
     "                       PAYER_TAG,  " + 
     "                       INTEREST_RATE,  " + 
     "                       BANK_NAME,  " + 
     "                       to_char(REPAY_DATE,'YYYY.MM.DD') repay_date  " + 
     "                  FROM H_UNIN_MOVE_PAY  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   AND UNION_CODE = " + "'" + arg_union_code + "'" + 
     "                   AND UNION_ID = " + "'" + arg_union_id + "'" + 
     "                   AND UNION_SEQ = " + "'" + arg_union_seq + "'" + 
     "              ORDER BY PAY_DEGREE DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>