<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("land_rate",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("build_rate",GauceDataColumn.TB_DECIMAL,10,4));
	  dSet.addDataColumn(new GauceDataColumn("vat_rate",GauceDataColumn.TB_DECIMAL,10,4));
	  
	  String query = "SELECT NVL(AA.LAND_RATE, 0) land_rate, "+
										"					NVL(AA.BUILD_RATE, 0) build_rate,		  "+
										"						NVL(AA.VAT_RATE, 0)	vat_rate			  "+
										"				 FROM ERPW.H_BASE_PYONG_RATE AA, "+
										"						( SELECT R.DEPT_CODE,									 "+
										"									R.SELL_CODE,														 "+
										"									R.SPEC_UNQ_NUM,												  "+
										"									MAX(R.APPLY_DATE) APPLY_DATE					"+
										"							 FROM H_BASE_PYONG_MASTER M,							 "+
										"									H_BASE_PYONG_RATE R,												  "+
										"									H_SALE_MASTER a																	  "+
										"							WHERE M.DEPT_CODE =    R.DEPT_CODE							"+
										"							  AND M.SELL_CODE =    R.SELL_CODE										 "+
										"							  AND M.SPEC_UNQ_NUM = R.SPEC_UNQ_NUM					 "+
										"							  AND M.DEPT_CODE = a.DEPT_CODE												  "+
										"							  AND M.SELL_CODE = a.SELL_CODE														"+
										"							  AND M.PYONG     = a.PYONG																			 "+
										"							  AND M.STYLE     = a.STYLE																				 "+
										"							  AND M.CLASS     = a.CLASS																				  "+
										"							  AND M.OPTION_CODE = a.OPTION_CODE										  "+
										"							  /*AND R.APPLY_DATE <= a.CONTRACT_DATE*/									  "+
										"							  AND a.dept_code = '"+arg_dept_code+"'"+
										"							  AND a.sell_code = '"+arg_sell_code+"'"+
										"							  AND a.dongho    = '"+arg_dongho+"'"+
										"							  AND a.seq       = '"+arg_seq+"'"+
										"						 GROUP BY R.DEPT_CODE,																							"+
										"									R.SELL_CODE,																												"+
										"									R.SPEC_UNQ_NUM) MM																						"+
										"				WHERE MM.DEPT_CODE = AA.DEPT_CODE															 "+
										"				  AND MM.SELL_CODE = AA.SELL_CODE																	  "+
										"				  AND MM.SPEC_UNQ_NUM = AA.SPEC_UNQ_NUM												"+
										"				  AND MM.APPLY_DATE = AA.APPLY_DATE";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>