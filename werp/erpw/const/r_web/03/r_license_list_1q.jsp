<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("license_name",GauceDataColumn.TB_STRING,33));
     dSet.addDataColumn(new GauceDataColumn("temp_license_name",GauceDataColumn.TB_STRING,33));
    String query = "select a.license_class_code," + 
     " 		 a.tag," + 
     " 		 a.license_kind_code," + 
     "       a.license_name, " +
     " 		 a.temp_license_name    from ( select license_class_code," + 
     " 					 '1' tag," + 
     " 					 '' license_kind_code," + 
     "                license_class_name  license_name, " +
     " 					 '* ' ||license_class_name temp_license_name	from r_code_license_class  " +
     "	  			union all	select license_class_code," + 
     " 					 '2' tag," + 
     " 					 license_kind_code," + 
     "                license_name," +
     " 					 '    - ' || license_name  temp_license_name	from r_code_license ) a  " +
     " order by a.license_class_code asc," + 
     "          a.tag asc," + 
     "          a.license_kind_code asc      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>