<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "select 0 unq_num,																					" +
    		"						0 no_seq,                                                               " +
    		"						sbcr_name,                                                              " +
    		"						rep_name1,                                                              " +
    		"						ctrl_amt,                                                               " +
    		"						rate,                                                                   " +
    		"						long_name                                                               " +
			"				from (SELECT decode(f.est_yn,'Y',1,2) est_tag,											" +	 
			"				 		 decode(f.select_yn,'Y',1,2) tag,                                       " +
			"				 		 s.sbcr_name,                                                           " +
			"				       s.rep_name1,                                                           " +
			"				       e.ctrl_amt,                                                            " +
			"				       decode(a.exe_amt, 0, 0, (e.ctrl_amt/a.exe_amt) * 100) rate,            " +
			"						 p.long_name                                                              " +
			"			  FROM S_ESTIMATE_parent e,                                                        " +
			"			       s_order_parent a,                                                           " +
			"			       s_sbcr s,                                                                 " +
			"				  (SELECT a.sbcr_code sbcr_code,                                              " +
			"				       max(b.dept_code),                                                      " +
			"				       max(c.long_name) long_name                                             " +
			"					 FROM S_ESTIMATE_parent a, s_order_parent b, z_code_dept c                 " +
			"					WHERE a.dept_code      = b.dept_code                                       " +
			"			     	  and a.order_number   = b.order_number                                    " +
			"					  and a.spec_no_seq      = b.spec_no_seq                                   " +
			"					  and a.dept_code 	  = c.dept_code                                       " +
			"			 		group by a.sbcr_code) p,																	" +	
			"					S_ESTIMATE_list f                                                    		" +
			"			 WHERE e.sbcr_code      = s.sbcr_code															" +                                
			"			   and e.dept_code      = a.dept_code                                            " +
			"			   and e.order_number   = a.order_number                                         " +
			"			   and e.spec_no_seq    = a.spec_no_seq                                          " +
			"			   and e.sbcr_code      = p.sbcr_code                              	            " +
			"				and e.sbcr_code      = f.sbcr_code                                				" +
			"			   and e.dept_code      = f.dept_code                                            " +
			"			   and e.order_number   = f.order_number                                         " +
			"				and a.llevel			= 1                                                      " +
			"			   and e.dept_code      = '" + arg_dept_code + "'                                " +
			"			   and e.order_number   = " + arg_order_number + "                               " +
			"			 order by  est_tag, tag, e.ctrl_amt)                                             " +
			"			 where rownum < 6                                                                " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>