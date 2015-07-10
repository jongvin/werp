<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,300));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("division",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  y_budget_parent.dept_code ," + 
     "          y_budget_parent.chg_no_seq ," + 
     "          y_budget_parent.spec_no_seq ," + 
     "          y_budget_parent.no_seq ," + 
     "          y_budget_parent.sum_code ," + 
     "          y_budget_parent.parent_sum_code ," + 
     "          y_budget_parent.direct_class ," + 
     "          y_budget_parent.wbs_code ," + 
     "          y_budget_parent.llevel ," + 
     "          y_budget_parent.name ," + 
     "          y_budget_parent.ssize ," + 
     "          y_budget_parent.unit ," + 
     "          y_budget_parent.remark ," + 
     "          to_char(y_budget_parent.input_dt,'yyyy.mm.dd') input_dt ," + 
     "          y_budget_parent.input_name, " + 
     "          y_wbs_code.name wbs_name,  " + 
     "          y_budget_parent.invest_class invest_class,  " + 
     "          y_budget_parent.division,  " + 
     "          (select count(y_budget_detail.dept_code)  " + 
     "                 from y_budget_detail  " + 
     "                 where y_budget_detail.dept_code = " + "'" + arg_dept_code + "' "  + 
     "                  and  y_budget_detail.chg_no_seq = " + arg_chg_no_seq + "  " + 
     "                  AND  y_budget_parent.spec_no_seq = y_budget_detail.spec_no_seq " + 
     "                  AND  y_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + "  " + 
     "                  and  y_budget_parent.chg_no_seq = " + arg_chg_no_seq + "  " + 
     "                  and  y_budget_parent.invest_class = 'Y') cnt " + 
     "    FROM y_budget_parent ,y_wbs_code  " + 
     "    WHERE ( y_budget_parent.wbs_code = y_wbs_code.wbs_code (+))  and  " +  
     "        ( y_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + ") and  " + 
     "        ( y_budget_parent.chg_no_seq = " + arg_chg_no_seq + ")  " + 
     "         ORDER BY y_budget_parent.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>