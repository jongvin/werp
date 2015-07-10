<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("line_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("creation_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("description",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("entered_dr",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("entered_cr",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("vendor_name",GauceDataColumn.TB_STRING,320));
     dSet.addDataColumn(new GauceDataColumn("department_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("folder_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("project_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("vat_custcode",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("vat_custname",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("invoice_date",GauceDataColumn.TB_STRING,240));
    String query = "select " + 
     "       a.line_seq," + 
     "       to_char(a.creation_date,'yyyy.mm.dd')  creation_date," + 
     "       a.description," + 
     "       a.entered_dr," + 
     "       a.entered_cr," + 
     "       a.account_name ," + 
     "       a.vendor_name," + 
     "       a.department_name," + 
     "       a.folder_name," + 
     "       a.project_name," + 
     "       a.invoice_num," + 
     "       DECODE(A.MODULE_NAME, 'AP', DECODE(A.ATTRIBUTE17, NULL, a.vat_registration_num, A.ATTRIBUTE17), a.vat_registration_num) vat_custcode," + 
     "       DECODE(A.MODULE_NAME, 'AP', DECODE(A.ATTRIBUTE18, NULL, a.vendor_name, A.ATTRIBUTE18), a.vendor_name) vat_custname," + 
     "       to_char(DECODE(A.MODULE_NAME, 'AP', a.invoice_date, a.attribute17),'yyyy.mm.dd') invoice_date" + 
     "   from  efin_invoices_all_v  a" + 
     "   where invoice_group_id = " + arg_group_id + "     " + 
     "    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>