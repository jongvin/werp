<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_profession_name = req.getParameter("arg_profession_name");
     String arg_profession_code = req.getParameter("arg_profession_code");
     arg_profession_name = "%" + arg_profession_name + "%";
     arg_profession_code = "%" + arg_profession_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
    String query = " SELECT  s_profession_wbs.profession_wbs_code ," + 
     "      s_profession_wbs.profession_wbs_name " + 
     "     FROM s_profession_wbs     " + 
     "     WHERE ( s_profession_wbs.profession_wbs_name like " + "'" + arg_profession_name + "'" + ") " +  
     "          or  ( s_profession_wbs.profession_wbs_code like " + "'" + arg_profession_code + "'" + " )       " +
     "   order by s_profession_wbs.profession_wbs_code asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>