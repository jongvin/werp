<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_cust_name = req.getParameter("arg_cust_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,17));
	  dSet.addDataColumn(new GauceDataColumn("dongho_s",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
    String query = "SELECT MAX(m.seq) seq," + 
     "       SUBSTR(m.dongho,1,4)||'-'||SUBSTR(m.dongho,5,4) dongho," + 
	  "       m.dongho dongho_s, "+
     "       c.cust_name," + 
     "       c.cust_code," + 
     "       c.cell_phone," + 
     "       c.home_phone" + 
     "  FROM H_CODE_CUST c," + 
     "       H_SALE_MASTER m" + 
     " WHERE m.cust_code = c.cust_code" + 
     "   AND m.dept_code = '"+arg_dept_code+"'" + 
     "   AND m.sell_code = '"+arg_sell_code+"'" + 
     "   AND m.contract_yn = 'Y'" + 
     "   AND c.cust_name LIKE '%'||'"+arg_cust_name+"'||'%'" + 
     " GROUP BY m.dongho ," + 
     "       c.cust_name,c.cust_code, c.cell_phone, c.home_phone" + 
     " order by dongho     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>