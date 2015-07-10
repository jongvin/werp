<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class_tag = req.getParameter("arg_class_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("etc_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("detail_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("old_etc_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("old_code",GauceDataColumn.TB_STRING,5));
    String query = "  SELECT  p_code_etc_detail.class_tag ," + 
     "          p_code_etc_detail.etc_code ," + 
     "          p_code_etc_detail.detail_name, p_code_etc_detail.etc_code old_etc_code ,  " +
     "			p_code_etc_detail.old_code " +
     "   FROM p_code_etc_detail      WHERE ( p_code_etc_detail.class_tag = " + "'" + arg_class_tag + "'" + ")  ORDER BY p_code_etc_detail.etc_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>