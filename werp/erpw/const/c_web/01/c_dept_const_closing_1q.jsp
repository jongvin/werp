<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bonsa_status",GauceDataColumn.TB_STRING,10));
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
    String query = "select a.dept_code,																		" +
      "                    to_char(a.yymm, 'yyyy.mm') yymm,												" +
      " 							to_char(a.yymm, 'yyyy.mm.dd') yymmdd,										" +
      " 							to_char(a.yymm, 'yyyy.mm.dd') key_yymmdd,									" +
		"	 						a.bonsa_close,																		" +
		"                    decode(nvl(a.bonsa_close,'N'),'Y','����','N','�̸���') bonsa_status, " +
		"	 						a.cost_close,																		" +
		"                    decode(nvl(a.cost_close,'N'),'Y','����','N','������') cost_status, " +
		"							nvl(a.s_close,'N') s_close,						" +
		"							nvl(a.m_close,'N') m_close,						" +
		"							nvl(a.l_close,'N') l_close,						" +
		"							nvl(a.q_close,'N') q_close,						" +
		"							nvl(a.f_close,'N') f_close,						" +
		"	 						a.bigo1,																				" +
		"	 						a.bigo2,																				" +
		"	 						a.bigo3																				" +
  		"					 from c_spec_const_closing a															" +
 		"					where a.dept_code = '" + arg_dept_code + "'										" +
		"              order by a.yymm desc                                      					" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					