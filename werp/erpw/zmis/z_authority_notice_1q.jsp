<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sys_id = req.getParameter("arg_sys_id");
     String arg_expire = req.getParameter("arg_expire");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sys_id",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("write_time",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("display_expire",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,2000));
    String query = "  SELECT  sm_auth_notice.sys_id ," + 
     "          to_char(sm_auth_notice.write_time,'yyyy.mm.dd') write_time ," + 
     "          z_authority_user.name ," + 
     "          sm_auth_notice.user_id ," + 
     "          to_char(sm_auth_notice.display_expire,'yyyy.mm.dd') display_expire ," + 
     "          sm_auth_notice.title, " + 
     "          sm_auth_notice.contents     FROM sm_auth_notice ," + 
     "          z_authority_user     WHERE ( sm_auth_notice.user_id = z_authority_user.user_id ) and  " + 
     "                  ( ( sm_auth_notice.sys_id = '" + arg_sys_id + "') and   " + 
     "                    ( TO_CHAR(sm_auth_notice.display_expire,'yyyy.mm.dd') >= '" + arg_expire + "') ) " + 
     "         ORDER BY sm_auth_notice.display_expire          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>