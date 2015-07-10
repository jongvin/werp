<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_process_code = req.getParameter("arg_process_code");
     String arg_long_name = req.getParameter("arg_long_name");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_vat_plus",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_DECIMAL,13,0));
//     dSet.addDataColumn(new GauceDataColumn("",GauceDataColumn.TB_DECIMAL,18));
	String query = "  select b.dept_code,											" +
						"	       b.long_name,											" +		
						"	       b.process_code,										" +	
						"	       a.amt amt1,											" +		
						"	       c.cnt_amt,												" +		
						"		    cnt_vat_plus											" +		
						" from																" +	
 						"  (select dept_code, sum(amt) amt from y_budget_detail where res_class='X' group by dept_code) a , " +												
						"	   z_code_dept b 	,											" +	
						"	( SELECT a.DEPT_CODE, nvl(a.CHANGE_SUPPLY_AMT,0) cnt_amt  , 	" +	
						"  (nvl(a.CHANGE_SUPPLY_AMT,0) + nvl(a.exempt_amt, 0) + nvl(a.CHANGE_VAT_AMT,0)) cnt_vat_plus " + 
						"  FROM R_CONTRACT_REGISTER a									" +
						"  WHERE LAST_TAG = 'Y'											" +
						"	) c																" +	
						" where																" +	
						"    b.dept_proj_tag = 'P'	and								" +
						"	  a.dept_code(+) = b.dept_code and						" +
						"    b.dept_code = c.dept_code(+) and	               " +
					   "	  b.process_code like '%" + arg_process_code + "' and   " +
					   "	  b.long_name like '%"+ arg_long_name +"%'				" +
					   " order by													" +
					   " 	  b.long_name asc										" ;


%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>