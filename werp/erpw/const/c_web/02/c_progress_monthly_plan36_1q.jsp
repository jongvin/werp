<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_seq = req.getParameter("arg_chg_seq");
	 String arg_cat_text = req.getParameter("arg_cat_text");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,2,0));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,3,0));
	 dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("plan_tot_qty",GauceDataColumn.TB_DECIMAL,12,2));
	 dSet.addDataColumn(new GauceDataColumn("plan_tot_amt",GauceDataColumn.TB_DECIMAL,14,0));
	 dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,13,3));
	 dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,17,3));
	 dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));

	dSet.addDataColumn(new GauceDataColumn("q1",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q2",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q3",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q4",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q5",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q6",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q7",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q8",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q9",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q10",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q11",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q12",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q13",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q14",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q15",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q16",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q17",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q18",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q19",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q20",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q21",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q22",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q23",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q24",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q25",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q26",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q27",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q28",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q29",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q30",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q31",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q32",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q33",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q34",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q35",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q36",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q37",GauceDataColumn.TB_DECIMAL,14,3));
	dSet.addDataColumn(new GauceDataColumn("q38",GauceDataColumn.TB_DECIMAL,14,3));
	
	dSet.addDataColumn(new GauceDataColumn("a1",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a2",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a3",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a4",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a5",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a6",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a7",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a8",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a9",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a10",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a11",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a12",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a13",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a14",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a15",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a16",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a17",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a18",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a19",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a20",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a21",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a22",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a23",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a24",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a25",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a26",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a27",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a28",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a29",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a30",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a31",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a32",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a33",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a34",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a35",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a36",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a37",GauceDataColumn.TB_DECIMAL,13,0));
	dSet.addDataColumn(new GauceDataColumn("a38",GauceDataColumn.TB_DECIMAL,13,0));
	

    String query = " select cp.dept_code,"   +
"			 cp.chg_seq,"   +
" 			 cp.chg_no_seq,"   +
" 			 cp.spec_no_seq,"   +
" 			 cp.spec_unq_num,"   +
" 			 cp.plan_tot_qty,"   +
" 			 cp.plan_tot_amt,"   +
" 			 bd.col_tag,"   +
" 			 bd.cat_text,"   +
" 			 bd.NAME,"   +
" 			 bd.SSIZE,"   +
" 			 bd.UNIT,"   +
" 			 bd.qty,"   +
" 			 bd.price,"   +
" 			 bd.amt,"   +
		" 0 q1,"   +
		" 0 q2,"   +
		" 0 q3,"   +
		" 0 q4,"   +
		" 0 q5,"   +
		" 0 q6,"   +
		" 0 q7,"   +
		" 0 q8,"   +
		" 0 q9,"   +
		" 0 q10,"   +
		" 0 q11,"   +
		" 0 q12,"   +
		" 0 q13,"   +
		" 0 q14,"   +
		" 0 q15,"   +
		" 0 q16,"   +
		" 0 q17,"   +
		" 0 q18,"   +
		" 0 q19,"   +
		" 0 q20,"   +
		" 0 q21,"   +
		" 0 q22,"   +
		" 0 q23,"   +
		" 0 q24,"   +
		" 0 q25,"   +
		" 0 q26,"   +
		" 0 q27,"   +
		" 0 q28,"   +
		" 0 q29,"   +
		" 0 q30,"   +
		" 0 q31,"   +
		" 0 q32,"   +
		" 0 q33,"   +
		" 0 q34,"   +
		" 0 q35,"   +
		" 0 q36,"   +
		" 0 q37,"   +
		" 0 q38,"   +
		" 0 a1,"   +
		" 0 a2,"   +
		" 0 a3,"   +
		" 0 a4,"   +
		" 0 a5,"   +
		" 0 a6,"   +
		" 0 a7,"   +
		" 0 a8,"   +
		" 0 a9,"   +
		" 0 a10,"   +
		" 0 a11,"   +
		" 0 a12,"   +
		" 0 a13,"   +
		" 0 a14,"   +
		" 0 a15,"   +
		" 0 a16,"   +
		" 0 a17,"   +
		" 0 a18,"   +
		" 0 a19,"   +
		" 0 a20,"   +
		" 0 a21,"   +
		" 0 a22,"   +
		" 0 a23,"   +
		" 0 a24,"   +
		" 0 a25,"   +
		" 0 a26,"   +
		" 0 a27,"   +
		" 0 a28,"   +
		" 0 a29,"   +
		" 0 a30,"   +
		" 0 a31,"   +
		" 0 a32,"   +
		" 0 a33,"   +
		" 0 a34,"   +
		" 0 a35,"   +
		" 0 a36,"   +
		" 0 a37,"   +
		" 0 a38"   +
"   from c_progress_parent cp,"   +
" 	     y_chg_budget_detail bd"   +
"  where cp.dept_code 		= bd.dept_code"   +
" 		and cp.chg_no_seq    = bd.chg_no_seq"   +
" 		and cp.spec_no_seq   = bd.spec_no_seq"   +
" 		and cp.spec_unq_num  = bd.spec_unq_num"   +
" 		and cp.dept_code = '"+arg_dept_code+"'"   +
" 		and cp.chg_seq   = '"+arg_chg_seq +"'"   +
" 		and nvl(bd.cat_text,'....')  like decode('"+arg_cat_text+"', 'ALL', '%', '"+arg_cat_text+"')"  +
" order by cp.spec_unq_num" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>