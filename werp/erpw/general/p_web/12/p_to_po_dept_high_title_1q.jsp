<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_degree = req.getParameter("arg_degree");
     String arg_year = req.getParameter("arg_year");
     String arg_level_code = req.getParameter("arg_level_code") +"%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_01",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_02",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_03",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_04",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_05",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_06",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_07",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_08",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_09",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("to_12",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_01",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_02",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_03",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_04",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_05",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_06",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_07",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_08",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_09",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("po_12",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.grade_code ," + 
     "          to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
     "          sum(a.to_01) to_01 ," + 
     "          sum(a.to_02) to_02 ," + 
     "          sum(a.to_03) to_03 ," + 
     "          sum(a.to_04) to_04 ," + 
     "          sum(a.to_05) to_05 ," + 
     "          sum(a.to_06) to_06 ," + 
     "          sum(a.to_07) to_07 ," + 
     "          sum(a.to_08) to_08 ," + 
     "          sum(a.to_09) to_09 ," + 
     "          sum(a.to_10) to_10 ," + 
     "          sum(a.to_11) to_11 ," + 
     "          sum(a.to_12) to_12 ," + 
     "          sum(b.po_01) po_01 ," + 
     "          sum(b.po_02) po_02 ," + 
     "          sum(b.po_03) po_03 ," + 
     "          sum(b.po_04) po_04 ," + 
     "          sum(b.po_05) po_05 ," + 
     "          sum(b.po_06) po_06 ," + 
     "          sum(b.po_07) po_07 ," + 
     "          sum(b.po_08) po_08 ," + 
     "          sum(b.po_09) po_09 ," + 
     "          sum(b.po_10) po_10 ," + 
     "          sum(b.po_11) po_11 ," + 
     "          sum(b.po_12) po_12  " +
     "    FROM p_to_po_manage  a, " + 
     "         view_p_to_po_calculate b, " + 
     "         z_code_chg_dept_title	c, " + 
     "         z_code_chg_dept_content	d  " + 
	  "   where a.comp_code = b.comp_code (+) " + 
     "     and a.dept_code = b.dept_code (+) " + 
     "     and a.grade_code = b.grade_code (+) " + 
     "     and a.work_year = b.work_year (+) " + 
     "     and a.dept_code    = d.dept_code	" +
     "	  and c.degree			= d.degree	" +
     "	  and c.dept_seq_key = d.dept_seq_key	" +
     "	  and c.degree			= '" + arg_degree + "'	" +
     "	  and c.level_code  like '" + arg_level_code + "' " + 
	  "	  and a.work_year  	= '" + arg_year      + "' " +
     "   group by a.grade_code ," + 
     "          to_char(a.work_year,'yyyy.mm.dd') " +
     "	order by a.grade_code	";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>