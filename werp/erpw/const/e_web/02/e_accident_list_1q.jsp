<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
     String arg_code = req.getParameter("arg_code");
     String arg_name = req.getParameter("arg_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("accident_date",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("disaster",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dr_accident",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("injure_part_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("injure_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("result_type",GauceDataColumn.TB_STRING,2));
    String query = "select a.dept_code,																		" +
"			 						(select long_name 																" +
"									   from z_code_dept 																" +
"									  where dept_code=a.dept_code) long_name,									" +
"			 						(select proj_charge 																" +
"										from z_code_dept 																" +
"									  where dept_code=a.dept_code) proj_charge,								" +
//"			 						a.seq,																				" +
"			 						to_char(a.accident_date,'yyyy.mm.dd hh24:mi') accident_date,		" +
"			 						(select child_name 																" +
"									   from e_safety_code_child 													" +
"									  where class_tag = 32 and safety_code=a.disaster_code) disaster, " +
"			 						a.dr_accident,																		" +
"			 						b.name,																				" +
"			 						b.civil_register_number,														" +
"			 						b.sbcr_name,																		" +
"			 						(select child_name 																" +
"										from e_safety_code_child 													" +
"									  where class_tag = 35 and safety_code=b.injure_part_code) injure_part_name, " +
"			 						(select child_name 																" +
"										from e_safety_code_child 													" +
"                            where class_tag = 34 and safety_code=b.injure_code) injure_name, " +
"			 						b.result_type																		" +
" 							 from e_disaster_report a,																" +
"			 						e_disaster_report_detail b														" +
" 							where a.dept_code = b.dept_code(+) and												" +
"  		 						a.seq = b.seq and																" +
"									to_char(a.accident_date,'yyyymmdd') between '" + arg_start_date + "' and '" +arg_end_date + "'  " ;

if ( arg_code.equals("@") )
{
}
else if ( arg_code.equals("a.dept_code") )
{
 query +=   "	and a.dept_code in (select dept_code from z_code_dept where proj_charge like '%"+arg_name+"'	)								" ;	    
}
else
{
 query +=   "			and			" + arg_code + " = '"+arg_name+"'								" ;	    
}
 query += " order by a.dept_code, a.seq																		" ;	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>