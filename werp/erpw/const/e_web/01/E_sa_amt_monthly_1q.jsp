<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("biz_code",GauceDataColumn.TB_STRING,1));
//   dSet.addDataColumn(new GauceDataColumn("biz_name",GauceDataColumn.TB_STRING,50));    // 업무명
     dSet.addDataColumn(new GauceDataColumn("usememo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("use_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
	 String query =  " select																	" +				
					"	 a.dept_code ,															" +
					"	 to_char(a.yymm,'yyyymmdd' ) as yymm ,									" +
					"	 a.unq_num ,															" +
					"	 a.item_code ,															" +	
					"	 ( select child_name from e_safety_code_child							" +	
					"	   where class_tag = '033' and safety_code = a.item_code ) as item_name," +
					"	 a.biz as biz_code ,													" +		

					"	 a.usememo ,														    " +
					"	 a.amt ,																" +
					"	 a.VAT ,																" +
					"	 to_char(a.use_date,'yyyy.mm.dd' ) as use_date ,								" +	
					"	 a.remark																" +
					"																			" +	
					" from																		" +	
					" 	 e_safty_cost_total a													" +
					" where																		" +		
					" 	  to_char(a.yymm,'yyyymm' ) like '%" + arg_yymm + "%'  and				" +
					" 	 a.dept_code = '" + arg_dept_code + "'									" +	
					" order by a.item_code , biz_code ,unq_num									" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>