<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("check_type",GauceDataColumn.TB_DECIMAL,1));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,19));
    String query = "select z_code_dept.long_name," + 
     "       s_order_list.order_name, " + 
     "       A.dept_code, " + 
     "       A.order_number," + 
     "       A.seq, " + 
     "       A.llevel, " + 
     "       substr('           ',1,(a.llevel-1) *2) || a.name name, " + 
     "       A.ssize," + 
     "       A.unit," + 
     "       A.sub_qty," + 
     "       A.check_type ," + 
     "       sysdate " +
     "       from " + 
     "         ( SELECT  s_order_parent.dept_code," + 
     "                   s_order_parent.order_number,   " + 
     "                   s_order_parent.seq * 1000000  seq," + 
     "                   to_number(s_order_parent.llevel) llevel, " + 
     "                   s_order_parent.name," + 
     "                   s_order_parent.ssize," + 
     "                   s_order_parent.unit," + 
     "                   1 sub_qty," + 
     "                   1 check_type " + 
     "             FROM s_order_parent   " + 
     "             WHERE (s_order_parent.dept_code = '" + arg_dept_code + "' and  " + 
     "                    s_order_parent.order_number =  " + arg_order_number + ")" + 
     "          union all" + 
     "           SELECT  s_order_detail.dept_code," + 
     "                   s_order_detail.order_number,  " + 
     "                   s_order_parent.seq  * 1000000 + s_order_detail.seq seq,  " + 
     "                   to_number(s_order_parent.llevel) + 1 llevel,  " + 
     "                   s_order_detail.name," + 
     "                   s_order_detail.ssize," + 
     "                   s_order_detail.unit," + 
     "                   s_order_detail.sub_qty," + 
     "                   2 check_type" + 
     "           FROM s_order_detail,   " + 
     "               s_order_parent  " + 
     "           WHERE ( s_order_parent.dept_code = s_order_detail.dept_code ) and " + 
     "                 ( s_order_parent.order_number = s_order_detail.order_number ) and " + 
     "                 ( s_order_parent.spec_no_seq = s_order_detail.spec_no_seq ) and " + 
     "                 ( ( s_order_detail.dept_code =  '" + arg_dept_code + "') and " + 
     "                   ( s_order_detail.order_number =  " + arg_order_number + ") " + 
     "                  )  ) A, " + 
     "       z_code_dept," + 
     "       s_order_list" + 
     "         where ( z_code_dept.dept_code = A.dept_code) and" + 
     "               ( s_order_list.dept_code = A.dept_code) and" + 
     "               ( s_order_list.order_number =  A.order_number) " + 
     "  order by a.seq      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>