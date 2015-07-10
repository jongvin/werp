<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("tmp_businessman_number",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("reg_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("corp_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("chargename",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ownerid",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("civil_number_error_check",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mail_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mail_address",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("zip",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("capital",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sellingamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("debtamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("items",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("dealingitem",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("isomemo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("plantmemo",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("remarks",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("orderresult",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("giyeodo",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT sbcr_code," + 
     "             sbcr_name," + 
     "             substrb(businessman_number,1,3) || '-' || substrb(businessman_number,4,2) || '-' || substrb(businessman_number,6,5) businessman_number," + 
     "             businessman_number  tmp_businessman_number," + 
     "             ADDR," + 
     "             REG_NO," + 
     "             CORP_NO," + 
     "             CHARGENAME," + 
     "             OWNER," + 
     "             OWNERID," + 
     "             'N' civil_number_error_check, " +
     "             MAIL_NAME," + 
     "             MAIL_ADDRESS," + 
     "             ZIP," + 
     "             TEL," + 
     "             FAX," + 
     "             NVL(CAPITAL,0) CAPITAL," + 
     "             NVL(SELLINGAMT,0) SELLINGAMT," + 
     "             NVL(DEBTAMT,0) DEBTAMT, " + 
     "             ITEMS," + 
     "             DEALINGITEM," + 
     "             ISOMEMO," + 
     "             PLANTMEMO," + 
     "             REMARKS," + 
     "             NVL(ORDERRESULT,0) ORDERRESULT," + 
     "             GIYEODO        FROM s_sbcr         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>