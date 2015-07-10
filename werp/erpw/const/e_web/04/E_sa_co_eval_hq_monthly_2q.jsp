<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,5));
	 dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ex_point",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_class_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));

 String query = " select														" +
				"	  a.dept_code ,												" +
				"	  a.order_number ,											" +
				"	  to_char(a.yymm,'yyyymm') yymm,							" +
				"	  a.profession_wbs_code ,									" +
				"	  a.sbcr_code ,												" +
				"	  a.sbc_name ,												" +
				"	  a.sbcr_name ,												" +
				"	  to_char(a.start_date,'yyyymmdd') start_date ,				" +
				"	  a.end_date ,												" +
				"	  ( select													" + 
				"			sum(a1.or_point *									" +
				"			decode ( a1.select_type , 'F' , 0 , 'T' , 1 ) )		" +
				"		from													" +
				"			e_comp_opinion_detail a1							" + 
				"		where													" +
				" 			a.dept_code = a1.dept_code and						" +
				"			a.yymm = a1.yymm and								" +
				"			a.order_number =a1.order_number						" +
				"			) ex_point,											" +
				"	  a.approve_class ,											" +
				"	  a.approve_class as approve_class_chk,						" +
				"	  a.remark													" +
				" from															" +	
				" 	  e_comp_opinion a											" +
				" where															" +
				" 	  a.dept_code = '" + arg_dept_code + "' and					" +
				"	  a.sbcr_code = '" + arg_sbcr_code + "' and					" +
				"	  a.order_number = '" + arg_order_number + "' and			" +
				"     to_char(a.yymm,'yyyymmdd') like '" + arg_yymm + "%' and	" +
				"     a.approve_class > '1'										" +	
				" order by														" +
 				"     a.yymm desc												" ;	

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>