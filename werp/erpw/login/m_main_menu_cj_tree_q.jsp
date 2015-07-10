<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user_id = req.getParameter("arg_user_id");
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
	 
	 String query = "select max(a.group_seq_key) group_seq_key, " +
						 "	      max(a.no_seq) no_seq, " +
						 "       max(a.rw_tag) rw_tag, " +
						 "       max(a.level1) level1, " +
						 "       max(a.title_name) title_name, " +
						 "       max(a.pgrm_id) pgrm_id, " +
						 "       max(a.BackColor) BackColor, " +
						 "       max(a.ImgC) ImgC, " +
						 "       max(a.ImgD) ImgD, " +
						 "       max(a.ImgO) ImgO " +
						 "	from ( select group_seq_key,  " +
						 "	            no_seq,  " +
						 "	            rw_tag, " +
						 "	            level1,  " +
						 "	            title_name, " +
						 "	            pgrm_id ,  BackColor,  " +
						 "		         ImgC,  ImgD , ImgO " +
						 "		    from (SELECT a.group_seq_key,    " +
						 "			              a.no_seq * 1000000 no_seq,     " +
						 "			              a.rw_tag, " +
						 "			              to_number(a.level1) level1,    " +
						 "			              a.title_name, " +
						 "			              '                                        ' pgrm_id,  'white' BackColor, " +
						 "				           'apple_c' ImgC, 'apple_d' ImgD ,'apple_o' ImgO " +
						 "	               FROM z_group_pgrm_title a,  " +
						 "						  ( SELECT a.group_key group_key " +
						 "								FROM z_user_group_connect a,  " +  
						 "									  z_group b,   " +
						 "									  z_authority_user  c " +
						 "							  where c.empno = a.empno " +
						 "								 and a.group_key = b.group_key " +
						 "								 and c.user_id =  '" + arg_user_id + "'" +
						 "									 order by  a.no_seq       ) b " +
						 "	             WHERE a.group_key =  b.group_key   " +
						 "	          union all " +
						 "				  SELECT b.pgrm_seq_key,    " +
						 "							a.no_seq  * 1000000 + b.no_seq no_seq,    " +
						 "							b.rw_tag,  " +
						 "							to_number(a.level1) + 1 level1,     " +
						 "							c.pgrm_name,    " +
						 "							c.pgrm_id, " +
						 "						   decode(b.rw_tag , 'P', 'antiquewhite', 'azure') BackColor ,  " +
						 "						   'apple_c' ImgC, 'apple_d' ImgD ,'apple_o' ImgO " +
						 "					 FROM z_group_pgrm_content b,    " +
						 "							z_pgrm_content c,    " +
						 "							z_group_pgrm_title a  , " +
						 "							( SELECT a.group_key group_key " +
						 "								FROM z_user_group_connect a,   " + 
						 "									  z_group b,   " +
						 "									  z_authority_user  c " +
						 "							  where c.empno = a.empno " +
						 "								 and a.group_key = b.group_key  " +
						 "								 and c.user_id =  '" + arg_user_id + "'" + 
						 "									 order by  a.no_seq       ) d " +
						 "	           WHERE ( a.group_key = b.group_key ) and " +
						 "	                 ( a.group_seq_key = b.group_seq_key ) and   " +
						 "	                 ( b.pgrm_seq_key = c.pgrm_seq_key ) and   " +
						 "	                 ( ( a.group_key =  d.group_key  ) )   )  ) a  " + 
						 "	group by a.group_seq_key,a.no_seq,a.rw_tag,a.level1,a.title_name,a.pgrm_id,a.BackColor,a.ImgC,a.ImgD,a.ImgO " +
						 "	order by a.no_seq " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>