<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code  = req.getParameter("arg_dept_code");
     String arg_sell_code  = req.getParameter("arg_sell_code");
     String arg_union_code = req.getParameter("arg_union_code");
     String arg_union_id   = req.getParameter("arg_union_id");
     String arg_union_seq  = req.getParameter("arg_union_seq");
     String arg_pay_degree = req.getParameter("arg_pay_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("return_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("refund_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       UNION_CODE,   " + 
     "                       UNION_ID,   " + 
     "                       UNION_SEQ,   " + 
     "                       PAY_DEGREE,   " + 
     "                       DEGREE_SEQ,   " + 
     "                       to_char(RETURN_DATE,'YYYY.MM.DD') return_date,   " + 
     "                       REFUND_AMT  " + 
     "                  FROM H_UNIN_MOVE_REPAY  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   AND UNION_CODE = " + "'" + arg_union_code + "'" + 
     "                   AND UNION_ID = " + "'" + arg_union_id + "'" + 
     "                   AND UNION_SEQ = " + "'" + arg_union_seq + "'" + 
     "                   AND PAY_DEGREE = " + "'" + arg_pay_degree + "'" + 
     "              ORDER BY DEGREE_SEQ DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>