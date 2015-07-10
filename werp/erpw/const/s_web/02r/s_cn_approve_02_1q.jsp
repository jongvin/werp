<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("subsum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("subsum_exeamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("subsum_subamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_exeamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_subamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_1",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("b_1",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("c_1",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("a_2",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("b_2",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("c_2",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("sub_a",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("sub_b",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("sub_c",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("a_3",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("b_3",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("c_3",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("tot_a",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("tot_b",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("tot_c",GauceDataColumn.TB_DECIMAL,5,2));
    String query = " SELECT 0 unq_num,    																				" +																											 																		
         "      NVL(a.amt, 0) amt_1,                                                                  " +               
			" 		 NVL(a.exe_amt, 0) exe_amt_1,                                                          " +               
			"      NVL(a.sub_amt, 0) sub_amt_1,                                                          " +               
			"      NVL(b.amt, 0) amt_2,                                                                  " +               
			"      NVL(b.exe_amt, 0) exe_amt_2,                                                          " +               
			"      NVL(b.sub_amt, 0) sub_amt_2,                                                          " +               
			"      NVL(c.amt, 0) amt_3,                                                                  " +               
			"      NVL(c.exe_amt, 0) exe_amt_3,                                                          " +               
			"      NVL(c.sub_amt, 0) sub_amt_3,                                                          " +               
			"      NVL((a.amt + b.amt), 0) subsum_amt,                                                   " +                 
			"      NVL((a.exe_amt + b.exe_amt), 0) subsum_exeamt,                                        " +                           
			"      NVL((a.sub_amt + b.sub_amt), 0) subsum_subamt,                                        " +                         
			"      NVL((a.amt + b.amt + c.amt), 0) sum_amt,                                              " +                    
			"      NVL((a.exe_amt + b.exe_amt + c.exe_amt), 0) sum_exeamt,                               " +                                   
			"      NVL((a.sub_amt + b.sub_amt + c.sub_amt), 0) sum_subamt,                               " +                                   
			"      decode(NVL(a.exe_amt, 0), 0, 0, (NVL(a.amt, 0)/NVL(a.exe_amt, 0)) * 100) a_1,         " +                                   
			"      decode(NVL(a.exe_amt, 0), 0, 0, (NVL(a.sub_amt, 0)/NVL(a.exe_amt, 0)) * 100) b_1,     " +                                       
			"      decode(NVL(a.amt, 0), 0, 0, (NVL(a.sub_amt, 0)/NVL(a.amt, 0)) * 100) c_1,             " +                       
			"      decode(NVL(b.exe_amt, 0), 0, 0, (NVL(b.amt, 0)/NVL(b.exe_amt, 0)) * 100) a_2,         " +                                   
			"      decode(NVL(b.exe_amt, 0), 0, 0, (NVL(b.sub_amt, 0)/NVL(b.exe_amt, 0)) * 100) b_2,     " +                                       
			"      decode(NVL(b.amt, 0), 0, 0, (NVL(b.sub_amt, 0)/NVL(b.amt, 0)) * 100) c_2,             " +                       
			"      decode(NVL((a.exe_amt + b.exe_amt), 0), 0, 0, (NVL((a.amt + b.amt), 0)/NVL((a.exe_amt + b.exe_amt), 0)) * 100) sub_a,                                            	" +
			"      decode(NVL((a.exe_amt + b.exe_amt), 0), 0, 0, (NVL((a.sub_amt + b.sub_amt), 0)/NVL((a.exe_amt + b.exe_amt), 0)) * 100) sub_b,                                       " +     
			"      decode(NVL((a.amt + b.amt), 0), 0, 0, (NVL((a.sub_amt + b.sub_amt), 0)/NVL((a.amt + b.amt), 0)) * 100) sub_c,                                                       " +
			"      decode(NVL(c.exe_amt, 0), 0, 0, (NVL(c.amt, 0)/NVL(c.exe_amt, 0)) * 100) a_3,                                                                                       " +
			"      decode(NVL(c.exe_amt, 0), 0, 0, (NVL(c.sub_amt, 0)/NVL(c.exe_amt, 0)) * 100) b_3,                                                                                   " +
			"      decode(NVL(c.amt, 0), 0, 0, (NVL(c.sub_amt, 0)/NVL(c.amt, 0)) * 100) c_3,                                                                                           " +
			"      decode(NVL((a.exe_amt + b.exe_amt + c.exe_amt), 0), 0, 0, (NVL((a.amt + b.amt + c.amt), 0)/NVL((a.exe_amt + b.exe_amt + c.exe_amt), 0)) * 100) tot_a,               " +                             
			"      decode(NVL((a.exe_amt + b.exe_amt + c.exe_amt), 0), 0, 0, (NVL((a.sub_amt + b.sub_amt + c.sub_amt), 0)/NVL((a.exe_amt + b.exe_amt + c.exe_amt), 0)) * 100) tot_b,   " +                                         
			"      decode(NVL((a.amt + b.amt + c.amt), 0), 0, 0, (NVL((a.sub_amt + b.sub_amt + c.sub_amt), 0)/NVL((a.amt + b.amt + c.amt), 0)) * 100) tot_c                            " +
			"        FROM (select sum(a.exe_amt) exe_amt, sum(a.sub_amt) amt, sum(b.ctrl_amt) sub_amt               " +
			"						from s_order_parent a,                                                                " +
			"						     s_estimate_parent b,                                                              " +
			"						     (select sbcr_code																						" +
			"									from (SELECT decode(e.est_yn,'Y',1,2) est_tag,                                " +
			"									  			decode(e.select_yn,'Y',1,2) tag,                                     " +
			"												sbcr_code                                                            " +
			"											  FROM s_estimate_list e                                                " +
			"											 WHERE e.dept_code      = '" + arg_dept_code + "'                       " +   
			"											   and e.order_number   = " + arg_order_number + "                      " +
			"											 order by  est_tag, tag, e.ctrl_amt)                                    " +
			"							   where rownum =1) c                                                               " +
			"					where a.dept_code = b.dept_code                                                          " +
			"					  and a.order_number = b.order_number                                                    " +
			"					  and a.spec_no_seq = b.spec_no_seq                                                      " +
			"					  and c.sbcr_code 	= b.sbcr_code                                                       " +
			"					  and a.dept_code = '" + arg_dept_code + "'                                              " +
			"					  and a.order_number = " + arg_order_number + "	                                         " +
			"					  and a.llevel = 2                                                                       " +
			"					  and a.direct_class = '1' ) a,                                                          " +
			"				 (select sum(a.exe_amt) exe_amt, sum(a.sub_amt) amt, sum(b.ctrl_amt) sub_amt                " +
			"						from s_order_parent a,                                                                " +
			"						     s_estimate_parent b,                                                              " +
			"						     (select sbcr_code																						" +
			"									from (SELECT decode(e.est_yn,'Y',1,2) est_tag,                                " +
			"									  			decode(e.select_yn,'Y',1,2) tag,                                     " +
			"												sbcr_code                                                            " +
			"											  FROM s_estimate_list e                                                " +
			"											 WHERE e.dept_code      = '" + arg_dept_code + "'                       " +   
			"											   and e.order_number   = " + arg_order_number + "                      " +
			"											 order by  est_tag, tag, e.ctrl_amt)                                    " +
			"							   where rownum =1) c                                                               " +
			"					where a.dept_code = b.dept_code                                                          " +
			"					  and a.order_number = b.order_number                                                    " +
			"					  and a.spec_no_seq = b.spec_no_seq                                                      " +
			"					  and c.sbcr_code 	= b.sbcr_code                                                       " +
			"					  and a.dept_code = '" + arg_dept_code + "'                                              " +
			"					  and a.order_number = " + arg_order_number + "	                                         " +
			"					  and a.llevel = 2                                                                       " +
			"					  and a.direct_class = '2' ) b,                                                          " +
			"				 (select sum(a.exe_amt) exe_amt, sum(a.sub_amt) amt, sum(b.ctrl_amt) sub_amt                " +
			"						from s_order_parent a,                                                                " +
			"						     s_estimate_parent b,                                                              " +
			"						     (select sbcr_code																						" +
			"									from (SELECT decode(e.est_yn,'Y',1,2) est_tag,                                " +
			"									  			decode(e.select_yn,'Y',1,2) tag,                                     " +
			"												sbcr_code                                                            " +
			"											  FROM s_estimate_list e                                                " +
			"											 WHERE e.dept_code      = '" + arg_dept_code + "'                       " +   
			"											   and e.order_number   = " + arg_order_number + "                      " +
			"											 order by  est_tag, tag, e.ctrl_amt)                                    " +
			"							   where rownum =1) c                                                               " +
			"					where a.dept_code = b.dept_code                                                          " +
			"					  and a.order_number = b.order_number                                                    " +
			"					  and a.spec_no_seq = b.spec_no_seq                                                      " +
			"					  and c.sbcr_code 	= b.sbcr_code                                                       " +
			"					  and a.dept_code = '" + arg_dept_code + "'                                              " +
			"					  and a.order_number = " + arg_order_number + "	                                         " +
			"					  and a.llevel = 2                                                                       " +
			"					  and a.direct_class <> '1'                                                              " +
			"					  and a.direct_class <> '2' ) c 			                                                  " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>