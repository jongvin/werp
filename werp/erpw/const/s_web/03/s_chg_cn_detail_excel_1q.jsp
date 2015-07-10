<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select " + 
            "              substr('           ',1,(m.llevel-1) *2) || m.name name,                  " + 
            "              m.ssize ,                                                                " + 
            "              m.unit ,                                                                 " + 
            "              decode(m.tag,1,0,m.sub_qty) sub_qty,                                     " + 
            "              decode(m.tag,1,0,m.sub_price) sub_price,                                 " + 
            "              m.sub_amt,                                                               " + 
            "              m.exe_amt,                                                               " + 
            "              m.exe_price                                                               " + 
            " 			from                                                                           " + 
            " 				( SELECT  s_chg_cn_list. sbc_name,                                          " + 
            " 						s_chg_cn_parent.dept_code,                                            " + 
            " 						s_chg_cn_parent.chg_degree,                                           " + 
            " 						s_chg_cn_parent.order_number,                                         " + 
            " 						s_chg_cn_parent.name ,                                                " + 
            " 						'                                        ' ssize,                     " + 
            " 						'      ' unit,                                                        " + 
            " 						1 sub_qty,                                                            " + 
            " 						s_chg_cn_parent.sub_amt ,                                             " + 
            " 						s_chg_cn_parent.sub_amt sub_price,                                    " + 
            " 						to_number(s_chg_cn_parent.llevel) llevel,                             " + 
            " 						s_chg_cn_parent.seq * 100000  no_seq ,                                " + 
            " 						1 tag,                                                                " + 
            " 						s_chg_cn_parent.exe_amt,                                              " + 
            " 						0  exe_price                                    " + 
            " 						FROM s_chg_cn_parent, s_chg_cn_list                                   " + 
            " 					WHERE s_chg_cn_parent.dept_code = s_chg_cn_list.dept_code                " + 
            " 					  and s_chg_cn_parent.order_number = s_chg_cn_list.order_number          " + 
            " 					  and s_chg_cn_parent.chg_degree = s_chg_cn_list.chg_degree              " + 
            " 					  and s_chg_cn_parent.dept_code 		= '" + arg_dept_code + "'            " + 
            " 					  and s_chg_cn_parent.chg_degree 	= " + arg_chg_degree + "             " + 
            " 					  and s_chg_cn_parent.order_number 	= " + arg_order_number + "           " + 
            " 				UNION ALL                                                                   " + 
            " 				SELECT s_chg_cn_list. sbc_name,                                             " + 
            " 					s_chg_cn_detail.dept_code,                                               " + 
            " 					s_chg_cn_detail.chg_degree,                                              " + 
            " 					s_chg_cn_detail.order_number,                                            " + 
            " 					s_chg_cn_detail.name ,                                                   " + 
            " 					s_chg_cn_detail.ssize ,                                                  " + 
            " 					s_chg_cn_detail.unit ,                                                   " + 
            " 					s_chg_cn_detail.sub_qty ,                                                " + 
            " 					s_chg_cn_detail.sub_amt ,                                                " + 
            " 					s_chg_cn_detail.sub_price ,                                              " + 
            " 					to_number(s_chg_cn_parent.llevel) + 1 llevel,                            " + 
            " 					s_chg_cn_parent.seq  * 100000 + s_chg_cn_detail.seq no_seq,              " + 
            " 					2 tag,                                                                   " + 
            " 					s_chg_cn_detail.exe_amt,                                                 " + 
            " 					s_chg_cn_detail.exe_price                                                " + 
            " 					FROM s_chg_cn_detail , s_chg_cn_parent , s_chg_cn_list                   " + 
            " 				WHERE s_chg_cn_parent.dept_code 		= s_chg_cn_detail.dept_code             " + 
            " 				  and s_chg_cn_parent.order_number 	= s_chg_cn_detail.order_number          " + 
            " 				  and s_chg_cn_parent.chg_degree 	= s_chg_cn_detail.chg_degree            " + 
            " 				  and s_chg_cn_parent.spec_no_seq 	= s_chg_cn_detail.spec_no_seq           " + 
            " 				  and s_chg_cn_parent.dept_code 		= s_chg_cn_list.dept_code               " + 
            " 				  and s_chg_cn_parent.order_number = s_chg_cn_list.order_number             " + 
            " 				  and s_chg_cn_parent.chg_degree = s_chg_cn_list.chg_degree                 " + 
            " 				  and s_chg_cn_detail.dept_code 		= '" + arg_dept_code + "'               " + 
            " 				  and s_chg_cn_detail.chg_degree 	= " + arg_chg_degree + "                " + 
            " 				  and s_chg_cn_detail.order_number 	= " + arg_order_number + " ) m,         " + 
            " 				  z_code_dept n,                                                            " + 
            " 				  z_code_comp p                                                             " + 
            "    where m.sub_qty <> 0  				                                                 " + 
            "      and m.dept_code = n.dept_code                                                    " + 
            "      and n.comp_code = p.comp_code(+)                                                 " + 
            "   order by m.no_seq                                                                   " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>