<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("old_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
	 dSet.addDataColumn(new GauceDataColumn("nullcheck",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("persent",GauceDataColumn.TB_DECIMAL,5,2));

		 
	String query =  " select																			" +	
					"	 a.safety_code item_code,														" +
					"	 a.child_name item_name,														" +
					"	 decode(b.dept_code,null,'" + arg_dept_code +"',b.dept_code) as dept_code,		" +
					"	 decode(b.amt,null,0,b.amt) as amt,											" +
					"   decode(b.amt,null,0,b.amt) old_amt,										" +
					"	 decode(b.remark,null,'',b.remark) as remark,							" +
					"    decode(b.item_code,null,'0','1') as nullcheck		,					" +
					"   '' persent																			" +
					" from																					" +
					"    e_safety_code_child a															" +
					"	 LEFT OUTER JOIN																	" +
					"	 e_safty_budget_detail b														" +	
					"	 on																					" +	
					"	 a.safety_code = b.item_code and												" +
					" 	 b.dept_code = '" + arg_dept_code + "'										" +	
					" where				 																	" +
					"     a.class_tag = '033'															" +
					"																							" +
					" order by safety_code																" ;	

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>