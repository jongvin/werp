<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_price",GauceDataColumn.TB_DECIMAL,15,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
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
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,300));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("outside_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("stand_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("stand_ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("stand_unit",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("div_rel_num",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     "          a.chg_no_seq ," + 
     "          a.spec_no_seq ," + 
     "          a.spec_unq_num ," + 
     "          a.no_seq ," + 
     "          a.detail_code ," + 
     "          a.res_class ," + 
     "          a.mat_code ," + 
     "          a.name ," + 
     "          a.ssize ," + 
     "          a.unit ," + 
     "          a.cnt_qty ," + 
     "          a.cnt_price," + 
     "          a.cnt_amt," + 
     "          a.cnt_mat_price ," + 
     "          a.cnt_mat_amt ," + 
     "          a.cnt_lab_price ," + 
     "          a.cnt_lab_amt ," + 
     "          a.cnt_exp_price ," + 
     "          a.cnt_exp_amt ," + 
     "          a.qty ," + 
     "          a.price ," + 
     "          a.amt ," + 
     "          a.mat_price ," + 
     "          a.mat_amt ," + 
     "          a.lab_price ," + 
     "          a.lab_amt ," + 
     "          a.exp_price ," + 
     "          a.exp_amt ," + 
     "          a.equ_price ," + 
     "          a.equ_amt ," + 
     "          a.sub_price ," + 
     "          a.sub_amt ," + 
     "          a.remark ," + 
     "          to_char(a.input_dt,'yyyy.mm.dd') input_dt ," + 
     "          a.input_name, " + 
     "          a.outside_yn, " + 
     "          a.name_key, " + 
     "          b.name stand_name, " + 
     "          b.ssize stand_ssize, " + 
     "          b.unit stand_unit, " + 
	 "          a.col_tag, "+
	 "          a.cat_text , a.div_rel_num"+
     "            FROM y_budget_detail a,  " + 
     "                  y_stand_detail b " + 
     "          WHERE ( a.dept_code = " + "'" + arg_dept_code + "'" + ")  " + 
     "             and ( a.chg_no_seq = " + arg_chg_no_seq + ")  " + 
     "             and          ( a.spec_no_seq = " + arg_spec_no_seq + ") " + 
     "             and  ( a.detail_code = b.detail_code (+) ) " + 
     "             ORDER BY a.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>