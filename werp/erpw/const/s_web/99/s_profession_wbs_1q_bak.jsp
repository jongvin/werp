<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
  //   String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("insurance_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_profession_wbs_code",GauceDataColumn.TB_STRING,10));  // key를 update하기위한 보조key
    String query = "  SELECT  s_profession_wbs.profession_wbs_code ," + 
     "          s_profession_wbs.profession_wbs_name ," + 
     "          s_profession_wbs.insurance_yn, " +
     "          s_profession_wbs.profession_wbs_code key_profession_wbs_code "  +   // key를 update하기위한 보조key
     "      FROM s_profession_wbs        " +                                                
     "          ORDER BY s_profession_wbs.profession_wbs_code ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>