<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  " + 
     "          " + 
     "          " + 
     "          " + 
     "          y_chg_budget_detail.no_seq ," + 
     "          y_chg_budget_detail.name ," + 
     "          y_chg_budget_detail.ssize ," + 
     "          y_chg_budget_detail.unit ," + 
     "          y_chg_budget_detail.cnt_qty ," + 
     "          y_chg_budget_detail.cnt_price," + 
     "          y_chg_budget_detail.cnt_amt," + 
     "          y_chg_budget_detail.qty ," + 
     "          y_chg_budget_detail.price ," + 
     "          y_chg_budget_detail.amt ," + 
     "          y_chg_budget_detail.cnt_mat_price ," + 
     "          y_chg_budget_detail.cnt_mat_amt ," + 
     "          y_chg_budget_detail.cnt_lab_price ," + 
     "          y_chg_budget_detail.cnt_lab_amt ," + 
     "          y_chg_budget_detail.cnt_exp_price ," + 
     "          y_chg_budget_detail.cnt_exp_amt ," + 
     "          y_chg_budget_detail.mat_price ," + 
     "          y_chg_budget_detail.mat_amt ," + 
     "          y_chg_budget_detail.lab_price ," + 
     "          y_chg_budget_detail.lab_amt ," + 
     "          y_chg_budget_detail.exp_price ," + 
     "          y_chg_budget_detail.exp_amt ," + 
     "          y_chg_budget_detail.equ_price ," + 
     "          y_chg_budget_detail.equ_amt ," + 
     "          y_chg_budget_detail.sub_price ," + 
     "          y_chg_budget_detail.sub_amt ," + 
     "          y_chg_budget_detail.mat_code ," + 
     "          y_chg_budget_detail.detail_code ," + 
     "          y_chg_budget_detail.res_class, " + 
     "          y_chg_budget_detail.name_key, " + 
     "          y_chg_budget_detail.spec_no_seq " + 
     "            FROM y_chg_budget_detail   " + 
     "          WHERE ( y_chg_budget_detail.dept_code = " + "'" + arg_dept_code + "'" + ")  " + 
     "             and ( y_chg_budget_detail.chg_no_seq = " + arg_chg_no_seq + ")  " + 
     "             and          ( y_chg_budget_detail.spec_no_seq = " + arg_spec_no_seq + ") " + 
     "             ORDER BY y_chg_budget_detail.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>