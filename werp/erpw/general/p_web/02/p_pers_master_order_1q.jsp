<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("apply_order_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("order_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("order_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("work_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("level_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobkind_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("confirm_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT to_char(a.apply_order_date,'yyyy.mm.dd') apply_order_date,   " + 
     "         a.order_no,   " + 
     "         b.order_title," + 
     "         a.order_code,   " + 
     "         c.order_name,	" + 
     "         comp.comp_name," + 
     "         a.dept_code," + 
     "         a.dept_short_name dept_name,   " + 
     "         a.work_dept_code,   " + 
     "         work.short_name work_dept_name," + 
     "         a.cost_dept_code,   " + 
     "         cost.short_name cost_dept_name," + 
     "         a.grade_code,  " + 
     "         d.grade_name, " + 
     "         a.level_code," + 
     "         e.level_name,   " + 
     "         a.paystep,   " + 
     "         a.jobkind_code,   " + 
     "         f.jobkind_name," + 
     "         a.jobgroup_code,   " + 
     "         g.jobgroup_name," + 
     "         a.duty," + 
     "         a.confirm_tag         " + 
     "    FROM p_order_master		a,   " + 
     "         p_order_paperno   b," + 
     "         p_code_order      c," + 
     "         p_code_grade		d," + 
     "         p_code_level		e," + 
     "         p_code_jobkind		f," + 
     "         p_code_jobgroup	g,         " + 
     "         z_code_comp			comp," + 
     "         z_code_dept			dept," + 
     "         z_code_dept			work," + 
     "         z_code_dept			cost         " + 
     "   WHERE a.order_no = b.order_no" + 
     "     and a.order_code = c.order_code(+)" + 
     "     and a.grade_code = d.grade_code(+)" + 
     "     and a.level_code = e.level_code(+)" + 
     "     and a.jobkind_code = f.jobkind_code(+)" + 
     "     and a.jobgroup_code  = g.jobgroup_code(+)" + 
     "     and a.comp_code = comp.comp_code(+)" + 
     "     and a.dept_code = dept.dept_code(+)" + 
     "     and a.work_dept_code = work.dept_code(+)" + 
     "     and a.cost_dept_code = cost.dept_code(+)" + 
     "     and a.confirm_tag = '1'" + 
     "     and a.emp_no = '" + arg_emp_no + "'   " +
     "	order by  a.apply_order_date desc, a.order_no desc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>