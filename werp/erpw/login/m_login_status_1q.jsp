<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_seq_key = req.getParameter("arg_seq_key");
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
     dSet.addDataColumn(new GauceDataColumn("system_date",GauceDataColumn.TB_STRING,21));
    String query = "  SELECT  z_login_status.seq_key seq_key," + 
     "          z_login_status.log_tag log_tag," + 
     "          z_login_status.user_id user_id," + 
     "          z_login_status.empno empno," + 
     "          z_login_status.name name," + 
     "          z_login_status.dept_code dept_code," + 
     "          z_login_status.long_name long_name," + 
     "          z_login_status.ip_address ip_address," + 
     "          z_login_status.start_time start_time," + 
     "          z_login_status.end_time end_time," + 
     "          z_login_status.remarks  remarks, " + 
     "          to_char(sysdate,'yyyy.mm.dd hh24:mi:ss') system_date " + 
     "            FROM z_login_status   " + 
     "           WHERE  z_login_status.seq_key = " + arg_seq_key + "       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>