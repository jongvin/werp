<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sum_code = req.getParameter("arg_sum_code");
     String arg_ea = req.getParameter("arg_ea");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "    SELECT   " + 
     "              sum(nvl(y_budget_parent.cnt_amt,0)) / " + arg_ea + " cnt_amt,    " + 
     "              sum(nvl(y_budget_parent.amt,0)) / " + arg_ea + " amt     " + 
     "          FROM y_budget_parent, c_spec_class_parent , c_spec_class_child , z_code_dept z   " + 
     "         WHERE ( c_spec_class_parent.sum_code like '" + arg_sum_code + "%' )  and  " +    
     "			      ( c_spec_class_parent.spec_no_seq = c_spec_class_child.spec_no_seq ) and " + 
     "               (c_spec_class_child.dept_code = z.dept_code)   and " + 
     "               (c_spec_class_child.dept_code = y_budget_parent.dept_code  and  " + 
     "                  y_budget_parent.llevel = '1')  and " + 
     "               ( z.chg_const_start_date is not null ) and   " + 
     "               ( to_char(z.chg_const_start_date,'YYYY') <= '" + arg_year + "') and " +      
     "               ( to_char(z.chg_const_end_date,'YYYY') >= '" + arg_year + "') " ;       
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>