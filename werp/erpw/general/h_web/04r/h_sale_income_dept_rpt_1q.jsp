<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_process  = req.getParameter("as_process");
     String as_contract = req.getParameter("as_contract");
     String ad_date     = req.getParameter("ad_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
    String query = "Select a.dept_code," +
     "      a.sell_code," +
     "      a.dongho," + 
     "	   a.seq," + 
     "	   max(b.degree_code) degree_code" + 
     "  From h_sale_master a," + 
     "       h_sale_agree  b," + 
     "       h_code_dept   c" + 
     " Where a.dept_code 	= c.dept_code" + 
     "   And a.dept_code  = b.dept_code" + 
     "   And a.sell_code  = b.sell_code" + 
     "   And a.dongho     = b.dongho" + 
     "   And a.seq        = b.seq" + 
     "   And c.process_code       like decode('" + as_process + "', 'ALL', '%', '" + as_process + "')" + 
     "   And a.contract_code 	    like decode('" + as_contract + "', 'ALL', '%', '" + as_contract + "')" + 
     "   And a.last_contract_date <= '" + ad_date + "'" + 
     "   And a.chg_date 			 > '" + ad_date + "'" + 
     "   And a.chg_div 			    <> '00'     " +
     "group by a.dept_code," +
     "         a.sell_code," +
     "         a.dongho," +
     "         a.seq" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>