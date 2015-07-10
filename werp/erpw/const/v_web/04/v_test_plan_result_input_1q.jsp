<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comm_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("comm_wbs_code_name",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("branch_class",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("branch_class_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("test_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("test_plan",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("test_reexam",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("s_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));         
     dSet.addDataColumn(new GauceDataColumn("v_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("v_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("v_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("v_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT to_char(a.yymm, 'yyyymmdd') yymm,									" + 
     "                       to_char(a.yymm, 'yyyymmdd') yymmdd,									" + 
     "                       a.dept_code,																" + 
     "                       a.d_seq,																	" + 
     "                       a.comm_wbs_code,														" + 
     "     (select comm_name from v_comm_code where section='1' and comm_code=a.comm_wbs_code) comm_wbs_code_name, " +
     "                       a.branch_class ,																" + 
     "     (select comm_name from v_comm_code where section='2' and comm_code=a.branch_class) branch_class_name, " +

     "                       a.test_item ,																" + 
     "                       a.test_plan,																" + 
     "                       a.test_times,															" + 
     "                       a.test_pass,																" + 
     "                       a.test_fail,																" + 
     "                       a.test_reexam,															" +
     "							  s.s_test_times,															" + 
     "                       s.s_test_pass,															" + 
     "                       s.s_test_fail,															" + 
     "                       s.s_test_reexam,														" + 
     "							  (nvl(a.test_times,0) + nvl(s.s_test_times,0)) v_test_times,						" + 
     "                       (nvl(a.test_pass,0) + nvl(s.s_test_pass,0)) v_test_pass,							" + 
     "                       (nvl(a.test_fail,0) + nvl(s.s_test_fail,0)) v_test_fail,							" + 
     "                       (nvl(a.test_reexam,0) + nvl(s.s_test_reexam,0)) v_test_reexam,					" + 
     "                       a.remark        														" +
     "                  FROM v_test_result_detail a,   											" +
     
     "							  (select dept_code,														" +
	  "						             (comm_wbs_code || test_item) code,						" +
	  "									     sum(test_plan) s_test_plan,								" +
	  "								        sum(test_times) s_test_times,							" +
	  "								        sum(test_pass) s_test_pass,								" +
	  "										  sum(test_fail) s_test_fail,								" +
	  "										  sum(test_reexam) s_test_reexam							" +
	  "								   from v_test_result_detail										" +
	  "								  where to_char(yymm, 'yyyy.mm') < '" + arg_yymm + "'		" +
	  "							  group by dept_code, (comm_wbs_code || test_item)) s			" +									    			
     "                 WHERE a.dept_code = s.dept_code(+) and 									" +
	  "						 	 (a.comm_wbs_code || a.test_item) = s.code(+) and				" +
     "                 		  a.dept_code='" + arg_dept_code + "' and							" +
     "                       to_char(a.yymm, 'yyyy.mm')='" + arg_yymm + "'					" +
     "              ORDER BY a.yymm ASC,																" + 
     "                       a.dept_code ASC,														" + 
     "                       a.d_seq ASC         													";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>