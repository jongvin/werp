<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");  
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cont_num",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("lease_s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("lease_e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("grt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rent_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("office_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,50));
    String query = "select m.cont_num," + 
     "       m.cust_code," + 
     "		 c.cust_name," + 
     "		 to_char(m.cont_date,'yyyy.mm.dd') cont_date," + 
     "		 cm.code_name," + 
     "		 cd.DONGHO," + 
     "		 to_char(ld.LEASE_S_DATE,'yyyy.mm.dd') lease_s_date," + 
     "		 to_char(ld.LEASE_E_DATE,'yyyy.mm.dd') lease_e_date," + 
     "		 ld.GRT_AMT," + 
     "		 to_char(rd.apply_date,'yyyy.mm') apply_date," + 
     "		 rd.rent_amt," + 
     "		 rd.rent_vat," + 
     "		 c.home_phone," + 
     "		 c.office_phone," + 
     "		 c.cell_phone," + 
     "		 c.cur_zip_code," + 
     "		 c.cur_addr1," + 
     "		 c.cur_addr2 " + 
     "  from h_lease_master m," + 
     "       h_code_cust c," + 
     "		 h_lease_detail ld," + 
     "		 h_lease_rent_detail rd," + 
     "		 h_lease_cont_dongho cd," + 
     "		 h_code_common cm" + 
     " where m.cust_code = c.cust_code(+)" + 
     "   and m.dept_code = ld.dept_code(+)" + 
     "	and m.sell_code = ld.sell_code(+)" + 
     "	and m.cont_date = ld.cont_date(+)" + 
     "	and m.cont_seq  = ld.cont_seq(+)" + 
     "	and m.lease_chg_seq = ld.chg_seq(+)" + 
     "	and m.dept_code = rd.dept_code(+)" + 
     "	and m.sell_code = rd.sell_code(+)" + 
     "	and m.cont_date = rd.cont_date(+)" + 
     "	and m.cont_seq  = rd.cont_seq(+)" + 
     "	and m.rent_chg_seq = rd.chg_seq(+)" + 
     "	and m.dept_code = cd.dept_code(+)" + 
     "	and m.sell_code = cd.sell_code(+)" + 
     "	and m.cont_date = cd.cont_date(+)" + 
     "	and m.cont_seq  = cd.cont_seq(+)" + 
     "	and m.dept_code = '"+arg_dept_code+"'"+ 
     "	and m.sell_code = '"+arg_sell_code+ "'"+
     "	and m.cont_type = cm.code(+)" + 
     "	and cm.code_div = '34' " +
	  "   and m.exp_tag <> 'Y' "+
     "	order by m.cont_num";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>