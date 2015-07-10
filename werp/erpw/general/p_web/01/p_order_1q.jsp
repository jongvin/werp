<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("service_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("join_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rest_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("reinst_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("retire_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("add_dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("add_dept_off_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("grade_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("level_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("paystep_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jobkind_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("title_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("gjoin_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("use_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sort",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  p_code_order.order_code ," + 
     "          p_code_order.order_name ," + 
     "          p_code_order.service_div ," + 
     "          p_code_order.join_date_yn ," + 
     "          p_code_order.rest_date_yn ," + 
     "          p_code_order.reinst_date_yn ," + 
     "          p_code_order.retire_date_yn ," + 
     "          p_code_order.dept_yn ," + 
     "          p_code_order.work_dept_yn ," + 
     "          p_code_order.cost_dept_yn ," + 
     "          p_code_order.add_dept_yn ," + 
     "          p_code_order.add_dept_off_yn ," + 
     "          p_code_order.grade_yn ," + 
     "          p_code_order.level_yn ," + 
     "          p_code_order.paystep_yn ," + 
     "          p_code_order.jobgroup_yn ," + 
     "          p_code_order.jobkind_yn ," + 
     "          p_code_order.title_yn ," + 
     "          p_code_order.gjoin_date_yn, " +
     "          'F' use_yn, " +
     "          p_code_order.sort,  " +
     "          'Y' ret_tag " +
     "    FROM p_code_order      " +
     "  order by sort asc";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>