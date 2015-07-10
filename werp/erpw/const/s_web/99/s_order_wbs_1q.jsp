<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("parent_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("detail_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  s_order_wbs.order_wbs_code ," + 
     "          s_order_wbs.seq ," + 
     "          s_order_wbs.llevel ," + 
     "          s_order_wbs.parent_wbs_code ," + 
     "          s_order_wbs.detail_yn ," + 
     "          s_order_wbs.name ," + 
     "          s_order_wbs.note     FROM s_order_wbs   ORDER BY s_order_wbs.order_wbs_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>