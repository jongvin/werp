<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_seq = req.getParameter("arg_seq");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  		select distinct seq,																							" +	
			"							substr('           ',1,(llevel-1) *2) || name name,                                 " +
			"							unit,                                                                               " +
			"							ssize,                                                                              " +
			"				         sub_qty ,                                                                           " +
			"				         sub_price ,                                                                         " +
			"				         sub_amt ,                                                                           " +
			"				         pre_prgs_qty ,                                                                      " +
			"				         pre_prgs_amt ,                                                                      " +
			"				         pre_prgs_rt ,                                                                       " +
			"				         tm_prgs_qty ,                                                                       " +
			"				         tm_prgs_amt ,                                                                       " +
			"				         tm_prgs_rt ,                                                                        " +
			"				         tot_prgs_qty ,                                                                      " +
			"				         tot_prgs_amt ,                                                                      " +
			"				         tot_prgs_rt,                                                                        " +
			"							no_seq                                                                              " +
			"				from (                                                                                       " +
			"	    					SELECT b.seq,                                                                       " +
			"					               b.name,                                                                    " +
			"					               '                              ' unit,                                     " +
			"					               '      ' ssize,                                                            " +
			"							         0 sub_qty ,                                                                " +
			"							         0 sub_price ,                                                              " +
			"							         b.sub_amt ,                                                                " +
			"							         a.pre_prgs_qty ,                                                           " +
			"							         a.pre_prgs_amt ,                                                           " +
			"							         a.pre_prgs_rt ,                                                            " +
			"							         a.tm_prgs_qty ,                                                            " +
			"							         a.tm_prgs_amt ,                                                            " +
			"							         a.tm_prgs_rt ,                                                             " +
			"							         a.tot_prgs_qty ,                                                           " +
			"							         a.tot_prgs_amt ,                                                           " +
			"							         a.tot_prgs_rt,                                                             " +
			"							         2 tag,                                                                     " +
			"	    					         to_number(b.llevel) llevel,                                                " +
			"	    					         b.seq * 1000000  no_seq                                                    " +
			"								    FROM s_prgs_parent a,                                                        " +
			"								    		s_chg_cn_parent b                                                           " +
			"							  WHERE a.dept_code 			= b.dept_code                                            " +
			"							    and a.order_number 		= b.order_number                                         " +
			"							    and a.spec_no_seq 		= b.spec_no_seq                                          " +
         "                        and b.chg_degree = " + arg_chg_degree + "                                       " + 
			"							    and a.dept_code 			= '" + arg_dept_code + "'                                " +
			"							    and a.yymm 				= '" + arg_yymm + "'                                     " +
			"							    and a.seq 					= " + arg_seq + "                                        " +
			"							    and a.order_number 		= " + arg_order_number + "                               " +
			"	    					UNION ALL                                                                           " +
			"							SELECT  b.seq ,                                                                     " +
			"							         b.name ,                                                                   " +
			"							         b.ssize ,                                                                  " +
			"							         b.unit ,                                                                   " +
			"							         b.sub_qty ,                                                                " +
			"							         b.sub_price ,                                                              " +
			"							         b.sub_amt ,                                                                " +
			"							         a.pre_prgs_qty ,                                                           " +
			"							         a.pre_prgs_amt ,                                                           " +
			"							         a.pre_prgs_rt ,                                                            " +
			"							         a.tm_prgs_qty ,                                                            " +
			"							         a.tm_prgs_amt ,                                                            " +
			"							         a.tm_prgs_rt ,                                                             " +
			"							         a.tot_prgs_qty ,                                                           " +
			"							         a.tot_prgs_amt ,                                                           " +
			"							         a.tot_prgs_rt,                                                             " +
			"							         2 tag,                                                                     " +
			"	       				         to_number(c.llevel) + 1 llevel,                                            " +
			"	       				         c.seq  * 1000000 + b.seq no_seq                                            " +
			"							    FROM s_prgs_detail a,                                                           " +
			"							    		s_chg_cn_detail b,                                                             " +
			"							    		s_chg_cn_parent c                                                              " +
			"							  WHERE a.dept_code 			= b.dept_code                                            " +
			"							    and a.order_number 		= b.order_number                                         " +
			"							    and a.spec_no_seq 		= b.spec_no_seq                                          " +
			"							    and a.detail_unq_num 	= b.detail_unq_num                                       " +
         "                        and b.chg_degree = " + arg_chg_degree + "                                       " + 
			"							    and b.dept_code 			= c.dept_code                                            " +
			"							    and b.order_number 		= c.order_number                                         " +
			"							    and b.spec_no_seq 		= c.spec_no_seq                                          " +
         "                        and c.chg_degree = " + arg_chg_degree + "                                       " + 
			"							    and a.dept_code 			= '" + arg_dept_code + "'                                " +
			"							    and a.yymm 				= '" + arg_yymm + "'                                     " +
			"							    and a.seq 					= " + arg_seq + "                                        " +
			"							    and a.order_number 		= " + arg_order_number + " 			)                    " +
			"			ORDER BY no_seq                                                                                 " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>