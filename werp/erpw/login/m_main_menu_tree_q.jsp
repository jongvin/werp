<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_key = req.getParameter("arg_group_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_seq_key",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("rw_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pgrm_id",GauceDataColumn.TB_STRING,60));
	 dSet.addDataColumn(new GauceDataColumn("BackColor",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("ImgC",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("ImgD",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("ImgO",GauceDataColumn.TB_STRING,255));
	 
	 String query = "select group_seq_key," + 
     "       no_seq," + 
     "       rw_tag," + 
     "       level1, " + 
     "       title_name," + 
     "       pgrm_id ,  BackColor," + 
	 "        ImgC,  ImgD , ImgO "+
	 "  from" + 
     "     (SELECT z_group_pgrm_title.group_seq_key,   " + 
     "         z_group_pgrm_title.no_seq * 1000000 no_seq,    " + 
     "         z_group_pgrm_title.rw_tag," + 
     "         to_number(z_group_pgrm_title.level1) level1,   " + 
     "         z_group_pgrm_title.title_name," + 
     "         '                                        ' pgrm_id,  'white' BackColor," + 
	 "        'apple_c' ImgC, 'apple_d' ImgD ,'apple_o' ImgO "+
     "        FROM z_group_pgrm_title  " + 
     "        WHERE z_group_pgrm_title.group_key = " + arg_group_key + "  " + 
     "     union all" + 
     "      SELECT z_group_pgrm_content.pgrm_seq_key,   " + 
     "          z_group_pgrm_title.no_seq  * 1000000 + z_group_pgrm_content.no_seq no_seq,   " + 
     "          z_group_pgrm_content.rw_tag, " + 
     "          to_number(z_group_pgrm_title.level1) + 1 level1,   " + 
     "          z_pgrm_content.pgrm_name,   " + 
     "          z_pgrm_content.pgrm_id, "+
	 "         decode(z_group_pgrm_content.rw_tag , 'P', 'antiquewhite', 'azure') BackColor , " + 
	 "        'apple_c' ImgC, 'apple_d' ImgD ,'apple_o' ImgO "+
	 "      FROM z_group_pgrm_content,   " + 
     "          z_pgrm_content,   " + 
     "          z_group_pgrm_title  " + 
     "      WHERE ( z_group_pgrm_title.group_key = z_group_pgrm_content.group_key ) and " +
     "            ( z_group_pgrm_title.group_seq_key = z_group_pgrm_content.group_seq_key ) and  " + 
     "            ( z_group_pgrm_content.pgrm_seq_key = z_pgrm_content.pgrm_seq_key ) and  " + 
     "            ( ( z_group_pgrm_title.group_key = " + arg_group_key + " ) )   )" + 
     " " + 
     " order by no_seq     ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>