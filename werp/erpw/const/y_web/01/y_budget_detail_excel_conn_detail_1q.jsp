<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_part_class = req.getParameter("arg_part_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,20));

     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     //dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,3));
     //dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,13,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,13,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_price",GauceDataColumn.TB_DECIMAL,13,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_price",GauceDataColumn.TB_DECIMAL,13,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_price",GauceDataColumn.TB_DECIMAL,13,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,13,0));

     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,300));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("part_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("length_name",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("length_ssize",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("length_unit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("b_detail_code",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.no_seq," + 
     "          a.detail_code," + 
     "             a.name," + 
     "             a.ssize," + 
     "             a.unit," + 
	 "             a.cnt_qty,"+
	 "             a.cnt_price,"+
	 "             a.cnt_amt,"+
	 "             a.cnt_mat_price,"+
	 "             a.cnt_mat_amt,"+
	 "             a.cnt_lab_price,"+
	 "             a.cnt_lab_amt,"+
	 "             a.cnt_exp_price,"+
	 "             a.cnt_exp_amt,"+
     "             a.qty," + 
     "             a.price," + 
     "             a.amt," + 
     "             a.mat_price," + 
     "             a.mat_amt," + 
     "             a.lab_price," + 
     "             a.lab_amt," + 
     "             a.sub_price," + 
     "             a.sub_amt," + 
     "             a.exp_price," + 
     "             a.exp_amt," + 
     "             a.remark," + 
     "             a.mat_code," + 
     "             a.res_class," + 
     "             a.dept_code," + 
     "             a.part_class," + 
     "             a.name_key, " + 
     "          lengthb(a.name) length_name,   " + 
     "          lengthb(a.ssize) length_ssize,  " + 
     "          lengthb(a.unit) length_unit,   " + 
     "             b.mat_code b_mat_code, " + 
     "             b.detail_code b_detail_code " + 
     "        FROM y_budget_detail_excel_temp a, " + 
     "           (select a.detail_code,a.mat_code,a.name_key " + 
     "                from (  " + 
     "                         select a.detail_code,a.mat_code,upper(a.name_key) name_key, " + 
     "                                 RANK() OVER (PARTITION BY upper(a.name_key) " + 
     "                                             ORDER BY a.name_key asc ) rk_1 " + 
     "                         from y_stand_detail a ) a " +
     "                where a.rk_1 = 1 ) b " + 
     "        WHERE  a.dept_code = '" + arg_dept_code +  "'         " + 
     "         and   a.part_class  = '" + arg_part_class + "'   " + 
     "         and   upper(a.name_key)  = upper(b.name_key (+)) " + 
     "        ORDER by a.no_seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>