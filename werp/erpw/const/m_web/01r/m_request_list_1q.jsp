<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("requestdate",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("balsin",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bud_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("requiretime",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pre_request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tot_request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_content",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("check_method",GauceDataColumn.TB_STRING,20));
    String query = "  select 0 unq_num,													" +
		"		    0 no_seq,                                                                       " +
		"	       max(a.requestseq) requestseq,													" +
		"			 to_char(max(b.requestdate) ,'yyyy.mm.dd') requestdate,                          " +
		"	       max(c.long_name) long_name,                                                     " +
		"	       decode(max(b.order_class),'1','총액발주','2','단가발주') order_class,           " +
		"		    max(a.name) name, 			                                                      " +
		"		    max(c.long_name) || '       담당 : ' || max(b.owner) balsin,                    " +
		"		    max(a.ssize) ssize,                                                             " +
		"		    max(a.unitcode) unitcode,                                                       " +
		"	       sum(nvl(a.bud_qty,0)) bud_qty,                                                  " +
		"	       max(nvl(a.bud_price,0)) bud_price,                                              " +
		"		    sum(nvl(a.bud_qty,0)) * max(nvl(a.bud_price,0)) bud_tot,                        " +
		"		    to_char(max(a.requiredtime),'yyyy.mm.dd') requiretime,	                        " +
		"		    sum(nvl(a.pre_request_qty,0)) pre_request_qty,                                  " +
		"		    sum(nvl(a.qty,0)) request_qty,                                                  " +
		"		    sum(nvl(a.pre_request_qty,0)) + sum(nvl(a.qty,0)) tot_request_qty,              " +
		"		    sum(exe.exe_amt) exe_amt,                                                       " +
		"	       max(b.proj_content) proj_content,                                               " +
		"	       max(b.check_method) check_method                                                " +
		"	    from m_request b,                                                                  " +
		"	    		z_code_dept c,                                                                " +
		"	    		m_request_detail a,                                                           " +
		"	    		m_plan d,                                                                     " +
		"				(select sum(nvl(bud_qty,0)) * max(nvl(bud_price,0)) exe_amt                   " +
		"					from 	m_request_detail                                                     " +
		"				  where dept_code = '" + arg_dept + "'                                        " +
		"					 and requestseq = " + arg_seq + "                                          " +
		"				  group by name, ssize  ) exe                                                 " +
		"	   where a.dept_code = d.dept_code (+)                                                 " +
		"	     and a.mtrcode   = d.mtrcode (+)                                                   " +
		"	     and a.dept_code = c.dept_code                                                     " +
		"		  and a.dept_code = b.dept_code                                                     " +
		"	     and a.requestseq = b.requestseq                                                   " +
		"		  and a.dept_code = '" + arg_dept + "'                                              " +
		"		  and a.requestseq = " + arg_seq + "                                                " +
		"	group by a.name, a.ssize                                                               " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>