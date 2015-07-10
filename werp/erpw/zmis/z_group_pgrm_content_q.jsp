<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_key = req.getParameter("arg_group_key");
     String arg_group_seq_key = req.getParameter("arg_group_seq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_key",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("group_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pgrm_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pgrm_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pgrm_id",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  z_group_pgrm_content.group_key ,z_group_pgrm_content.group_seq_key ," + 
     "          z_group_pgrm_content.pgrm_seq_key ," + 
     "          z_group_pgrm_content.no_seq ," + 
     "          z_group_pgrm_content.rw_tag ," + 
     "          z_pgrm_content.pgrm_name  pgrm_name, " + 
     "          z_pgrm_content.pgrm_id   pgrm_id " + 
     "         FROM z_group_pgrm_content ," + 
     "          z_pgrm_content     WHERE ( z_group_pgrm_content.pgrm_seq_key = z_pgrm_content.pgrm_seq_key (+)) and   " + 
     "           ( ( z_group_pgrm_content.group_key = " + arg_group_key + " )  and " + 
     "             ( z_group_pgrm_content.group_seq_key = " + arg_group_seq_key + ")) " + 
     "           ORDER BY z_group_pgrm_content.no_seq          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>