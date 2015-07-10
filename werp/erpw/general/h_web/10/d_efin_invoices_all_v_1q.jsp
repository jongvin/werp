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
	  dSet.addDataColumn(new GauceDataColumn("acc_date",GauceDataColumn.TB_STRING,10));
    String query = "select " + 
     "       a.line_seq," + 
     "       to_char(a.creation_date,'yyyy.mm.dd')  creation_date," + 
     "       a.description," + 
     "       a.entered_dr," + 
     "       a.entered_cr," + 
     "       a.account_name ," + 
     "       a.vendor_name," + 
     "       a.department_name," + 
	  "       replace(a.attribute17,'-','.') acc_date "+
     "   from  efin_invoices_all_v  a" + 
     "   where invoice_group_id = " + arg_group_id + "     " + 
     "   order by a.attribute17, a.line_seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>