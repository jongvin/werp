<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String as_dept_code    = req.getParameter("as_dept_code");
	 String as_sell_code    = req.getParameter("as_sell_code");
      String as_deposit_no = req.getParameter("as_deposit_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("v_account_no",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("v_account_no_key",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("reg_date",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("col1",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("col2",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("col3",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("col4",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("col5",GauceDataColumn.TB_STRING,50));
    
    String query = "  SELECT dept_code, 						"+
	                           "                    sell_code, 							 "+
										"						  deposit_no, 								  "+
                              "                    v_account_no, 						  "+
										"                    v_account_no v_account_no_key, 						  "+
										"						  to_char(reg_date, 'yyyy.mm.dd') reg_date, 												"+
										"						  use_tag, 														 "+
										"							dongho, 															 "+
										"							seq, 																			  "+
										"							to_char(apply_date, 'yyyy.mm.dd') apply_date, 														  "+
										"						col1, 																						"+
										"						col2, 																							 "+
										"						col3, 																								  "+
										"						col4, 																										"+
										"						col5																												 "+
										"		from h_code_v_account													 "+
     "                 WHERE  dept_code like"+"'"+ as_dept_code +"'"+ 
	  "                   and sell_code like"+"'"+ as_sell_code +"'"+ 
     "                   and deposit_no like " + "'" + as_deposit_no  +"'"+ 
	  "                 order by dept_code, sell_code, deposit_no, v_account_no";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>