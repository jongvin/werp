<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_seq_no = req.getParameter("arg_seq_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pgrm_above_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pgrm_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pgrm_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pgrm_id",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  z_pgrm_content.pgrm_above_key ," + 
     "          z_pgrm_content.pgrm_seq_key ," + 
     "          z_pgrm_content.no_seq ," + 
     "          z_pgrm_content.pgrm_name ," + 
     "          z_pgrm_content.pgrm_id, " + 
     "          z_pgrm_content.rw_tag " + 
     "  FROM z_pgrm_content     " + 
     "  WHERE ( z_pgrm_content.pgrm_above_key = " + arg_seq_no + " ) order by no_seq       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>