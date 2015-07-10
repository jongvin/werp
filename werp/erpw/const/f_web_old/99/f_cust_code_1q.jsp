<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("key_cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("tmp_cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("representative_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("kind_businesstype",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("business_condition",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_number",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cust_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("main_bank",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("acc_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("trouble_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT decode(cust_type,'1',substrb(CUST_CODE,1,3) || '-' || substrb(cust_code,4,2) || '-' || substrb(cust_code,6,5),decode(cust_type,'2',substrb(cust_code,1,6) || '-' || substrb(cust_code,7,7),cust_code)) cust_code," + 
     				"             cust_code    key_cust_code, " +
     				"             cust_code    tmp_cust_code, " +
     				"             CUST_TYPE," + 
     				"             CUST_NAME," + 
     				"             REPRESENTATIVE_NAME," + 
     				"             KIND_BUSINESSTYPE," + 
     				"             BUSINESS_CONDITION," + 
     				"             TEL_NUMBER," + 
     				"             FAX_NUMBER," + 
     				"             ZIP_NUMBER," + 
     				"             ADDR," + 
     				"             CUST_CLASS," + 
     				"             MAIN_BANK," + 
     				"             ACC_NUMBER," + 
     				"             DEPOSITOR," + 
     				"             TROUBLE_TAG  " +
     				"        FROM Z_CODE_CUST_CODE " +
     				"       WHERE cust_name like '" + arg_sbcr_name + "'" +
     				"   ORDER BY CUST_CODE ASC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>