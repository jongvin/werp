<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_class_chk",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));

 String query = " select																			" +
				"	  a.dept_code,																	" +
				"	  (select long_name from z_code_dept where dept_code=a.dept_code) long_name, " +
				"	  to_char(a.yymm , 'yyyymm' ) yymm,												" +
				"	  to_char(a.yymm , 'yyyymmdd' ) yymmdd,											" +
				"	  a.approve_class ,																" +	
				"	  decode( a.approve_class,'3','평가완료', '2', '제출', '1', '작성중' ) approve_class_chk  ,	" +
				"	  a.remark																		" +	
				" from																				" +			 	
				" 	  e_comp_opinion_header a														" +		 
				" where																				" +		 
				" 	  a.dept_code like '%" + arg_dept_code + "%' and											" +
				"     to_char(a.yymm,'yyyymm') like '%"+arg_yymm+"%'	and							" +
				"     a.approve_class in " + arg_class +
				" order by	a.dept_code asc,																		" +			 
 				"     a.yymm desc																	" ;			 
				

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>