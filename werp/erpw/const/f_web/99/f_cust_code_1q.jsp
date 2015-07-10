<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
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
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("acc_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("trouble_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT decode(a.cust_type,'1',substrb(a.CUST_CODE,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5),decode(a.cust_type,'2',substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),a.cust_code)) cust_code," + 
     "             a.cust_code    key_cust_code, " +
     "             a.cust_code    tmp_cust_code, " +
     "             a.CUST_TYPE," + 
     "             a.CUST_NAME," + 
     "             a.REPRESENTATIVE_NAME," + 
     "             a.KIND_BUSINESSTYPE," + 
     "             a.BUSINESS_CONDITION," + 
     "             a.TEL_NUMBER," + 
     "             a.FAX_NUMBER," + 
     "             a.ZIP_NUMBER," + 
     "             a.ADDR," + 
     "             a.CUST_CLASS," + 
     "             a.MAIN_BANK," + 
     "             b.bank_main_name bank_name," + 
     "             a.ACC_NUMBER," + 
     "             a.DEPOSITOR," + 
     "             a.TROUBLE_TAG " + 
     "        FROM Z_CODE_CUST_CODE a, " +
     "             t_bank_main      b  " + 
     "       where a.main_bank = b.bank_main_code(+) " + 
     "   ORDER BY a.CUST_CODE ASC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>