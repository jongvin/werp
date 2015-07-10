<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_date = req.getParameter("arg_date");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("a_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("a_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("a_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,3));
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
    String query = "select a.comp_code a_comp_code, " +       
     "		 a.dept_code a_dept_code," + 
     "		 a.grade_code a_grade_code," + 
     "		 c.comp_code, " +
     "		 c.dept_code," +
     "		 c.grade_code," +
     "		 to_char(c.work_year,'yyyy.mm.dd') work_year, " +
     "		 c.po_01, " +
     "		 c.po_02, " +
     "		 c.po_03, " +
     "		 c.po_04, " +
     "		 c.po_05, " +
     "		 c.po_06, " +
     "		 c.po_07, " +
     "		 c.po_08, " +
     "		 c.po_09, " +
     "		 c.po_10, " +
     "		 c.po_11, " +
     "		 c.po_12, " +
     "       count(a.emp_no) cnt" + 
     "  from (select a.comp_code," + 
     "					a.dept_code," + 
     "					a.grade_code, " + 
     "					  a.emp_no, " + 
     "					  RANK() OVER (PARTITION by a.emp_no " + 
     "								 ORDER BY a.emp_no asc, a.apply_order_date desc, " + 
     "										 a.seq desc, a.spec_no_seq desc) rk_1 " + 
     "			  from p_order_master a " + 
     "			  where a.comp_code like '" + arg_comp_code + "' " + 
     "				 and a.apply_order_date <= '" + arg_date + "' " + 
     "				 and a.confirm_tag       = '1' " + 
     "		  ) a, " + 
     "		  p_pers_master b, " + 
	  "		  p_to_po_manage c " + 
     "  where a.rk_1 = 1 " + 
     "	 and a.emp_no = b.emp_no " + 
     "	 and a.comp_code = c.comp_code(+) " + 
	  "	 and a.dept_code = c.dept_code(+) " + 
	  "	 and a.grade_code = c.grade_code(+) " + 
	  " group by a.comp_code, " +       
     "		 	 a.dept_code, " + 
     "		 	 a.grade_code," + 
     "		 	 c.comp_code, " +
     "		 	 c.dept_code," +
     "		 	 c.grade_code," +
     "		 	 to_char(c.work_year,'yyyy.mm.dd'), " +
     "		 	 c.po_01, " +
     "		 	 c.po_02, " +
     "		 	 c.po_03, " +
     "		 	 c.po_04, " +
     "		 	 c.po_05, " +
     "		 	 c.po_06, " +
     "		 	 c.po_07, " +
     "		 	 c.po_08, " +
     "		 	 c.po_09, " +
     "		 	 c.po_10, " +
     "		 	 c.po_11, " +
     "		 	 c.po_12 " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>