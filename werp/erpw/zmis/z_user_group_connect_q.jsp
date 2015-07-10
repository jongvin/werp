<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_empno = req.getParameter("arg_empno");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("group_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("group_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT z_user_group_connect.empno empno,   " + 
     "         z_user_group_connect.group_key group_key,   " + 
     "         z_user_group_connect.no_seq no_seq,   " + 
     "         z_group.group_name  group_name" + 
     "    FROM z_user_group_connect,   " + 
     "         z_group  " + 
     "   WHERE ( z_user_group_connect.group_key = z_group.group_key ) and  " + 
     "         ( ( z_user_group_connect.empno = " + "'" + arg_empno + "'" + " ) )  " + 
     "        order by  z_user_group_connect.no_seq       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>