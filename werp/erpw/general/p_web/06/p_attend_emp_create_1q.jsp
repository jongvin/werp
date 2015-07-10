<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_attend_date = req.getParameter("arg_attend_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("attend_date",GauceDataColumn.TB_STRING,20));     
    String query = "    SELECT to_char(a.attend_date,'yyyy.mm') attend_date              " +
						 "		  FROM p_attend_emp  a                                            " +
						 "		 where to_char(a.attend_date,'yyyy') = to_char(to_date('" + arg_attend_date + "'),'yyyy') " + 
						 " group by to_char(a.attend_date,'yyyy.mm') " +
						 "	order by a.attend_date ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>