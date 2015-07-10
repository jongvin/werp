<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
//     String strUserID;
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("lenght",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  z_code_etc_parent.class_tag ," + 
     "          z_code_etc_parent.parent_name ," + 
     "          z_code_etc_parent.lenght     FROM z_code_etc_parent   ORDER BY z_code_etc_parent.class_tag          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>