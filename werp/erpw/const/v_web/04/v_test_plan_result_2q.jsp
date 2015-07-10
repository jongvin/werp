<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mon_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mon_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mon_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mon_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mon_char",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_test_times",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_test_pass",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_test_fail",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_test_reexam",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_char",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.*,																					" +
      "                    (a.mon_test_fail - a.mon_test_reexam) mon_char,							" +
    	"                    b.*,																					" +
      "                    (b.a_test_fail - b.a_test_reexam) a_char									" +      
    	"               from (select to_char(b.yymm,'mm') month,											" +   
      "                            sum(nvl(b.test_times,0)) mon_test_times,						" +   
		" 	                          sum(nvl(b.test_pass,0)) mon_test_pass,							" +
		"	                          sum(nvl(b.test_fail,0)) mon_test_fail,							" +
		"	                          sum(nvl(b.test_reexam,0)) mon_test_reexam						" +
		"                       from v_test_result_detail b,												" +
		"                            v_test_result a															" +
		"                      where a.dept_code = b.dept_code and										" +
		"                            a.yymm = b.yymm and													" +
		"                            a.status in ('2','3') and											" +
		"                            b.yymm='" + arg_yymm + "'											" +
		"                      group by b.yymm) a,																" +
		"                    (select sum(nvl(c.test_times,0)) a_test_times,							" +
		"	                          sum(nvl(c.test_pass,0)) a_test_pass,								" +
		"	                          sum(nvl(c.test_fail,0)) a_test_fail,								" +
		"	                          sum(nvl(c.test_reexam,0)) a_test_reexam							" +
		"                       from v_test_result_detail c,												" +
		"                            v_test_result a															" +
		"                      where a.dept_code = c.dept_code and										" +
		"                            a.yymm = c.yymm and													" +
		"                            a.status in ('2','3') and											" +
		"                            c.yymm<='" + arg_yymm + "'												" +
		"                    ) b																					";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>