<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 String arg_dept_code		= req.getParameter("arg_dept_code");
 String arg_sell_code		= req.getParameter("arg_sell_code");
 String arg_from_date		= req.getParameter("arg_from_date");
 String arg_to_date			= req.getParameter("arg_to_date");
 String arg_job_cat1			= req.getParameter("arg_job_cat1");
 String arg_job_cat2			= req.getParameter("arg_job_cat2");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("cat_unq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("intf_key1",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("intf_key2",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("intf_key3",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("job_cat1",GauceDataColumn.TB_STRING,100));
	dSet.addDataColumn(new GauceDataColumn("job_cat2",GauceDataColumn.TB_STRING,100));
	dSet.addDataColumn(new GauceDataColumn("job_cat3",GauceDataColumn.TB_STRING,100));
	dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,255));
	dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("cat_from_dt",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("cat_to_dt",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("work_sell_code",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("work_comp_code",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("work_empno",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("work_emp_name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("work_status",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,256));
	dSet.addDataColumn(new GauceDataColumn("slip_status",GauceDataColumn.TB_STRING,10));
    String query = "select d.cat_unq," + 
							"			d.intf_key1," + 
							"			d.intf_key2," + 
							"			d.intf_key3," + 
							"			d.job_cat1," + 
							"			d.job_cat2," + 
							"			d.job_cat3," + 
							"			d.title," + 
							"			to_char(d.work_dt,'yyyy.mm.dd') work_dt ," + 
							"			to_char(d.cat_from_dt,'yyyy.mm.dd') cat_from_dt ," + 
							"			to_char(d.cat_to_dt,'yyyy.mm.dd') cat_to_dt ," + 
							"			d.work_dept_code," + 
							"			d.work_sell_code," + 
							"			d.work_comp_code," + 
							"			d.work_empno," + 
							"			d.work_emp_name, " + 
							"			d.work_status, " + 
							"			d.memo, " +
							"			decode(d.intf_key1,null,'A',0, 'A',F_T_SLIP_STAT(to_number(d.intf_key1))) slip_status"+
							" from h_slip_cat_intf d "+
							" where d.work_dt between '"+arg_from_date +"' and '"+arg_to_date+"'"+
							"  and d.work_dept_code = '"+arg_dept_code+"'"+
							"  and d.work_sell_code = '"+arg_sell_code+"'"+
							"  and d.job_cat1 = '"+arg_job_cat1+"'"+
							"  and d.job_cat2 = '"+arg_job_cat2+"'"+
							" order by d.cat_unq desc";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>