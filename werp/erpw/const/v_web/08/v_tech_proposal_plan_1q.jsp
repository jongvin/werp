<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("exe_amt1",GauceDataColumn.TB_DECIMAL,13));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("const_summary",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("leader_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sale_amt",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("save_amt",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("admit",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("man_num",GauceDataColumn.TB_DECIMAL,10,0));


	String query =" SELECT																							" +
				 "  TO_CHAR(a.YEAR,'YYYY.MM.DD') year,															" +										
				 "  b.long_name,																						" +										
				 "  b.owner , 																					      " +
				 "  b.chg_const_start_date ,																		" +
				 "  b.chg_const_end_date , 																		" +
				 "	 b.proj_charge ,																					" +
				 "	 nvl(b.exe_amt1,0) exe_amt1,																	" +   
				 "  a.dept_code , 																				 	" +
				 "	 a.const_summary , 																				" +
				 "	 a.leader_name , 																					" +
				 "	 a.sale_amt , 																						" +
				 "	 a.save_amt ,																						" +
				 "	 a.admit ,																							" +
				 "	 a.man_num																							" +
				 "from v_tech_proposal_plan_master A,															" +
				 "     z_code_dept B 																				" +
				 "where a.dept_code = b.dept_code(+) and														" +
				 "      a.DEPT_CODE = '"+arg_dept_code+"' AND											   " +
				 "      TO_CHAR(a.YEAR,'YYYY.MM.DD') = '"+arg_year+"'										" ;
  
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>