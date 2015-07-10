<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_dept_code",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  c_spec_class_child.spec_no_seq spec_no_seq," + 
     "          c_spec_class_child.dept_code dept_code," + 
     "          c_spec_class_child.no_seq no_seq," + 
     "          z_code_dept.long_name long_name," + 
     "          z_code_dept.use_tag use_tag,   " + 
     "          c_spec_class_child.dept_code old_dept_code " + 
     "            FROM c_spec_class_child ," + 
     "          z_code_dept     WHERE ( c_spec_class_child.dept_code  = z_code_dept.dept_code (+)) and  " + 
     "         ( ( c_spec_class_child.spec_no_seq = " + arg_spec_no_seq + "  ) ) " + 
     "           ORDER BY c_spec_class_child.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>