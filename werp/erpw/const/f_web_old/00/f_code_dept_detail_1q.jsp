<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp 		= req.getParameter("arg_comp");
     String arg_s_yymm 		= req.getParameter("arg_s_yymm");
     String arg_from_dt 	= req.getParameter("arg_from_dt");
     String arg_to_dt 		= req.getParameter("arg_to_dt");
     String arg_f_yymm 		= req.getParameter("arg_f_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  select distinct a.dept_code,        														" +
			"				       b.long_name,                                                           " +
			"				       b.process_code                                                         " +
			" from  ( select distinct dept_code                                                       " +
			"           from s_pay                                                                    " +
			"          where yymm = '" + arg_s_yymm + "'                                              " +
			"         union all                                                                       " +
			"         select distinct dept_code                                                       " +
			"           from m_vat                                                                    " +
			"          where work_dt between '" + arg_from_dt + "' and '" + arg_to_dt + "'            " +
			"         union all                                                                       " +
			"         select distinct dept_code                                                       " +
			"           from f_preamt_request                                                         " +
			"         where trunc(request_date,'mm') = '" + arg_f_yymm + "'                           " +
			"         union all                                                                       " +
			"         select distinct dept_code                                                       " +
			"           from f_nopay_request                                                          " +
			"         where trunc(request_date,'mm') = '" + arg_f_yymm + "' ) a,                      " +
			"         z_code_dept b                                                                   " +
			" where a.dept_code = b.dept_code                                                         " +
			"   and b.comp_code = '" + arg_comp + "'                                                  " +
			"   and not exists ( select distinct c.dept_code                                          " +
			"                     from f_code_dept c, z_code_dept d                                   " +
			"                    where c.dept_code = d.dept_code                                      " +
			"                      and c.dept_code = a.dept_code                                      " +
			"                      and d.comp_code = '" + arg_comp + "')                              " +
			" order by a.dept_code																								" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>