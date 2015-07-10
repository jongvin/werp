<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)//
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_year = req.getParameter("arg_year");
	 dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
	 
	 dSet.addDataColumn(new GauceDataColumn("line_desc",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("line_desc2",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("line_no",GauceDataColumn.TB_DECIMAL,18,2));
	 
     dSet.addDataColumn(new GauceDataColumn("sum_all",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("pre_sum",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("this_sum",GauceDataColumn.TB_DECIMAL,18,2));

	 dSet.addDataColumn(new GauceDataColumn("mm01",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm02",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm03",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm04",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm05",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm06",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm07",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm08",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm09",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm10",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm11",GauceDataColumn.TB_DECIMAL,18,2));
	 dSet.addDataColumn(new GauceDataColumn("mm12",GauceDataColumn.TB_DECIMAL,18,2));

	 dSet.addDataColumn(new GauceDataColumn("next_sum",GauceDataColumn.TB_DECIMAL,18,2));

	 
    String query ="   SELECT   m.dept_name,"   +
"            nvl(line_desc,' ') line_desc,"   +
"            line_desc2,"   +
"            line_no,"   +
"            NVL (sum_all, 0) sum_all,"   +
"            NVL (pre_sum, 0) pre_sum,"   +
"            NVL (this_sum, 0) this_sum,"   +
"            NVL (mm01, 0) mm01,"   +
"            NVL (mm02, 0) mm02,"   +
"            NVL (mm03, 0) mm03,"   +
"            NVL (mm04, 0) mm04,"   +
"            NVL (mm05, 0) mm05,"   +
"            NVL (mm06, 0) mm06,"   +
"            NVL (mm07, 0) mm07,"   +
"            NVL (mm08, 0) mm08,"   +
"            NVL (mm09, 0) mm09,"   +
"            NVL (mm10, 0) mm10,"   +
"            NVL (mm11, 0) mm11,"   +
"            NVL (mm12, 0) mm12,"   +
"            NVL (next_sum, 0) next_sum"   +
"       FROM c_plan_monthly_sum_master m, c_plan_monthly_sum_detail d"   +
"      WHERE m.dept_code = d.dept_code"   +
"        AND d.YEAR = '"+arg_year+"'"   +
"        AND m.dept_code = '"+arg_dept_code+"'"+
"   ORDER BY m.dept_code,  d.line_no"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>