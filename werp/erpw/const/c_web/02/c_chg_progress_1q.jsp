<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,2,0));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,3,0));
	 dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,3,0));
	 dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1,0));
	 dSet.addDataColumn(new GauceDataColumn("chg_title",GauceDataColumn.TB_STRING,200,0));
	 dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1,0));
	 dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,10,0));
	 dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1000));
	 dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class_y",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("app_yn",GauceDataColumn.TB_STRING,1));
	 
    String query = " SELECT    c.dept_code,"   +
									"          c.chg_seq,"   +
									"          c.chg_no_seq,"   +
									"          c.chg_degree,"   +
									" 			c.chg_class,"   +
									" 			c.chg_title,"   +
									" 			c.approve_class,"   +
									" 			TO_CHAR (c.work_dt, 'yyyy.mm.dd') work_dt,"   +
									"          TO_CHAR (c.chg_const_start_date, 'yyyy.mm.dd') chg_const_start_date,"   +
									"          TO_CHAR (c.chg_const_end_date, 'yyyy.mm.dd')   chg_const_end_date,"   +
									" 			c.remark,"   +
									" 			y.cnt_amt,"   +
									" 			y.amt,"   +
									" 			y.approve_class approve_class_y,"   +
									" 			to_char(approve_dt, 'yyyy.mm.dd') approve_dt, "   +
									"           c.app_yn"+
									" FROM c_chg_progress c,"   +
									"  	        y_chg_degree y"   +
								"   WHERE c.dept_code = '"+arg_dept_code+"'"   +
									"	  and c.dept_code = y.dept_code(+)"   +
									"	  and c.chg_no_seq = y.chg_no_seq(+)"   +
									"	  and c.chg_degree = y.chg_degree(+)"   +
									" ORDER BY chg_seq DESC"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>