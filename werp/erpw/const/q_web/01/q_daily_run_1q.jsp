<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("run_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("equp_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("run_time",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("suspension_time",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("extra_time",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("settle_time",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("settle_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inv_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fuel_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("fuel_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("oil_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("oil_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("repair_remark",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("repair_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("move_remark",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("move_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("run_remark",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("eqp_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("eqp_size",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("price_method",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  q_daily_run.dept_code ," + 
     "          					to_char(q_daily_run.run_date,'YYYY.MM.DD') run_date ," + 
     "          					q_daily_run.equp_code ," + 
     "          					q_daily_run.seq ," +        																		
     "          					q_daily_run.spec_no_seq ," +																		 
     "          					q_daily_run.spec_unq_num ," 																		+ 
     "          					q_daily_run.run_time ," +   																		
     "          					q_daily_run.suspension_time 																		," + 
     "          					q_daily_run.extra_time ," + 																		
     "          					q_daily_run.settle_time ," +																		 
     "          					q_daily_run.unitcost ," +   																		
     "          					q_daily_run.settle_amt ," + 																		
     "          					q_daily_run.inv_tag ," + 
     "          					q_daily_run.fuel_qty ," + 
     "          					q_daily_run.fuel_amt ," + 
     "          					q_daily_run.oil_qty ," + 
     "          					q_daily_run.oil_amt ," + 
     "          					q_daily_run.repair_remark ," + 
     "          					q_daily_run.repair_amt ," + 
     "          					q_daily_run.move_remark ," + 
     "          					q_daily_run.move_amt ," + 
     "          					q_daily_run.run_remark ," + 
     "          					q_code_equipment.eqp_name ," + 
     "          					q_code_equipment.eqp_size, " +
     "          					q_code_equipment.price_method, " +
     "          					y_budget_detail.name , " +
     "                        F_PARENT_DETAIL_SIZE(q_daily_run.dept_code,q_daily_run.spec_unq_num) spec_name  " + 
     "     					FROM  q_daily_run ," + 
     "          					q_code_equipment, y_budget_detail " +
     "    					WHERE ( q_daily_run.dept_code = q_code_equipment.dept_code (+)) and " +
     "          					( q_daily_run.equp_code = q_code_equipment.equp_code (+)) and " +
     "      						q_daily_run.dept_code = y_budget_detail.dept_code (+) and " +
     " 								q_daily_run.spec_unq_num = y_budget_detail.spec_unq_num (+) and " +
     "         					( ( Q_DAILY_RUN.DEPT_CODE = '" + arg_dept + "' ) and " +
     "								( to_char(Q_DAILY_RUN.RUN_DATE,'YYYY.MM.DD') = '" + arg_date + "' ) )      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>