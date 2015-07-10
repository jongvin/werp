<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
 	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
 	  dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
 	  dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
 	  dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,18));
 	  dSet.addDataColumn(new GauceDataColumn("k_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("status",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("make_dt",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("user_no",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  select a.dept_code,																" +
      "                      z.long_name,																" +
      "                      to_char(b.yymm, 'yyyymmdd') yymm,									" +
      "                      to_char(b.yymm, 'yyyymmdd') key_yymmdd,							" +
      "                      to_char(b.yymm, 'yyyymmdd') k_yymmdd,							" +
		"                      b.dept_test_times,														" +
		"                      b.dept_test_pass,														" +
		"                      b.dept_test_fail,														" +
		"                      b.dept_test_reexam,													" +
		"	                    c.s_test_times,															" +
		"                      c.s_test_pass,															" +
		"                      c.s_test_fail,															" +
		"                      c.s_test_reexam,														" +
		"                      a.status,																	" +
		"                      a.make_dt,																" +
		"                      a.user_no,																" +
		"	                    a.remark																	" +
		"                 from v_test_result a,														" +
		"                      (select b.yymm, 														" +
		"                              b.dept_code,													" +
      "                              sum(nvl(b.test_times,0)) dept_test_times,			" +
		"	                            sum(nvl(b.test_pass,0)) dept_test_pass,				" +
		"	                            sum(nvl(b.test_fail,0)) dept_test_fail,				" +
		"	                            sum(nvl(b.test_reexam,0)) dept_test_reexam			" +
		"                         from v_test_result_detail b,									" +
		"                              v_test_result a												" +
		"                        where a.dept_code = b.dept_code and							" +
		"                              a.yymm = b.yymm and											" +
		"                              a.status in ('2','3') and									" +
		"                              b.yymm = '" + arg_yymm + "'								" +
		"                        group by b.yymm, 													" +
		"                                 b.dept_code												" +
		"                       ) b,																		" +
		"                       (select c.dept_code,													" +
		"                               sum(nvl(c.test_times,0)) s_test_times,				" +
		"	                             sum(nvl(c.test_pass,0)) s_test_pass,					" +
		"	                             sum(nvl(c.test_fail,0)) s_test_fail,					" +
		"	                             sum(nvl(c.test_reexam,0)) s_test_reexam				" +
		"	                        from v_test_result_detail c,									" +
		"                               v_test_result a												" +
		"	                       where a.dept_code = c.dept_code and							" +
		"                               a.yymm = c.yymm and										" +
		"                               a.status in ('2','3') and								" +
		"                               c.yymm <= '" + arg_yymm + "'							" +
		"	                       group by c.dept_code												" +
		"                       ) c,																		" +
		"	                     z_code_dept z															" +
		"                 where a.dept_code = b.dept_code and										" +
		"                       a.dept_code = c.dept_code and										" +
		"		                  a.dept_code = z.dept_code and										" +
		"                       a.yymm = '" + arg_yymm + "' and									" +
		"		                  a.status in ('2','3')												" +
		"                 order by a.dept_code asc   												";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>