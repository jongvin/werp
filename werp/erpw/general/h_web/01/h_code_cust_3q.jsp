<%@ page session="true"  contentType="text/html; charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_cust_name_1 = req.getParameter("arg_cust_name_1");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("represent",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("office_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dm_demand",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("receipt_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("receipt_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("receipt_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("match_jumin_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("match_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("match_phone",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("sms_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("cust_div2",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("comp_no",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("temp",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  h_code_cust.cust_code ," + 
     "          h_code_cust.cust_name ," + 
     "          h_code_cust.cust_div ," + 
     "          h_code_cust.represent ," + 
     "          h_code_cust.biz_status ," + 
     "          h_code_cust.biz_type ," + 
     "          h_code_cust.home_phone ," + 
     "          h_code_cust.office_phone ," + 
     "          h_code_cust.cell_phone ," + 
     "          h_code_cust.e_mail ," + 
     "          h_code_cust.dm_demand ," + 
     "          h_code_cust.cur_zip_code ," + 
     "          h_code_cust.cur_addr1 ," + 
     "          h_code_cust.cur_addr2 ," + 
     "          h_code_cust.receipt_name ," + 
     "          h_code_cust.receipt_phone ," + 
     "          h_code_cust.receipt_zip_code ," + 
     "          h_code_cust.receipt_addr1 ," + 
     "          h_code_cust.receipt_addr2, " + 
     "          h_code_cust.match_jumin_no, " + 
     "          h_code_cust.match_name, " + 
     "          h_code_cust.match_phone,  " + 
	 "          h_code_cust.sms_yn,  " + 
	 	 "           h_code_cust.cust_div2, "+
	 "          h_code_cust.comp_no, "+
	 "          h_code_cust.temp "+
     "        FROM h_code_cust  "  + 
     "       WHERE ( h_code_cust.cust_name like  '" + arg_cust_name_1 + "%' )    " + 
     "       order by h_code_cust.cust_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>