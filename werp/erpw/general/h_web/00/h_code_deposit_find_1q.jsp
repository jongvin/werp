<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("bank_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("account_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("print_deposit_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("annul_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("print_order",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPOSIT_NO,   " + 
     "                       a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.BANK_CODE,   " + 
     "                       a.BANK_NAME,   " + 
     "                       a.BANK_PHONE,   " + 
     "                       a.ACCOUNT_DIV,   " + 
     "                       a.DEPOSITOR,   " + 
     "                       a.PRINT_DEPOSIT_NO,   " + 
     "                       a.ANNUL_YN,   " + 
     "                       a.PRINT_ORDER  " + 
     "                  FROM H_CODE_DEPOSIT a " + 
     "                 WHERE a.dept_code like  decode( '" + arg_dept_code + "' , 'ALL', '%', '" +arg_dept_code+"')" + 
     "              	    and a.sell_code like   decode( '" + arg_sell_code + "' , 'ALL', '%', '" +arg_sell_code+"')" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>