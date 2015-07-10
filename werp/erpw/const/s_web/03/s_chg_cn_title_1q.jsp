<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.dept_code dept_code,   " + 
     "         a.order_number order_number,   " + 
     "         max(a.const_no) const_no,   " + 
     "         b.sbcr_name sbcr_name,   " + 
     "         a.order_name  order_name,   " + 
     "         max(a.chg_degree) chg_degree,   " + 
     "         min(a.approve_class) approve_class , max(a.order_class) order_class " + 
     "    FROM s_chg_cn_list a,s_sbcr b" + 
     "        where  a.sbcr_code = b.sbcr_code and" + 
     "               a.dept_code = '" + arg_dept_code + "' " + 
     "GROUP BY a.dept_code,   " + 
     "         a.order_number,   " + 
     "         b.sbcr_name,   " + 
     "         a.order_name,   " + 
     "         a.const_no   " + 
     "order by a.const_no desc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>