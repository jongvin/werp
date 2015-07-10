<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       SEQ,   " + 
     "                       to_char(CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "                       DEGREE_CODE,   " + 
     "                       DEGREE_CODE key_degree_code,   " + 
     "                       to_char(AGREE_DATE,'YYYY.MM.DD') agree_date,   " + 
     "                       GUARANTEE_AMT,   " + 
     "                       F_PAY_YN,   " + 
     "                       TOT_AMT  " + 
     "                  FROM H_LEAS_GUARANTEE_AGREE  " + 
     "                 WHERE ( DEPT_CODE = '" + arg_dept_code + "' ) AND  " + 
     "                       ( SELL_CODE = '" + arg_sell_code + "' ) AND  " + 
     "                       ( DONGHO = '" + arg_dongho + "' ) AND  " + 
     "                       ( SEQ = '" + arg_seq + "' ) AND  " + 
     "                       ( CONTRACT_DATE = '" + arg_date + "' )   " + 
     "              ORDER BY DEGREE_CODE ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>