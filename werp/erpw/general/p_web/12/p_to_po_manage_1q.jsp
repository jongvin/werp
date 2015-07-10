<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_01",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_02",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_03",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_04",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_05",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_06",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_07",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_08",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_09",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_10",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_11",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("to_12",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_01",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_02",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_03",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_04",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_05",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_06",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_07",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_08",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_09",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_10",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_11",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("po_12",GauceDataColumn.TB_DECIMAL,3,0));
    String query = "  SELECT  a.comp_code ," + 
     "          a.dept_code ," + 
     "          a.grade_code ," + 
     "          to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
     "          a.to_01 ," + 
     "          a.to_02 ," + 
     "          a.to_03 ," + 
     "          a.to_04 ," + 
     "          a.to_05 ," + 
     "          a.to_06 ," + 
     "          a.to_07 ," + 
     "          a.to_08 ," + 
     "          a.to_09 ," + 
     "          a.to_10 ," + 
     "          a.to_11 ," + 
     "          a.to_12 ," + 
     "          b.po_01 ," + 
     "          b.po_02 ," + 
     "          b.po_03 ," + 
     "          b.po_04 ," + 
     "          b.po_05 ," + 
     "          b.po_06 ," + 
     "          b.po_07 ," + 
     "          b.po_08 ," + 
     "          b.po_09 ," + 
     "          b.po_10 ," + 
     "          b.po_11 ," + 
     "          b.po_12  " +
     "    FROM p_to_po_manage  a, " + 
     "         view_p_to_po_calculate b " + 
     "   where a.comp_code = b.comp_code (+) " + 
     "     and a.dept_code = b.dept_code (+) " + 
     "     and a.grade_code = b.grade_code (+) " + 
     "     and a.work_year = b.work_year (+) " + 
     "	  and a.comp_code  = '" + arg_comp_code + "' " + 
     "	  and a.dept_code  = '" + arg_dept_code + "' " + 
     "	  and a.work_year  = '" + arg_year      + "' " +
     "	order by a.grade_code	";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>