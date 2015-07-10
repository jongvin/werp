<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("mtrgrand",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("acctag",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT MTRCODE,   " + 
						  "         NAME,   " + 
						  "         SSIZE,   " + 
						  "         UNITCODE,   " + 
						  "         acctag,  " + 
						  "         mtrgrand,  " + 
						  "   ( select child_name from z_code_etc_child where class_tag = '006' and etc_code =  M_CODE_MATERIAL.ditag ) DITAG " +
						  "    FROM M_CODE_MATERIAL  " + 
						  "   WHERE ( NAME like " + "'" + arg_name + "'" + 
						  "      or mtrcode like '" + arg_name + "' ) " + 
						  "   order by mtrcode ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>