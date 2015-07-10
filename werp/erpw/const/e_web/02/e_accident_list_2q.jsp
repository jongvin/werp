<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("accident_date",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("disaster",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dr_accident",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("item_size",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("item_qty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("item_price",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dis_amt",GauceDataColumn.TB_STRING,50));

    String query = "select a.dept_code,																		" +
"			 						(select long_name 																" +
"									   from z_code_dept 																" +
"									  where dept_code=a.dept_code) long_name,									" +
"			 						(select proj_charge 																" +
"										from z_code_dept 																" +
"									  where dept_code=a.dept_code) proj_charge,								" +
//"			 						a.seq,																			" +
"			 						to_char(a.accident_date,'yyyy.mm.dd hh24:mi') accident_date,		" +
"			 						(select child_name 																" +
"									   from e_safety_code_child 													" +
"									  where class_tag = 32 and safety_code=a.disaster_code) disaster, " +
"			 						a.dr_accident,																		" +
" 									b.item_name,																		" +		
" 									b.item_size,																		" +
" 									b.item_qty,																			" +
"									b.item_price,																		" +
"									b.dis_amt																			" +
" 							 from e_disaster_report a,																" +
"			 						e_disaster_report_detail_item b												" +
" 							where a.dept_code = b.dept_code(+) and												" +
"  		 						a.seq = b.seq and																	" +
"									to_char(a.accident_date,'yyyymmdd') between '" + arg_start_date + "' and '" + arg_end_date + "' " +
" order by a.dept_code, a.seq	,b.d_seq																					" ;	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>