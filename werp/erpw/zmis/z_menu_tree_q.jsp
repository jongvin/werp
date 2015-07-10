<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("pgrm_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pgrm_id",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  z_pgrm_title.no_seq * 1000000 + z_pgrm_content.no_seq no_seq," + 
     "              to_number(z_pgrm_title.level1) + 1 level1," + 
     "             z_pgrm_content.pgrm_name pgrm_name," + 
     "          z_pgrm_content.pgrm_id   pgrm_id     " + 
     "           FROM z_pgrm_content," + 
     "             z_pgrm_title  " + 
     "           WHERE ( z_pgrm_title.pgrm_above_key = z_pgrm_content.pgrm_above_key )  and " + 
     "            ( z_pgrm_title.level_code like '01%')  " + 
     "           union all  " + 
     "     SELECT  z_pgrm_title.no_seq * 1000000  no_seq," + 
     "              to_number(z_pgrm_title.level1) level1," + 
     "              z_pgrm_title.title_name," + 
     "           ' '       FROM z_pgrm_title     WHERE  ( z_pgrm_title.level_code like '01%')        ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>