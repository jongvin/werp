<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_class_tag = req.getParameter("arg_class_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("link_raw",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  license_kind_code ," + 
     "          					license_kind_code key_license_kind_code," + 
     "         					license_class_code, " +
     "								license_name  ,   " +
     "								link_raw , " +
     "								remark " +
     "           			 FROM r_code_license  " +
     "          			WHERE ( license_class_code = " + "'" + arg_class_tag + "'" + ")  " +
     "       			ORDER BY license_kind_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>