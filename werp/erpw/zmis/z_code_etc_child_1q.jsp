<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class_tag = req.getParameter("arg_class_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("etc_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("child_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("old_etc_code",GauceDataColumn.TB_STRING,5));
    String query = "  SELECT  z_code_etc_child.class_tag ," + 
     "          z_code_etc_child.etc_code ," + 
     "          z_code_etc_child.child_name, z_code_etc_child.etc_code old_etc_code      FROM z_code_etc_child      WHERE ( z_code_etc_child.class_tag = " + "'" + arg_class_tag + "'" + ")  ORDER BY z_code_etc_child.etc_code          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>