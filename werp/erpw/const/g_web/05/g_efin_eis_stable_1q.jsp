<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cp_quick_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_quick_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_quick_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_quick_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_liability_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_liability_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_liability_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_liability_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_debt_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_debt_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_debt_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_debt_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT a.group_id, 														" +
		"		               nvl(a.cp_quick_ratio,0) cp_quick_ratio,               " +
		"		               nvl(a.pp_quick_ratio,0) pp_quick_ratio,               " +
		"		               nvl(a.cy_quick_ratio,0) cy_quick_ratio,               " +
		"		               nvl(a.py_quick_ratio,0) py_quick_ratio,               " +
		"		               nvl(a.cp_liability_ratio,0) cp_liability_ratio,       " +
		"		               nvl(a.pp_liability_ratio,0) pp_liability_ratio,       " +
		"		               nvl(a.cy_liability_ratio,0) cy_liability_ratio,       " +
		"		               nvl(a.py_liability_ratio,0) py_liability_ratio,       " +
		"		               nvl(a.cp_debt_ratio,0) cp_debt_ratio,                 " +
		"		               nvl(a.pp_debt_ratio,0) pp_debt_ratio,                 " +
		"		               nvl(a.cy_debt_ratio,0) cy_debt_ratio,                 " +
		"		               nvl(a.py_debt_ratio,0) py_debt_ratio,                 " +
		"		               nvl(a.cp_operating_income_ratio,0) cp_operating_income_ratio,                            " +
		"		               nvl(a.pp_operating_income_ratio,0) pp_operating_income_ratio,                            " +
		"		               nvl(a.cy_operating_income_ratio,0) cy_operating_income_ratio,                            " +
		"		               nvl(a.py_operating_income_ratio,0) py_operating_income_ratio                             " +
		"		      from efin_eis_stable  a                                        " +
		"		where a.group_id = " + arg_group_id + "                              " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>