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
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("agree_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       a.DEGREE_CODE  key_degree_code,   " + 
     "                 		  b.code_name," + 
     "                       to_char(a.AGREE_DATE,'YYYY.MM.DD') agree_date, " + 
     "                       nvl(a.AGREE_AMT,0) agree_amt,   " + 
     "                       a.F_PAY_YN,   " + 
     "                       nvl(a.TOT_AMT,0) tot_amt   " + 
     "                  FROM H_SALE_ONTIME_AGREE  a ," + 
     "              			  h_code_common b" + 
     "                 WHERE a.degree_code = b.code (+)" + 
     "              	  and b.code_div = '02'" + 
     "              	  and a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   and a.DONGHO = " + "'" + arg_dongho + "'" + 
     "                   and a.SEQ = " + "'" + arg_seq + "'" + 
     "              ORDER BY a.DEGREE_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>