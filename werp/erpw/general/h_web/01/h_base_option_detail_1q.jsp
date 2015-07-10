<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_cls_code = req.getParameter("arg_cls_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cls_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("elem_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("elem_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("base_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("old_elem_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  h_base_option_detail.dept_code ," + 
     "          h_base_option_detail.cls_code ," + 
     "          h_base_option_detail.elem_code ," + 
     "          h_base_option_detail.elem_name ," + 
     "          h_base_option_detail.base_yn ," + 
     "          h_base_option_detail.remark ,   " + 
     "          h_base_option_detail.elem_code old_elem_code " + 
     "        FROM h_base_option_detail   " + 
     "        WHERE ( h_base_option_detail.dept_code = '" + arg_dept_code + "') And   " + 
     "              ( h_base_option_detail.cls_code = '" + arg_cls_code  + "')       "  + 
     "        order by h_base_option_detail.elem_code " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>