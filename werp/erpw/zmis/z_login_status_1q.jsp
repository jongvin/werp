<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_log_tag = req.getParameter("arg_log_tag");
     String arg_start_time = req.getParameter("arg_start_time");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("log_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ip_address",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("start_time",GauceDataColumn.TB_STRING,21));
     dSet.addDataColumn(new GauceDataColumn("end_time",GauceDataColumn.TB_STRING,21));
     dSet.addDataColumn(new GauceDataColumn("remarks",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  z_login_status.seq_key ," + 
     "          z_login_status.log_tag ," + 
     "          z_login_status.user_id ," + 
     "          z_login_status.empno ," + 
     "          z_login_status.name ," + 
     "          z_login_status.dept_code ," + 
     "          z_login_status.long_name ," + 
     "          z_login_status.ip_address ," + 
     "          z_login_status.start_time ," + 
     "          z_login_status.end_time ," + 
     "          z_login_status.remarks     FROM z_login_status   " + 
     "           WHERE ( z_login_status.log_tag  = '" + arg_log_tag + "')  and      "  + 
     "                 ( z_login_status.start_time  >= '" + arg_start_time + "')       "  + 
     "    order by  z_login_status.seq_key desc       " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>