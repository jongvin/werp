<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_where = req.getParameter("arg_where");
     			arg_where = arg_where.replace('!','+'); 
	  String arg_name = req.getParameter("arg_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_status",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("s_close",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("m_close",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("l_close",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("q_close",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("f_close",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bigo1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo3",GauceDataColumn.TB_STRING,20));
    String query = "select b.dept_code,																		" +
      "							b.long_name,																		" +
      " 							to_char(a.yymm, 'yyyy.mm.dd') yymmdd,										" +
		"	 						a.bonsa_close,																		" +
		"	 						a.cost_close,																		" +
		"                    decode(nvl(a.cost_close,'N'),'Y','제출','N','미제출') cost_status,			" +
		"							decode(nvl(a.s_close,'N'),'Y','마감','N','미마감') s_close,						" +
		"							decode(nvl(a.m_close,'N'),'Y','마감','N','미마감') m_close,						" +
		"							decode(nvl(a.l_close,'N'),'Y','마감','N','미마감') l_close,						" +
		"							decode(nvl(a.q_close,'N'),'Y','마감','N','미마감') q_close,						" +
		"							decode(nvl(a.f_close,'N'),'Y','마감','N','미마감') f_close,						" +
		"	 						a.bigo1,																				" +
		"	 						a.bigo2,																				" +
		"	 						a.bigo3																				" +
  		"					 from c_spec_const_closing a,															" +
  		"                    z_code_dept b																		" +
 		"					where a.dept_code(+) = b.dept_code 													" +
 		"                and b.long_name like '%" + arg_name + "%'										" +
      							arg_where +
		"	 				  and	b.dept_proj_tag = 'P'															" +
		"              order by b.dept_code                                      					" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					