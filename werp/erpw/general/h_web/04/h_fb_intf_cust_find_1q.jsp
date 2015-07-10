<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_cust_name = req.getParameter("arg_cust_name");
 String arg_dongho = req.getParameter("arg_dongho");
 String arg_work_date = req.getParameter("arg_work_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,17));
	  dSet.addDataColumn(new GauceDataColumn("dongho_s",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
    String query = "SELECT (SELECT long_name FROM H_CODE_DEPT WHERE dept_code = a.dept_code) dept_name," + 
     "       (SELECT code_name FROM H_CODE_COMMON WHERE code_div = '03' AND code = a.sell_code) sell_name," + 
     "       SUBSTR(a.dongho,1,4)||'-'||SUBSTR(a.dongho,5,4) dongho," +
	  "        a.dongho  dongho_s,  "+
	  "       a.dept_code, "+
	  "       a.sell_code , "+
     "       a.seq," + 
     "       to_char(a.contract_date,'yyyy.mm.dd') contract_date," + 
     "       a.cust_code," + 
     "       c.cust_name" + 
     "  FROM H_SALE_MASTER a," + 
     "       H_CODE_CUST c," + 
	  "       h_code_dept d "+
     " WHERE a.cust_code = c.cust_code" + 
	  "   AND a.dept_code = d.dept_code "+
     "   AND d.process_code = '01' "+
     "   AND c.cust_name LIKE '%'||'"+arg_cust_name+"'||'%'" + 
	  "   AND A.DONGHO LIKE '%'||'"+arg_dongho+"'||'%'" +
     "   AND a.last_contract_date <= '"+arg_work_date+"'" + 
     "   AND a.chg_date > '"+arg_work_date+"'" + 
     "   order by a.dept_code, a.sell_code, a.dongho, a.seq    " + 
     "     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>