<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_NUMBER,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
    String query = "  select a.order_number,														" +
		"                      a.sbcr_code,															" +
		"                   	  a.order_name,														" +
		"	                    (select sbcr_name 													" +
		"                         from s_sbcr 														" +
		"                        where sbcr_code=a.sbcr_code									" +
		"                      ) sbcr_name															" +
  		"                 from s_cn_list a															" +
 		"                where a.dept_code='" + arg_dept_code + "'							";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>