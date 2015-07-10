<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_mtrcode = req.getParameter("arg_mtrcode");
     String arg_ssize = req.getParameter("arg_ssize");
     String arg_dept = req.getParameter("arg_dept");
     String arg_sbcr = req.getParameter("arg_sbcr");
     String arg_from_dt = req.getParameter("arg_from_dt");
     String arg_to_dt = req.getParameter("arg_to_dt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inputdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("app_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select b.long_name, a.name, c.sbcr_name, a.ssize, a.unitcode,					" +
		"			  to_char(a.yymmdd,'yyyy.mm.dd') inputdate,                                      " +
		"			  nvl(a.unitprice,0) unitprice,                                                  " +
		"			  nvl(a.qty,0) qty,                                                              " +
		"			  nvl(a.amt,0) amt,                                                              " +
		"			  nvl(d.unitprice,0) app_amt																		" +
		"	from m_input_detail a,                                                                 " +
		"			z_code_dept b,                                                                   " +
		"			s_sbcr c,                                                                        " +
		"  		m_approval_detail d																					" +
		"	where                                                                                  " +
		"	a.dept_code  	  = b.dept_code                                                         " +
		"	and a.sbcr_code  = c.sbcr_code                                                         " +
		"	and a.dept_code  = d.dept_code(+)																		" +
		"  and a.approval_unq_num = d.approval_unq_num(+)														" +
		"	and a.mtrcode like '" + arg_mtrcode + "' || '%'                                        " +
		"	and a.ssize like '" + arg_ssize + "' || '%'                                            " +
		"	and a.dept_code like '" + arg_dept + "'||'%'                                           " +
		"	and a.sbcr_code like '" + arg_sbcr + "' || '%'                                         " +
		"	and a.yymmdd between '" + arg_from_dt + "' and '" + arg_to_dt + "'                     " +
		" order by c.sbcr_name					 																		" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>