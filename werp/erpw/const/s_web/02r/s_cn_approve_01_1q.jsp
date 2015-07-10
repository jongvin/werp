<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("warrant_term",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("delay_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_cash_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("prgs_bill_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_amt_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_pay1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,100));
    String query = " SELECT 0 unq_num,																" +
		 "   			  g.long_name,                                                    " +
		 "             d.profession_wbs_name sbc_name,                                " +
		 "             to_char(a.start_dt,'yyyy.mm.dd') start_dt,                     " +
		 "             to_char(a.end_dt,'yyyy.mm.dd') end_dt,                         " +
		 "             c.sbcr_name,                                                   " +
		 "             a.warrant_term,                                                " +
		 "             a.delay_rt2 delay_rt,                                          " +
		 "             a.sbc_guarantee_rt sbc_guarantee_rt,                           " +
		 "             a.warrant_guarantee_rt warrant_guarantee_rt,                   " +
		 "             0 cnt_previous_amt,                                            " +
			"				  0 previous_amt,                                              " +
		 "             a.directamt_rt prgs_cash_rt,                                   " +
		 "             100 - directamt_rt prgs_bill_rt,                               " +
		 "             a.previous_pay2 previous_amt_rt,                               " +
		 "             a.previous_pay1 previous_pay1,                                 " +
		 "             0 sbc_guarantee_amt,                                           " +
		 "             0 warrant_guarantee_amt,                                       " +
		 "             '    ' title                                                   " +
		 "       FROM  z_code_dept g,                                                 " +
		 "             s_order_list a,                                                " +
		 "				  (select sbcr_name                                               " +
		 "						from (SELECT decode(e.est_yn,'Y',1,2) est_tag,					" +
		 "					  			decode(e.select_yn,'Y',1,2) tag,                      " +
		 "							s.sbcr_name                                              " +    
		 "						  FROM s_estimate_list e,                                   " +         
		 "						       s_sbcr s                                             " +
		 "						 WHERE e.sbcr_code      = s.sbcr_code                       " +         
		 "						   and e.dept_code      = '" + arg_dept_code + "'           " +         
		 "						   and e.order_number   = " + arg_order_number + "          " +
		 "						 order by  est_tag, tag, e.ctrl_amt)                        " +
		 "		   where rownum =1) c,                                         			" +
			"				  s_profession_wbs d                                           " +
		 "       WHERE g.dept_code         = a.dept_code                              " +
			"			 and a.profession_wbs_code = d.profession_wbs_code                " +
		 "         and a.dept_code         = '" + arg_dept_code + "'                  " +
		 "         and a.order_number      = " + arg_order_number + "                 " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>