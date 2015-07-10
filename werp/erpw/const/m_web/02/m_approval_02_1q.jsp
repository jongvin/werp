<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  select 0 unq_num,														" +
      "				 0 no_seq, 												 					   " +
      "				 b.sbcr_name sbcr_name, 													" +
		"				 b.rep_name1 rep_name1,                                        " +
		"				 a.amt amt,                                                    " +
		"				 decode(c.bud_amt,0,0,(a.amt/c.bud_amt)*100) rate              " +
		"		    from m_vender_est a,                                             " +
		"		    		s_sbcr b,                                                   " +
		"		    		(select sum(nvl(b.bud_amt,0)) bud_amt                       " +
		"				    from m_approval_detail a,                                  " +
		"				    		m_request_detail b                                    " +
		"				   where a.request_unq_num = b.request_unq_num                 " +
		"				     and a.dept_code = '" + arg_dept +  "'                     " +
		"					  and a.approym = '" + arg_date +  "'                       " +
		"					  and a.approseq = " + arg_seq +  ") c,                     " +
		"					  m_approval d,                                             " +
		"					  m_approval_sbcr e                                         " +
		"		   where e.sbcr_code 	= b.sbcr_code(+)                             " +
		"		     and d.order_class 	= '1'                                        " +
		"		     and d.dept_code 	= '" + arg_dept +  "'                        " +
		"		     and d.approym 		= '" + arg_date +  "'                        " +
		"		  	  and d.approseq 		= " + arg_seq +  "                           " +
		"			  and a.ESTIMATEYYMM = d.estimateyymm                             " +
		"			  and a.ESTIMATESEQ 	= d.estimateseq                              " +
		"		  	  and d.dept_code 	= e.dept_code                                " +
		"			  and d.approym 		= e.approym                                  " +
		"			  and d.approseq 		= e.approseq                                 " +
		"			  and d.chg_cnt 		= e.chg_cnt                                  " +
		"			  and e.sbcr_code 	= a.sbcr_code                                " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>