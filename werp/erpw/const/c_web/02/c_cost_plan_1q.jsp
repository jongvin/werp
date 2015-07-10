<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymm_disp",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dummy_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  c_cost_plan.dept_code ," + 
     "          c_cost_plan.chg_no_seq,  " + 
     "          to_char(c_cost_plan.yymm,'yyyy.mm') yymm_disp ," + 
     "          to_char(c_cost_plan.yymm,'yyyy.mm.dd') yymm ," + 
     "          c_cost_plan.amt ," + 
     "          c_cost_plan.cost_amt,  " + 
     "          c_cost_plan.cnt_amt,  " + 
     "          0 dummy_amt  " + 
     "       FROM c_cost_plan " + 
     "      WHERE ( c_cost_plan.dept_code = '" + arg_dept_code + "' ) " + 
     "        and ( c_cost_plan.chg_no_seq = " + arg_chg_no_seq + " ) " + 
     "      ORDER BY c_cost_plan.yymm          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>