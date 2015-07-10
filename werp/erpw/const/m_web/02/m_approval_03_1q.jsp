<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
    String query = "  select 0 unq_num,										" +	
    		"		 0 no_seq,                                            " +   
    		"		 b.name,                                              " +   
    		"		 b.ssize,                                             " +   
    		"		 b.unitcode,                                          " +   
    		"		 b.qty,                                               " +   
    		"		 b.unitprice,                                         " +   
    		"		 b.amt,                                               " +   
    		"		 '    ' user_id                                       " +   
			"	 from m_approval a, m_approval_detail b                  " +   
			"	where a.dept_code = b.dept_code(+)                       " +   
			"	  and a.approym = b.approym(+)                           " +   
			"	  and a.approseq = b.approseq(+)                         " +   
			"	  and a.chg_cnt = b.chg_cnt(+)                           " +   
			"	  and a.dept_code = '" + arg_dept +  "'                  " +       
			"	  and a.approym = '" + arg_date +  "'                    " +        
			"	  and a.approseq = " + arg_seq +  "                      " ;   
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>