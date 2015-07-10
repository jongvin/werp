<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_date_1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("week_day",GauceDataColumn.TB_STRING,10));
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
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.CIVIL_REGISTER_NUMBER,   " + 
     "         b.labor_name," + 
     "         to_char(a.WORK_DATE,'YYYY.MM.DD') WORK_DATE,   " + 
     "         to_char(a.WORK_DATE,'YYYY.MM.DD') WORK_DATE_1,   " + 
	  "         to_char(a.WORK_DATE,'d') week_day,   " + 
     "         a.SPEC_UNQ_NUM,   " + 
     "         a.spec_no_seq,  " + 
     "         F_PARENT_DETAIL_SIZE(a.dept_code,a.spec_unq_num) spec_name,  " + 
     "         c.name, " + 
     "         a.DAILYWORK,   " + 
     "         a.UNITCOST,   " + 
     "         a.INV_SECTION,   " + 
     "         a.JIBUL_TAG,   " + 
     "         to_char(a.JIBUL_DATE,'YYYY.MM.DD') JIBUL_DATE,   " + 
     "         a.pay_amt," + 
     "         a.income_tax," + 
     "         a.civil_tax," + 
     "         a.pay_amt - a.income_tax - a.civil_tax  netpay_amt" + 
     "    FROM L_LABOR_DAILYWORK  a," + 
     "         L_LABOR_BASIC b," + 
     "         Y_BUDGET_DETAIL c" + 
     "  WHERE a.dept_code = b.dept_code" + 
     "    and a.civil_register_number = b.civil_register_number" + 
     "    and a.dept_code = c.dept_code (+)" + 
     "    and a.SPEC_UNQ_NUM = c.SPEC_UNQ_NUM (+)" + 
     "    and a.dept_code = " + "'" + arg_dept + "'" +
     "    and to_char(a.work_date,'yyyy.mm') = " + "'" + arg_date  + "'"  +
     "    and a.civil_register_number = " + "'" + arg_code + "'" +
	  "   ORDER BY  WORK_DATE ASC " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>