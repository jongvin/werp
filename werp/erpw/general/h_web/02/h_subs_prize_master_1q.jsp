<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("subs_no",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("t_cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("subs_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("subs_order",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("prize_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prize_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("preparation_order",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("contract_addr",GauceDataColumn.TB_STRING,150));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.SUBS_NO,   " + 
     "                       a.CUST_CODE,   " + 
     "                       a.CUST_CODE t_cust_code,   " + 
     "                       a.PYONG,   " + 
     "                       a.STYLE,   " + 
     "                       to_char(a.SUBS_DATE,'YYYY.MM.DD') subs_date,   " + 
     "                       a.SUBS_ORDER,   " + 
     "                       to_char(a.PRIZE_DATE,'YYYY.MM.DD') prize_date,   " + 
     "                       a.PRIZE_DONGHO,   " + 
     "                       a.PREPARATION_ORDER,   " +
	  "                        to_char(a.refund_date,'yyyy.mm.dd') refund_date, "+
     "                       b.CUST_NAME,   " + 
     "                       b.HOME_PHONE,   " + 
     "                       b.CELL_PHONE,   " + 
     "                       b.cur_ADDR1 || b.cur_addr2 contract_addr   " + 
     "                  FROM H_SUBS_MASTER a,   " + 
     "                       H_CODE_CUST  b" + 
     "                 WHERE b.CUST_CODE = a.CUST_CODE " + 
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "              ORDER BY a.PYONG ASC,   " + 
     "                       a.STYLE ASC,   " +
     "                       a.subs_no asc        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>