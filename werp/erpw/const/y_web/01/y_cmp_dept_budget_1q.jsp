<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_division = req.getParameter("arg_division");
     String arg_detail_code = req.getParameter("arg_detail_code");
     String arg_dept_detail = req.getParameter("arg_dept_detail");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
    String query = "select a.dept_code," + 
     "       b.long_name, " + 
     "       a.bud_price, " + 
     "       a.name, " + 
     "       a.ssize," + 
     "       a.unit " + 
     "       from (                   " + 
     "         select b.dept_code," + 
     "                b.price bud_price, " + 
     "                b.name, " + 
     "                b.ssize, " + 
     "                b.unit " + 
     "            from y_chg_budget_parent a," + 
     "                 y_chg_budget_detail b" + 
     "            where a.dept_code = b.dept_code" + 
     "              and a.chg_no_seq = b.chg_no_seq" + 
     "              and a.spec_no_seq = b.spec_no_seq" + 
     "              and a.division = '" + arg_division + "' " + 
     "              and b.detail_code = '" + arg_detail_code + "'" + 
     "              and b.qty <> 0 " + 
     "              and ( " + arg_dept_detail + " " +   
     "                   )" + 
     "                             ) a," + 
     "           z_code_dept b," + 
     "           y_cmp_dept_code c" + 
     "        where a.dept_code = b.dept_code" + 
     "          and a.dept_code = c.cmp_dept_code " + 
     "          and c.dept_code = '" + arg_dept_code + "' " + 
     "    order by a.name,a.ssize,a.unit,b.long_name             " + 
     "   " + 
     "                                    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>