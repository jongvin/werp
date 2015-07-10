<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_1",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
    String query = "select sbcr_code sbcr_1, sbcr_name													" +
			"			   from (SELECT distinct a.sbcr_code,decode(a.est_yn,'Y',1,2) est_tag,     " +
			"			  	 				 decode(a.choicetag,'Y',1,2) tag,                           " +
			"			                s.sbcr_name, a.chg_amt                                     " +
			"					     FROM m_vender_est a, s_sbcr s                                   " +
			"						 WHERE a.sbcr_code = s.sbcr_code                                  " +
			"						   and a.estimateyymm 	= '" + arg_yymm + "'                      " +
			"						   and estimateseq = " + arg_seq + "                              " +
			"						  order by est_tag, tag, a.chg_amt )                              " +
			"			 where rownum < 4                                                          " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>