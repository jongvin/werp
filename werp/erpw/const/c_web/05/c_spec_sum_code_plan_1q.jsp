<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_plan_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_plan_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("ls_plan_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("c_yymm",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chk_dept",GauceDataColumn.TB_STRING,7));
    String query = "SELECT b.dept_code,    " + 
     "              to_char(b.yymm,'yyyy.mm.dd') yymm,    " + 
     "              NVL(b.spec_no_seq,0) spec_no_seq,    " + 
     "              NVL(b.cnt_plan_amt,0) cnt_plan_amt,    " + 
     "              NVL(b.plan_amt,0) plan_amt,    " + 
     "              NVL(b.ls_cnt_plan_amt,0) ls_cnt_plan_amt,    " + 
     "              NVL(b.ls_plan_amt,0) ls_plan_amt,    " + 
     "              to_char(a.c_yymm,'yyyy.mm') c_yymm,    " + 
     "              nvl(b.dept_code,'INSERT') chk_dept   " + 
     "         FROM ( select yymm,spec_no_seq,cnt_plan_amt,plan_amt,ls_cnt_plan_amt,ls_plan_amt,dept_code" + 
     "                      from  c_spec_sum_code_plan" + 
     "                         where  c_spec_sum_code_plan.dept_code = '" + arg_dept_code + "' and  " + 
     "                                 c_spec_sum_code_plan.spec_no_seq =  " + arg_spec_no_seq+ ") b,c_calendar_yymm a" + 
     "         where ( b.yymm (+) = a.c_yymm) and     " + 
     "              ( (a.c_yymm >= '" + arg_start_date + "' OR " + 
     "                 a.c_yymm >=  (select min(to_char(c_spec_sum_code_plan.yymm,'yyyy.mm.dd')) from  c_spec_sum_code_plan " + 
     "                                               where  c_spec_sum_code_plan.dept_code = '" + arg_dept_code + "' and  " + 
     "                                                      c_spec_sum_code_plan.spec_no_seq =  " + arg_spec_no_seq+ ")) " + 
     "                  and (a.c_yymm <= '" + arg_end_date + "'  OR " + 
     "                       a.c_yymm <= (select max(to_char(c_spec_sum_code_plan.yymm,'yyyy.mm.dd')) from  c_spec_sum_code_plan " + 
     "                         where  c_spec_sum_code_plan.dept_code = '" + arg_dept_code + "' and  " + 
     "                                 c_spec_sum_code_plan.spec_no_seq =  " + arg_spec_no_seq + ") ) )      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>