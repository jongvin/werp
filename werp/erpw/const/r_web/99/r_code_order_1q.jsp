<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("key_order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("customer_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("customer_dsp",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("customer_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("corp_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_name_long",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_name_eng",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("category",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("condition",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT ORDER_NO," + 
     "             ORDER_NO key_order_no, " +
     "             CUSTOMER_TAG," + 
     "             ORDER_NAME," + 
     "             decode(customer_tag,'1',substrb(CUSTOMER_NO,1,3) || '-' || substrb(customer_no,4,2) || '-' || substrb(customer_no,6,5),substrb(customer_no,1,6) || '-' || substrb(customer_no,7,7)) CUSTOMER_DSP," + 
     "             CUSTOMER_NO," + 
     "             CORP_NO," + 
     "             ORDER_NAME_LONG," + 
     "             ORDER_NAME_ENG," + 
     "             OWNER," + 
     "             CATEGORY," + 
     "             CONDITION," + 
     "             ORDER_CLASS," + 
     "             TEL," + 
     "             FAX," + 
     "             ZIP_CODE," + 
     "             ADDR1," + 
     "             ADDR2," + 
     "             REMARK        FROM R_CODE_ORDER         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>