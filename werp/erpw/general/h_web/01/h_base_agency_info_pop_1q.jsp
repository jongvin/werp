<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_reg_no = req.getParameter("arg_reg_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("reg_no",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("reg_no_org",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("biz_cat",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("biz_itm",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("main_tag",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("app_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("rep_name",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("rep_no",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("rep_cell",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("rep_email",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("comp_phone",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("comp_fax",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("co_op_rate",GauceDataColumn.TB_DECIMAL,5,2));
	 dSet.addDataColumn(new GauceDataColumn("comp_zipcode",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("comp_addr1",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("comp_addr2",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("attrib1",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("attrib2",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("attrib3",GauceDataColumn.TB_STRING,255));
    String query ="   SELECT dept_code, "   +
								" 			 sell_code, "   +
								" 			 reg_no, "   +
								" 			 reg_no reg_no_org, "   +
								" 			 comp_name, "   +
								" 			 biz_cat, "   +
								" 			 biz_itm, "   +
								" 			 main_tag,"   +
								"			 to_char(app_date, 'yyyy.mm.dd') app_date, "   +
								" 			 to_char(end_date, 'yyyy.mm.dd') end_date, "   +
								" 			 rep_name, "   +
								" 			 rep_no, "   +
								" 			 rep_cell, "   +
								" 			 rep_email, "   +
								" 			 comp_phone,"   +
								"            comp_fax, "   +
								" 			 co_op_rate, "   +
								" 			 comp_zipcode, "   +
								" 			 comp_addr1, "   +
								" 			 comp_addr2, "   +
								" 			 attrib1,"   +
								"            attrib2, "   +
								" 			 attrib3"   +
								"   FROM h_agency_info" +
								"  where dept_code = '"+arg_dept_code+"'"+
								"     and sell_code = '"+arg_sell_code+"'"+
								"     and reg_no = '"+arg_reg_no+"'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>