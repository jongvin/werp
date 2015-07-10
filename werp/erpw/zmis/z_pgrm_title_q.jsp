<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //  String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pgrm_above_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  z_pgrm_title.pgrm_above_key ," + 
     "          z_pgrm_title.no_seq ," + 
     "          z_pgrm_title.level1 ," + 
     "          z_pgrm_title.title_name ," + 
     "          z_pgrm_title.level_code,  " + 
     "          z_pgrm_title.rw_tag  " + 
     "     FROM z_pgrm_title  order by z_pgrm_title.no_seq      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>