<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT s_order_parent.dept_code,   " + 
     "         s_order_parent.order_number,   " + 
     "         s_estimate_parent.sbcr_code,   " + 
     "         s_order_parent.spec_no_seq,   " + 
     "         s_order_parent.seq,   " + 
     "         s_order_parent.direct_class,   " + 
     "         s_order_parent.llevel,   " + 
     "         s_order_parent.sum_code,   " + 
     "         s_order_parent.name,   " + 
     "         s_order_parent.exe_amt,   " + 
     "         s_order_parent.parent_sum_code,   " + 
     "         s_estimate_parent.ctrl_amt,   " + 
     "         s_sbcr.sbcr_name   " + 
     "    FROM s_estimate_parent,   " + 
     "         s_order_parent,  " + 
     "         s_sbcr  " + 
     "   WHERE ( s_sbcr.sbcr_code = s_estimate_parent.sbcr_code ) and  " + 
     "         ( s_order_parent.dept_code = s_estimate_parent.dept_code ) and  " + 
     "         ( s_order_parent.order_number = s_estimate_parent.order_number ) and  " + 
     "         ( s_order_parent.spec_no_seq = s_estimate_parent.spec_no_seq ) and  " + 
     "         ( ( s_estimate_parent.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( s_estimate_parent.order_number = " + arg_order_number + " ) AND  " + 
     "         ( s_order_parent.parent_sum_code = '" + arg_parent_sum_code + "' ) )   " + 
     "ORDER BY s_order_parent.seq,s_sbcr.sbcr_name  ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>