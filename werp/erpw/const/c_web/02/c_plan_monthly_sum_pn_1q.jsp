<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)//
     String arg_year = req.getParameter("arg_year");
	 
	 dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("new_tag",GauceDataColumn.TB_STRING,10));
	 
	 dSet.addDataColumn(new GauceDataColumn("pq_name1",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("new_name",GauceDataColumn.TB_STRING,10));
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

	 
    String query ="  SELECT   m.pq_tag, m.new_tag, "+
"          (SELECT child_name FROM z_code_etc_child WHERE class_tag = '010' AND etc_code = m.pq_tag) pq_name1,"   +
"           DECODE (m.new_tag, 'Y', '신규', '이월') new_name,"   +
"           nvl(line_desc,' ') line_desc,"   +
"           line_desc2,"   +
"           line_no,"   +
"           SUM (NVL (sum_all, 0)) sum_all,"   +
"           SUM (NVL (pre_sum, 0)) pre_sum,"   +
"           SUM (NVL (this_sum, 0)) this_sum,"   +
"           SUM (NVL (mm01, 0)) mm01,"   +
"           SUM (NVL (mm02, 0)) mm02,"   +
"           SUM (NVL (mm03, 0)) mm03,"   +
"           SUM (NVL (mm04, 0)) mm04,"   +
"           SUM (NVL (mm05, 0)) mm05,"   +
"           SUM (NVL (mm06, 0)) mm06,"   +
"           SUM (NVL (mm07, 0)) mm07,"   +
"           SUM (NVL (mm08, 0)) mm08,"   +
"           SUM (NVL (mm09, 0)) mm09,"   +
"           SUM (NVL (mm10, 0)) mm10,"   +
"           SUM (NVL (mm11, 0)) mm11,"   +
"           SUM (NVL (mm12, 0)) mm12,"   +
"           SUM (NVL (next_sum, 0)) next_sum"   +
"      FROM c_plan_monthly_sum_master m, c_plan_monthly_sum_detail d"   +
"     WHERE m.dept_code = d.dept_code"   +
"       AND d.YEAR = '"+arg_year+"'"   +
"  GROUP BY m.pq_tag, m.new_tag, d.line_no, line_desc, line_desc2"   +
"  ORDER BY  m.pq_tag,m.new_tag, d.line_no"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>