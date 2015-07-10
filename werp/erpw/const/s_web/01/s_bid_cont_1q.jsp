<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_wbs_code = req.getParameter("arg_wbs_code");
     String arg_from_dt = req.getParameter("arg_from_dt");
     String arg_to_dt = req.getParameter("arg_to_dt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("request_cnt",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("est_cnt",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("sel_cnt",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("text",GauceDataColumn.TB_STRING,50));
    String query = "select a.sbcr_code,   																								" +
		"					 a.sbcr_name,                                                                                " +
		"					 a.rep_name1,                                                                                " +
		"					 count(a.sbcr_code) request_cnt,                                                             " +
		"					 sum(a.est_cnt) est_cnt,                                                                     " +
		"					 sum(a.sel_cnt) sel_cnt,                                                                     " +
		"					 ' ' text                                                                                    " +
		"	     from (select b.sbcr_code,                                                                           " +
		"							b.sbcr_name,                                                                           " +
		"							b.rep_name1,                                                                           " +
		"							decode(d.est_yn, 'Y', 1, 0) est_cnt,                                                   " +
		"							decode(d.select_yn , 'Y', 1, 0) sel_cnt                                                " +
		"					 from s_order_list a,                                                                        " +
		"							s_sbcr b,                                                                              " +
		"							s_estimate_list  d                                                                     " +
		"					where b.sbcr_code = a.sbcr_code                                                              " +
		"					  and d.dept_code = a.dept_code                                                              " +
		"					  and d.order_number = a.order_number                                                        " +
		"					  and ( d.profession_wbs_code = '" + arg_wbs_code + "' or '" + arg_wbs_code + "' = '@' )     " +
		"					  and to_char(a.pr_dt,'yyyy.mm.dd') between '" + arg_from_dt + "' and '" + arg_to_dt + "'    " +
		"	        ) a                                                                                              " +
		"	  group by a.sbcr_code,                                                                                  " +
		"			     a.sbcr_name,                                                                                  " +
		"			     a.rep_name1	                                                                                 " +
		"	order by sum(a.est_cnt)  desc,                                                                           " +
		"				sum(a.sel_cnt) desc,                                                                            " +
		"	         a.sbcr_name asc,                                                                                " +
		"	         a.rep_name1 asc,                                                                                " +
		"	         a.sbcr_code asc                                                                                 " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>