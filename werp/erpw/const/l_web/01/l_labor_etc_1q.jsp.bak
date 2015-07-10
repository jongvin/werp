<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonus_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("meal_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("people_pension",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("employ_ins",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("health_ins",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_deduct_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("jumin_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("dailywork",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("civil_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("netpay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     String query = "  SELECT ETC.DEPT_CODE," + 
		"				EtC.CIVIL_REGISTER_NUMBER," + 
		"				EtC.WORK_DATE," + 
		"				NVL(EtC.BONUS_AMT, 0) BONUS_AMT," + 
		"				NVL(ETC.MEAL_AMT, 0) MEAL_AMT," + 
		"				NVL(EtC.ETC_AMT, 0) ETC_AMT," + 
		"				NVL(EtC.PEOPLE_PENSION, 0) PEOPLE_PENSION," + 
		"				NVL(EtC.EMPLOY_INS, 0) EMPLOY_INS," + 
		"				NVL(EtC.HEALTH_INS, 0) HEALTH_INS," + 
		"				NVL(EtC.ETC_DEDUCT_AMT, 0) ETC_DEDUCT_AMT," + 
		"				L_LABOR_BASIC.DEPT_CODE," + 
		"				L_LABOR_BASIC.CIVIL_REGISTER_NUMBER  JUMIN_NUMBER," + 
		"				L_LABOR_BASIC.LABOR_NAME," + 
		"				L_CODE_JOB.JOB_NAME," + 
		"				NVL(DAILYWORK.DAILYWORK, 0) DAILYWORK," + 
		"				NVL(DAILYWORK.PAY_AMT, 0) PAY_AMT," + 
		"				NVL(DAILYWORK.INCOME_TAX, 0) INCOME_TAX," + 
		"				NVL(DAILYWORK.CIVIL_TAX, 0) CIVIL_TAX," +   
		"				NVL(DAILYWORK.PAY_AMT, 0) + NVL(EtC.BONUS_AMT, 0) + NVL(EtC.MEAL_AMT, 0)" +   
		"					+ NVL(EtC.ETC_AMT, 0) - NVL(DAILYWORK.INCOME_TAX, 0) - NVL(DAILYWORK.CIVIL_TAX, 0)" +   
		"					- NVL(EtC.PEOPLE_PENSION, 0) - NVL(EtC.EMPLOY_INS, 0)" +   
		"					- NVL(EtC.HEALTH_INS, 0) - NVL(EtC.ETC_DEDUCT_AMT, 0)  NETPAY_AMT " +   
		"		 FROM L_CODE_JOB," + 
		"				L_LABOR_BASIC," + 
		"				( SELECT L_LABOR_DAILYWORK.CIVIL_REGISTER_NUMBER," + 
		"							SUM(L_LABOR_DAILYWORK.DAILYWORK) DAILYWORK," + 
		"							SUM(L_LABOR_DAILYWORK.PAY_AMT) PAY_AMT," + 
		"							SUM(L_LABOR_DAILYWORK.INCOME_TAX) INCOME_TAX," + 
		"							SUM(L_LABOR_DAILYWORK.CIVIL_TAX) CIVIL_TAX " +  
		"					 FROM L_LABOR_DAILYWORK " +  
		"				  WHERE ( L_LABOR_DAILYWORK.DEPT_CODE = '" + arg_dept + "') and " +
		"						  ( L_LABOR_DAILYWORK.WORK_DATE >= TO_DATE('" + arg_date + "', " + "'YYYY.MM.DD'" + ") ) AND " +  
		"						  ( L_LABOR_DAILYWORK.WORK_DATE <  ADD_MONTHS(TO_DATE(" + "'" + arg_date + "'" + ", " + "'YYYY.MM.DD'" + "),1) ) " +   
		"					 GROUP BY L_LABOR_DAILYWORK.CIVIL_REGISTER_NUMBER " + 
		"	         ) DAILYWORK," +   
		"				( SELECT L_LABOR_EtC.DEPT_CODE," + 
		"							L_LABOR_EtC.CIVIL_REGISTER_NUMBER," + 
		"							L_LABOR_EtC.WORK_DATE," + 
		"							L_LABOR_EtC.BONUS_AMT," + 
		"							L_LABOR_EtC.MEAL_AMT," + 
		"							L_LABOR_EtC.ETC_AMT," + 
		"							L_LABOR_EtC.PEOPLE_PENSION," + 
		"							L_LABOR_EtC.EMPLOY_INS," + 
		"							L_LABOR_EtC.HEALTH_INS," + 
		"							L_LABOR_EtC.ETC_DEDUCT_AMT " +  
		"					 FROM L_LABOR_ETC " + 
		"				  WHERE ( L_LABOR_ETC.DEPT_CODE = '" + arg_dept + "') and " +
		"						  ( L_LABOR_ETC.WORK_DATE >= TO_DATE('" + arg_date + "', " + "'YYYY.MM.DD'" + ") ) AND " +  
		"						  ( L_LABOR_ETC.WORK_DATE <  ADD_MONTHS(TO_DATE('" + arg_date + "', " + "'YYYY.MM.DD'" + "),1) ) " +   
		"	          ) ETC " +  
		"	  WHERE ( L_LABOR_BASIC.JOB_CODE              = L_CODE_JOB.JOB_CODE ) and " +  
		"			  ( l_labor_basic.civil_register_number = dailywork.civil_register_number ) and " + 
		"			  ( dailywork.civil_register_number     = etc.civil_register_number(+) ) and " +  
		"	        ( l_labor_basic.dept_code = '" + arg_dept + "'") " +
      "     ORDER BY L_LABOR_BASIC.LABOR_NAME  ASC," + 
      "           L_LABOR_BASIC.CIVIL_REGISTER_NUMBER ASC        ";
     
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>