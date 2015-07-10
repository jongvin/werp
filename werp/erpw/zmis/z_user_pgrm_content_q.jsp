<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user_key = req.getParameter("arg_user_key");
     String arg_user_seq_key = req.getParameter("arg_user_seq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("user_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pgrm_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pgrm_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  z_user_pgrm_content.user_key ,z_user_pgrm_content.user_seq_key ," + 
     "          z_user_pgrm_content.pgrm_seq_key ," + 
     "          z_user_pgrm_content.no_seq ," + 
     "          z_user_pgrm_content.rw_tag ," + 
     "          z_pgrm_content.pgrm_name  pgrm_name   FROM z_user_pgrm_content ," + 
     "          z_pgrm_content     WHERE  ( z_user_pgrm_content.pgrm_seq_key = z_pgrm_content.pgrm_seq_key ) and   " + 
     "           ( ( z_user_pgrm_content.user_key = " + arg_user_key + " ) and  " + 
     "            ( z_user_pgrm_content.user_seq_key = " + arg_user_seq_key + " ) ) " + 
     "           ORDER BY z_user_pgrm_content.no_seq          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>