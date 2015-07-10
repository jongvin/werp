<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_1",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
    String query = "select sbcr_code sbcr_1, sbcr_name												" +
			"			   from (SELECT distinct a.sbcr_code,decode(a.est_yn,'Y',1,2) est_tag,  " +
			"			  	 				 decode(a.select_yn,'Y',1,2) tag,                        " +
			"			                s.sbcr_name, a.ctrl_amt                                 " +
			"					     FROM S_ESTIMATE_list a, s_sbcr s                             " +
			"						 WHERE a.sbcr_code = s.sbcr_code                               " +  
			"						   and a.dept_code = '" + arg_dept_code + "'                   " +
			"						   and a.order_number = " + arg_order_number + "               " +
			"						  order by est_tag, tag, a.ctrl_amt )                          " +
			"			 where rownum < 4                                                       " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>