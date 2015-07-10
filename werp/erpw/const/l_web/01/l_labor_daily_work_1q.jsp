<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date"); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("key_civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("dailywork",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inv_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jibul_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jibul_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("civil_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("netpay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("safety_man",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.CIVIL_REGISTER_NUMBER,   " + 
     "         a.CIVIL_REGISTER_NUMBER   key_civil_register_number,   " + 
     "         b.labor_name," + 
     "         to_char(a.WORK_DATE,'YYYY.MM.DD') WORK_DATE,   " + 
     "         a.SPEC_UNQ_NUM,   " + 
     "         F_PARENT_DETAIL_SIZE(a.dept_code,a.spec_unq_num) spec_name,  " + 
     "         a.spec_no_seq,  " + 
     "         c.name, " + 
     "         a.DAILYWORK,   " + 
     "         a.UNITCOST,   " + 
     "         a.INV_SECTION,   " + 
     "         a.JIBUL_TAG,   " + 
     "         to_char(a.JIBUL_DATE,'YYYY.MM.DD') JIBUL_DATE,   " + 
     "         a.pay_amt," + 
     "         a.income_tax," + 
     "         a.civil_tax," + 
     "         a.pay_amt - a.income_tax - a.civil_tax  netpay_amt," + 
     "         d.job_name, " +
     "         b.safety_man, " +
     "         a.item_code " +
	  "    FROM L_LABOR_DAILYWORK  a," + 
     "         L_LABOR_BASIC b," + 
     "         Y_BUDGET_DETAIL c," + 
     "         l_code_job d " +
     "  WHERE b.job_code = d.job_code " +
     "    and a.dept_code = b.dept_code" + 
     "    and a.civil_register_number = b.civil_register_number" + 
     "    and a.dept_code = c.dept_code (+)" + 
     "    and a.SPEC_UNQ_NUM = c.SPEC_UNQ_NUM (+)" + 
     "    and a.dept_code = " + "'" + arg_dept + "'" +
     "    and a.work_date = " + "'" + arg_date  + "'" +
     " order by d.job_name asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>