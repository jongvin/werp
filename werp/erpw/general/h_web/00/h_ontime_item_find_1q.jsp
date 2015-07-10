<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_size",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_amt_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       ITEM_CODE,   " + 
     "                       ITEM_SIZE,   " + 
     "                       ITEM_NAME,   " + 
     "                       DEPOSIT_NO,   " + 
     "                       AMT,   " + 
     "                       SUPPLY_AMT,   " + 
     "                       VAT_AMT,   " + 
     "                       R_AMT_YN  " + 
     "                  FROM H_BASE_ONTIME_ITEM  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "              ORDER BY ITEM_CODE, ITEM_SIZE        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>