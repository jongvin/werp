<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_info = req.getParameter("arg_info");
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("company",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("hname",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("dept",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("deptnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("stsgbn",GauceDataColumn.TB_STRING,50));
     
    String query ="  select b.company, b.empno, 		/*사원번호*/"   +
" 	         					 b.hname, 		/*한글성명*/"   +
" 			 						 b.dept,	 		/*부서코드*/"   +
" 			 						 b.deptnm,		/*부서명*/"   +
" 			 						 b.stsgbn 		/*재직구분*/"   +
" 	from PMAS001VV@CJHRM b "   +
"  where B.stsgbn = 'AAA' " +
"		and (B.hname like '%" + arg_info + "%' or " +
"			  B.empno like '%" + arg_info + "%') " +
"ORDER BY b.EMPNO";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>