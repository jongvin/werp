<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_sell_code = req.getParameter("as_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("master_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("master_sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("master_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("master_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chk_cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fund_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("fund_sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fund_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("fund_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exchange_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("private_square",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
    String query = "Select a.dept_code master_dept_code," + 
     "		 a.sell_code master_sell_code," + 
     "		 a.dongho master_dongho," + 
     "		 nvl(a.seq, 0) master_seq," + 
     "       a.cust_code  chk_cust_code, " +
     "		 case c.cust_div when '01' then substr(a.cust_code, 1, 6) || '-' || substr(a.cust_code, 7, 7) " +
     "                       when '02' then substr(a.cust_code, 1, 3) || '-' || substr(a.cust_code, 4, 2) || '-' || substr(a.cust_code, 6, 5) " +
     "                       else a.cust_code end cust_code, " +
     "		 nvl(a.pyong, 0) pyong," + 
     "		 c.cust_name," + 
     "		 c.cust_div," + 
     "		 b.dept_code fund_dept_code," + 
     "		 b.sell_code fund_sell_code," + 
     "		 b.dongho fund_dongho," + 
     "		 nvl(b.seq, 0) fund_seq," + 
     "		 to_char(b.request_date, 'yyyy.mm.dd') request_date," + 
     "		 nvl(b.request_r_amt, 0) request_r_amt," + 
     "		 to_char(b.exchange_date, 'yyyy.mm.dd') exchange_date," + 
     "		 b.process_yn,	" + 
     "       nvl(d.private_square, 0) private_square," + 
     "		 'N' As chk" + 
     "  From h_sale_master a," + 
     "		 h_sale_fund b," + 
     "		 h_code_cust c," + 
     "       h_base_pyong_master d" + 
     " Where a.dept_code = '" + as_dept_code + "'" + 
     "   And a.sell_code = '" + as_sell_code + "'" + 
     "   And a.chg_div = '01'" + 
     "   And a.dept_code = b.dept_code(+)" + 
     "   And a.sell_code = b.sell_code(+)" + 
     "   And a.dongho = b.dongho(+)" + 
     "   And a.seq = b.seq(+)" + 
     "   And a.cust_code = c.cust_code(+)" + 
     "   And a.dept_code = d.dept_code(+)" + 
     "   And a.sell_code = d.sell_code(+)" + 
     "   And a.pyong = d.pyong(+)" + 
     "   And a.style = d.style(+)" + 
     "   And a.class = d.class(+)" + 
     "   And a.option_code = d.option_code(+)     " + 
     " order by nvl(a.pyong, 0), a.dongho     " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>