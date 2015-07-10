<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_sell_code = req.getParameter("as_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("loan_request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_request_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_sol_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_duty_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("loan_duty_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,0));
    String query = "Select a.dept_code," + 
     "		 a.sell_code," + 
     "		 a.dongho," + 
     "		 nvl(a.seq, 0) seq," + 
     "		 a.pyong," + 
     "		 case c.cust_div when '01' then substr(a.cust_code, 1, 6) || '-' || substr(a.cust_code, 7, 7) " +
     "                       when '02' then substr(a.cust_code, 1, 3) || '-' || substr(a.cust_code, 4, 2) || '-' || substr(a.cust_code, 6, 5) " +
     "                       else a.cust_code end cust_code, " + 
     "		 b.bank_head_code," + 
     "		 c.cust_name," + 
     "		 to_char(b.loan_request_date, 'yyyy.mm.dd') loan_request_date," + 
     "		 nvl(b.loan_request_amt, 0) loan_request_amt," + 
     "		 to_char(b.guarantee_sol_date, 'yyyy.mm.dd') guarantee_sol_date," + 
     "		 b.loan_duty_name," + 
     "		 b.loan_duty_phone," + 
     "		 b.remark," + 
     "		 c.cust_div," + 
     "		 d.bank_head_name," + 
     "		 '' as Chk	" + 
     "  From h_sale_master a," + 
     "		 h_sale_loan b," + 
     "       h_code_cust c," + 
     "		 erpc.am_code_bank_head d" + 
     " Where a.dept_code = '" + as_dept_code + "'" + 
     "   And a.sell_code = '" + as_sell_code + "'" + 
     "   And a.chg_div = '01'" + 
     "   And a.dept_code = b.dept_code(+)" + 
     "   And a.sell_code = b.sell_code(+)" + 
     "   And a.dongho = b.dongho(+)" + 
     "   And a.seq = b.seq(+)" + 
     "   And a.cust_code = c.cust_code(+)" + 
     "   And b.bank_head_code = d.bank_head_code(+) " + 
     "   order by a.pyong, a.dongho   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>