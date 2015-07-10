<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("key_membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("company_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("membership_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cont_limit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("customer_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("customer_dsp",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("customer_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("corp_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("membership_name_long",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("membership_name_eng",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("category",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("condition",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("limitamt_all",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("limitamt_const",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("limitamt_arch",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_guarantee",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("emp_status",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("l_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("l_fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("l_zipcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("l_addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("licence_status",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,300));
    String query = "  SELECT MEMBERSHIP_NO," + 
     "             MEMBERSHIP_NO  KEY_MEMBERSHIP_NO," +
     "             COMPANY_TAG," + 
     "             MEMBERSHIP_NAME," + 
     "             CONT_LIMIT_AMT," + 
     "             CUSTOMER_TAG," + 
     "             decode(customer_tag,'1',substrb(CUSTOMER_NO,1,3) || '-' || substrb(customer_no,4,2) || '-' || substrb(customer_no,6,5),substrb(customer_no,1,6) || '-' || substrb(customer_no,7,7)) CUSTOMER_DSP," + 
     "             CUSTOMER_NO," + 
     "             CORP_NO," + 
     "             MEMBERSHIP_NAME_LONG," + 
     "             MEMBERSHIP_NAME_ENG," + 
     "             OWNER," + 
     "             CATEGORY," + 
     "             CONDITION," + 
     "             TEL," + 
     "              FAX," + 
     "             ZIP_CODE," + 
     "             ADDR," + 
     "             LIMITAMT_ALL," + 
     "             LIMITAMT_CONST," + 
     "             LIMITAMT_ARCH," + 
     "             POSITION," + 
     "             COMP_GUARANTEE," + 
     "             EMP_STATUS," + 
     "             L_TEL," + 
     "             L_FAX," + 
     "             L_ZIPCODE," + 
     "             L_ADDR," + 
     "             LICENCE_STATUS," + 
     "             REMARK        FROM R_CODE_MEMBERSHIP         " +
     "                         order by membership_no asc";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>