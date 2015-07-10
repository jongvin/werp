<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,13,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "         SELL_CODE,   " + 
     "         SPEC_UNQ_NUM,   " + 
     "         DEGREE_CODE,   " + 
     "         DEGREE_CODE   key_degree_code,   " + 
     "         to_char(AGREE_DATE,'YYYY.MM.DD') agree_date,   " + 
     "         LAND_AMT,   " + 
     "         BUILD_AMT,   " + 
     "         VAT_AMT,   " + 
     "         SELL_AMT  " + 
     "    FROM H_BASE_PYONG_DETAIL  " + 
     "   WHERE DEPT_CODE = " + "'" + arg_dept_code  + "'" + 
     "     AND SELL_CODE = " + "'" + arg_sell_code  + "'" + 
     "     AND SPEC_UNQ_NUM = " + "'" + arg_seq + "'" + 
     "ORDER BY DEGREE_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>