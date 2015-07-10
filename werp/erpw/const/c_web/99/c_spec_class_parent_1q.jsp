<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  c_spec_class_parent.spec_no_seq ," + 
     "          c_spec_class_parent.no_seq ," + 
     "          c_spec_class_parent.sum_code ," + 
     "          c_spec_class_parent.parent_sum_code ," + 
     "          c_spec_class_parent.llevel ," + 
     "          c_spec_class_parent.name    " + 
     "      FROM c_spec_class_parent  " + 
     "     ORDER BY c_spec_class_parent.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>