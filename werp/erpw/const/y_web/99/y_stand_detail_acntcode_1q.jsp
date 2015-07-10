<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_high_detail_code = req.getParameter("arg_high_detail_code");
	 String arg_detail_code = req.getParameter("arg_detail_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("acnt_code",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("acnt_code_key",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("acnt_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("attrib1",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("attrib2",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("attrib3",GauceDataColumn.TB_STRING,255));
    String query = " select high_detail_code,"   +
"        detail_code,"   +
" 			 acnt_code,"   +
" 			 acnt_code acnt_code_key,"   +
" 			 acnt_name,"   +
" 			 input_dt,"   +
" 			 input_name,"   +
" 			 attrib1,"   +
" 			 attrib2,"   +
" 			 attrib3"   +
"   from y_stand_detail_acntcode"   +
"  where high_detail_code = '"+arg_high_detail_code+"'"   +
"    and detail_code = '"+arg_detail_code+"'"  +
" order by acnt_code" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>