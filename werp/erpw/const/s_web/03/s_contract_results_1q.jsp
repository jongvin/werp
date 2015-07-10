<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from_dt 		= req.getParameter("arg_from_dt");
     String arg_to_dt 			= req.getParameter("arg_to_dt");
     String arg_class_tag 		= req.getParameter("arg_class_tag");
     String arg_dept_code 		= req.getParameter("arg_dept_code");
     String arg_wbs_code 		= req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("min_sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("max_sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("min_sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("min_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("min_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt2",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select a.dept_code, a.order_number, max(b.order_class) order_class,											" +
	"					 max(g.long_name) long_name,                                                                          " +
	"					 max(substr(c.profession_wbs_code,1,1)) tag,                                                          " +
	"					 max(d.profession_wbs_name) profession_wbs_name,                                                                          " +
	"					 max(e.sbcr_name) sbcr_name,                                                                                    " +
	"					 max(min.sbc_dt) min_sbc_dt,                                                                          " +
	"					 max(max.sbc_dt) max_sbc_dt,                                                                          " +
	"					 NVL(max(amt.cnt_amt), 0) cnt_amt,                                                                    " +
	"					 NVL(max(amt.exe_amt), 0) exe_amt,                                                                    " +
	"					 NVL(max(max.sbc_amt), 0) max_sbc_amt,                                                                " +
	"					 NVL(max(min.sbc_amt), 0) min_sbc_amt,                                                                " +
	"					 max(max.chg_degree) chg_degree,                                                                      " +
	"					 NVL(max(max_amt.sbc_amt), 0) max_amt,                                                                " +
	"					 NVL(max(min_amt.sbc_amt), 0) min_amt,                                                                " +
	"					 NVL(max(max_amt.exe_amt), 0) max_amt2,                                                               " +
	"					 NVL(max(min_amt.exe_amt), 0) min_amt2,                                                               " +
	"					 max(NVL(max_amt.exe_amt, 0)-NVL(min_amt.exe_amt, 0)) result_amt1,                                    " +
	"					 max(NVL(max_amt.sbc_amt, 0)-NVL(min_amt.sbc_amt, 0)) result_amt2                                     " +
	"	 from s_chg_cn_list a,                                                                                            " +
	"	      s_cn_list b,                                                                                                " +
	"			s_order_list c,                                                                                             " +
	"			s_profession_wbs d,                                                                                         " +
	"			s_sbcr e,                                                                                                   " +
	"			z_code_dept g,                                                                                              " +
	"			(select a.dept_code, a.order_number, a.sbc_dt, (a.sbc_amt - a.vat) sbc_amt                                                    " +
	"					  from s_chg_cn_list a, s_cn_list b,                                                                  " +
	"					       (select a.dept_code, a.order_number, min(a.chg_degree) chg_degree                              " +
	"							 	 from s_chg_cn_list a                                                                        " +
	"								 where (a.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')            " +
	"				  					and a.approve_class = '6'                                                                 " +
	"				  				group by a.dept_code, a.order_number ) c                                                     " +
	"				where a.dept_code = b.dept_code                                                                          " +
	"				  and a.order_number = b.order_number                                                                    " +
	"				  and a.dept_code = c.dept_code                                                                          " +
	"				  and a.order_number = c.order_number                                                                    " +
	"				  and (b.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')                         " +
	"				  and a.approve_class = '6'                                                                              " +
	"				  and a.chg_degree = c.chg_degree ) min,                                                                 " +
	"			(select a.dept_code, a.order_number, a.sbc_dt, (a.sbc_amt - a.vat) sbc_amt, a.chg_degree                                      " +
	"					  from s_chg_cn_list a, s_cn_list b,                                                                  " +
	"					       (select a.dept_code, a.order_number, max(a.chg_degree) chg_degree                              " +
	"							 	 from s_chg_cn_list a                                                                        " +
	"								 where (a.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')            " +
	"				  					and a.approve_class = '6'                                                                 " +
	"								group by a.dept_code, a.order_number) c                                                      " +
	"				where a.dept_code = b.dept_code                                                                          " +
	"				  and a.order_number = b.order_number                                                                    " +
	"				  and a.dept_code = c.dept_code                                                                          " +
	"				  and a.order_number = c.order_number                                                                    " +
	"			     and (b.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')                         " +
	"				  and a.approve_class = '6'                                                                              " +
	"				  and a.chg_degree = c.chg_degree  ) max,                                                                " +
	"			(select a.dept_code, a.order_number, sum(a.cnt_amt) cnt_amt, sum(a.exe_amt) exe_amt                         " +
	"					  from s_cn_parent a, s_cn_list b                                                                     " +
	"				where a.dept_code = b.dept_code                                                                          " +
	"				  and a.order_number = b.order_number                                                                    " +
	"				  and b.sbc_dt between '" + arg_from_dt + "' and '" + arg_to_dt + "'                                     " +
	"			     and (b.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')                         " +
	"				  and a.llevel = 1                                                                                       " +
	"				group by a.dept_code, a.order_number  ) amt,                                                             " +
	"			(select a.dept_code, a.order_number, max(a.sbc_dt) sbc_dt, max(a.sbc_amt - a.vat) sbc_amt, max(a.exe_amt) exe_amt   " +
	"					  from s_chg_cn_list a, s_cn_list b,                                                                  " +
	"					       (select a.dept_code, a.order_number, max(a.sbc_dt) sbc_dt                                      " +
	"							 	 from s_chg_cn_list a                                                                        " +
	"								 where (a.sbc_dt between '" + arg_from_dt + "' and '" + arg_to_dt + "')                      " +
	"									and (a.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')            " +
	"				  					and a.approve_class = '6'                                                                 " +
	"				  				group by a.dept_code, a.order_number ) c                                                     " +
	"				where a.dept_code = b.dept_code                                                                          " +
	"				  and a.order_number = b.order_number                                                                    " +
	"				  and a.dept_code = c.dept_code                                                                          " +
	"				  and a.order_number = c.order_number                                                                    " +
	"			  	  and (b.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')                         " +
	"				  and a.approve_class = '6'                                                                              " +
	"				  and a.sbc_dt = c.sbc_dt                                                                                " +
	"				group by a.dept_code, a.order_number	 ) max_amt,                                                       " +
	"		 	(select a.dept_code, a.order_number, max(a.sbc_dt) sbc_dt, max(a.sbc_amt -a.vat) sbc_amt, max(a.exe_amt) exe_amt   " +
	"					  from s_chg_cn_list a, s_cn_list b,                                                                  " +
	"					       (select a.dept_code, a.order_number, max(a.sbc_dt) sbc_dt                                      " +
	"							 	 from s_chg_cn_list a                                                                        " +
	"								 where (a.sbc_dt < '" + arg_from_dt + "')                                                    " +
	"									and (a.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')            " +
	"				  					and a.approve_class = '6'                                                                 " +
	"				  				group by a.dept_code, a.order_number ) c                                                     " +
	"				where a.dept_code = b.dept_code                                                                          " +
	"				  and a.order_number = b.order_number                                                                    " +
	"				  and a.dept_code = c.dept_code                                                                          " +
	"				  and a.order_number = c.order_number                                                                    " +
	"			     and (b.order_class = '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@')                         " +
	"				  and a.approve_class = '6'                                                                              " +
	"				  and a.sbc_dt = c.sbc_dt                                                                                " +
	"				group by a.dept_code, a.order_number) min_amt 		                                                      " +
	"	where a.dept_code 		= b.dept_code                                                                             " +
	"	  and a.order_number 	= b.order_number                                                                          " +
	"		and a.dept_code 		= c.dept_code                                                                             " +
	"		and a.order_number 	= c.order_number                                                                          " +
	"		and c.profession_wbs_code = d.profession_wbs_code(+)                                                           " +
	"		and a.sbcr_code		= e.sbcr_code		                                                                        " +
	"		and a.dept_code 		= g.dept_code(+)                                                                          " +
	"		and a.dept_code 		= min.dept_code(+)                                                                        " +
	"		and a.order_number 	= min.order_number(+)                                                                     " +
	"		and a.dept_code 		= max.dept_code(+)                                                                        " +
	"		and a.order_number 	= max.order_number(+)                                                                     " +
	"		and a.dept_code 		= amt.dept_code(+)                                                                        " +
	"		and a.order_number 	= amt.order_number(+)                                                                     " +
	"	   and a.dept_code 		= max_amt.dept_code(+)                                                                    " +
	"		and a.order_number 	= max_amt.order_number(+)                                                                 " +
	"	   and a.dept_code 		= min_amt.dept_code(+)                                                                    " +
	"		and a.order_number 	= min_amt.order_number(+)                                                                 " +
	"		and b.sbc_dt between '" + arg_from_dt + "' and '" + arg_to_dt + "'                                             " +
	"	   and ((b.order_class 	= '" + arg_class_tag + "' or '" + arg_class_tag + "' = '@') or '" + arg_class_tag + "' = '@') " +
	"	   and a.dept_code like '" + arg_dept_code + "' || '%' 																				" +
	"	   and c.profession_wbs_code like '" + arg_wbs_code + "' || '%'                                                   " +
	"	group by a.dept_code, a.order_number                                                                              " +
	"	order by max(g.long_name)																														" ;	
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>