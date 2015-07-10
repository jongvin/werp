<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("s_dong",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("s_ho",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("e_ho",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("house_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.SEQ,   " + 
     "                       a.PYONG,   " + 
     "                       a.STYLE,   " + 
     "                       a.CLASS,   " + 
     "                       a.S_DONG,   " + 
     "                       a.S_HO,   " + 
     "                       a.E_HO,   " + 
     "                       a.OPTION_CODE,   " + 
     "                       a.UNION_YN,   " + 
     "                       a.HOUSE_CNT," + 
     "                       b.option_name," +
     "                       c.class_name," +
     "                 		  'F'  comp_chk  ," + 
     "                       a.contract_code " +
     "                  FROM H_BASE_SELLHOUSE a, " + 
     "                       h_code_option b, " +
     "                       h_code_class c " +
     "                 WHERE a.dept_code = b.dept_code (+) " +
     "                   AND a.sell_code = b.sell_code (+) " +
     "                   AND a.option_code = b.option_code (+) " +
     "                   AND a.dept_code = c.dept_code (+) " +
     "                   AND a.sell_code = c.sell_code (+) " +
     "                   AND a.class     = c.class (+) " +
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "              ORDER BY a.S_DONG, a.S_HO        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>