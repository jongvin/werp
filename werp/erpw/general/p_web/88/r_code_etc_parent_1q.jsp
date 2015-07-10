<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
//     String strUserID;
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("length",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  r_code_etc_parent.class_tag ," + 
     "          r_code_etc_parent.parent_name ," + 
     "          r_code_etc_parent.length     FROM r_code_etc_parent   ORDER BY r_code_etc_parent.class_tag          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>