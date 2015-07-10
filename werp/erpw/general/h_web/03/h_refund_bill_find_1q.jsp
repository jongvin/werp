<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_sell_code = req.getParameter("as_sell_code");
     String as_dongho    = req.getParameter("as_dongho");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,18));
    String query = "	Select a.dept_code," + 
     "          a.sell_code," + 
     "          a.dongho," + 
     "          a.seq," + 
     "          a.contract_code," + 
     "          b.cust_name," + 
     "          a.cust_code," +
     "          to_char(a.contract_date, 'YYYY.MM.DD') contract_date," + 
     "          to_char(a.chg_date, 'YYYY.MM.DD') chg_date" + 
     "     From h_sale_master a," + 
     "          h_code_cust b " + 
     " 	 where a.dept_code = '" + as_dept_code + "'" + 
     "      and a.sell_code = '" + as_sell_code + "'" + 
     "      And a.dongho Like '" + as_dongho    + "%'" + 
     "      and a.cust_code = b.cust_code(+)" + 
     "      and a.chg_div = '03'      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>