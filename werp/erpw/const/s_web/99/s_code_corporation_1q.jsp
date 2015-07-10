<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("corporation_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("section_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_corporation_section",GauceDataColumn.TB_STRING,1));   // key를 update하기위한 보조key
    String query = "  SELECT  s_code_corporation.corporation_section ," + 
     "                        s_code_corporation.section_name ," + 
     "                        s_code_corporation.register_chk ," +
     "  	                     s_code_corporation.corporation_section key_corporation_section "  +   // key를 update하기위한 보조key       
     "                   FROM s_code_corporation        " + 
     "                   ORDER BY s_code_corporation.corporation_section " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>