<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("inout_tel",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("br_date",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT a.dept_code dept_code,   " + 
     "         a.order_number order_number,   " + 
     "         a.sbcr_code sbcr_code,   " + 
     "         b.inout_tel ," + 
     "         to_char(c.br_date,'yyyy.mm.dd hh24:mi') br_date " +
     "    FROM s_estimate_list  a," + 
     "         s_wbs_request b," + 
     "         s_order_list c " +
     "   WHERE ( a.sbcr_code           = b.sbcr_code ) AND" + 
     "         ( a.profession_wbs_code = b.profession_wbs_code ) and " +
     "         ( a.dept_code = c.dept_code ) and " +
     "         ( a.order_number = c.order_number ) and " +
     "         ( a.dept_code = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( a.order_number = " + arg_order_number + " )   " + 
     " ORDER BY dept_code ASC,   " + 
     "         order_number ASC,   " + 
     "         sbcr_code ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>