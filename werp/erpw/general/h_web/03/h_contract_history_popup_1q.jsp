<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     //String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,9));
	  dSet.addDataColumn(new GauceDataColumn("dongho_s",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT SUBSTR(a.dongho, 1, 4)||'-'||SUBSTR(a.dongho, 5, 4) DONGHO,		 "+
	"                                             a.dongho  dongho_s, "+
	"															 a.seq,					  "+
	"															 c.cust_name||' '||(SELECT h_code_cust.cust_name FROM h_code_cust WHERE h_code_cust.cust_code = a.cust_code_co) cust_name,			"+
	"															 a.cust_code,				 "+
	"															 TO_CHAR(a.contract_date, 'yyyy.mm.dd')  contract_date, "+
	"															 DECODE(TO_CHAR(a.last_contract_date, 'yyyy.mm.dd' ), TO_CHAR(a.contract_date, 'yyyy.mm.dd'), '', TO_CHAR(a.last_contract_date, 'yyyy.mm.dd' ))   last_contract_date, "+
	"															 DECODE(TO_CHAR(a.chg_date, 'yyyy.mm.dd'), '2999.12.31', '', TO_CHAR(a.chg_date, 'yyyy.mm.dd')) chg_date,	  "+
	"															 b.CODE_NAME																																"+
	"													  FROM H_SALE_MASTER a,																											 "+
	"															 H_CODE_COMMON b,																													  "+
	"															 H_CODE_CUST c																																		"+
	  "												 WHERE  a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   and a.DONGHO = " + "'" + arg_dongho + "'" + 
	"														AND a.chg_div = b.CODE(+)																														"+
	"														AND b.code_div(+) = '01'																																		 "+
	"														AND a.cust_code = c.cust_code(+)																												 "+
	"														AND chg_div <> '00'																																						 "+
	"													ORDER BY a.seq 																																									 "
     
    ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>