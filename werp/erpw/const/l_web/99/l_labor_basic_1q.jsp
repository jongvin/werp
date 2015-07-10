<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_number",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("address",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("job_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("civil_number_error_check",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("military",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tel_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("entrance_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("resign_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("transcript",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("labor_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("insurance_get_day",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("time_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("blacklist",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("lastapplydate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cost_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("month_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("key_civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("safety_man",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unemp_insurance",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("national_pension",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("health_insurance",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("nation_code",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("nation_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pay_day",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("safety_manual",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("safety_edu",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("civil_register",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("health_check",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("output_doc",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bankbook",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("salery_bank",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("salery_bank_num",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("blacklist_detail",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,1));

    String query = "  SELECT  l_labor_basic.dept_code ," + 
     "          l_labor_basic.civil_register_number ," + 
     "          l_labor_basic.labor_name ," + 
     "          l_labor_basic.zip_number ," + 
     "          l_labor_basic.address ," + 
     "          l_labor_basic.job_code ," + 
     "          l_labor_basic.civil_number_error_check ," + 
     "          l_labor_basic.unitcost ," + 
     "          l_labor_basic.military ," + 
     "          l_labor_basic.tel_number ," + 
     "          to_char(l_labor_basic.entrance_date,'YYYY.MM.DD')  entrance_date," + 
     "          to_char(l_labor_basic.resign_date,'YYYY.MM.DD')  resign_date," + 
     "          l_labor_basic.transcript ," + 
     "          l_labor_basic.labor_class ," + 
     "          to_char(l_labor_basic.insurance_get_day,'YYYY.MM.DD')  insurance_get_day," + 
     "          l_labor_basic.time_amt ," + 
     "          l_labor_basic.blacklist ," + 
     "          to_char(l_labor_basic.contract_date,'YYYY.MM.DD') contract_date," + 
     "          to_char(l_labor_basic.lastapplydate,'YYYY.MM.DD') lastapplydate," + 
     "          l_labor_basic.cost_tag ," + 
     "          l_labor_basic.month_amt ," + 
     "          l_labor_basic.spec_no_seq ," + 
     "          l_labor_basic.spec_unq_num ," + 
     "	       e.name  spec_name,  " + 
     "          l_code_job.job_name,    " + 
     "          l_labor_basic.civil_register_number key_civil_register_number ,     " + 
     "          l_labor_basic.safety_man,    " + 
     "          l_labor_basic.unemp_insurance,    " + 
     "          l_labor_basic.national_pension,    " + 
     "          l_labor_basic.health_insurance,    " + 
     "          l_labor_basic.nation_code ,   " + 
     "          l_labor_basic.pay_day ,   " + 
     "          (select nation_name_kr from l_nation_code where nation_code = l_labor_basic.nation_code)nation_name , " + 
     "          l_labor_basic.safety_manual,    " + 
     "          l_labor_basic.safety_edu,    " + 
     "          l_labor_basic.civil_register,    " + 
     "          l_labor_basic.health_check,    " + 
     "          l_labor_basic.output_doc,    " + 
     "          l_labor_basic.bankbook,    " + 
     "          l_labor_basic.salery_bank,    " + 
     "          l_labor_basic.salery_bank_num,    " + 
	  "          l_labor_basic.blacklist_detail ,   " +
	  "          ( select decode(count(civil_register_number),0,0,1) count from l_labor_dailywork  " +
     "          where dept_code = l_labor_basic.dept_code and   " +
     "          civil_register_number = l_labor_basic.civil_register_number ) chk_1 ,   " +
	  "          ( select decode(count(civil_register_number),0,0,1) count from l_labor_etc  " +
     "          where dept_code = l_labor_basic.dept_code and   " +
     "          civil_register_number = l_labor_basic.civil_register_number ) chk_2    " +
	  " FROM l_labor_basic ," + 
     "          y_budget_detail e ," + 
     "          l_code_job     " + 
     " WHERE ( l_labor_basic.job_code = l_code_job.job_code (+)) and " +
     "       ( l_labor_basic.dept_code = e.dept_code (+) and " +
     "         l_labor_basic.spec_unq_num = e.spec_unq_num (+) ) and " +
     "       ( ( L_LABOR_BASIC.DEPT_CODE = " + "'" + arg_dept_code + "'" + ") )    ";
%><%@ 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>