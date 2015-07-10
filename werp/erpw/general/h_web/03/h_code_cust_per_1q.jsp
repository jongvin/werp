<%@ page session="true"  contentType="text/html; charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_cust_code = req.getParameter("arg_cust_code");
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
     dSet.addDataColumn(new GauceDataColumn("match_jumin_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("match_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("match_phone",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("sms_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("cust_div2",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("comp_no",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT cust_code ," + 
     "                       cust_name ," + 
     "                       cust_div ," + 
     "                       represent ," + 
     "                       biz_status ," + 
     "                       biz_type ," + 
     "                       home_phone ," + 
     "                       office_phone ," + 
     "                       cell_phone ," + 
     "                       e_mail ," + 
     "                       dm_demand ," + 
     "                       cur_zip_code ," + 
     "                       cur_addr1 ," + 
     "                       cur_addr2 ," + 
     "                       receipt_name ," + 
     "                       receipt_phone ," + 
     "                       receipt_zip_code ," + 
     "                       receipt_addr1 ," + 
     "                       receipt_addr2, " + 
     "                       match_jumin_no, " + 
     "                       match_name, " + 
     "                       match_phone,  " + 
	  "                       sms_yn,  " +
	 "                        cust_div2, comp_no "+
     "                  FROM h_code_cust  "  +
     "                 where cust_code = " + "'" + arg_cust_code + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>