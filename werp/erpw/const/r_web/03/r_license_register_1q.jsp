<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
     String arg_kind = req.getParameter("arg_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("license_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cont_limit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eng_limit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_limit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("finance_qty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("accept_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("renovation_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("report_limit",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("license_company",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("equipment_retention",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("office_remark",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("license_basic",GauceDataColumn.TB_STRING,2000));
	 dSet.addDataColumn(new GauceDataColumn("license_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.LICENSE_CLASS_CODE,   " + 
     "         a.LICENSE_KIND_CODE,   " + 
     "         a.LICENSE_NO,   " + 
     "         a.CONT_LIMIT_AMT,   " + 
     "         a.ENG_LIMIT_AMT,   " + 
     "         a.CONST_LIMIT_AMT,   " + 
     "         a.FUND_AMT,   " + 
     "         a.FINANCE_QTY,   " + 
     "         to_char(a.ACCEPT_DATE,'YYYY.MM.DD')  ACCEPT_DATE, " + 
     "         to_char(a.RENOVATION_DATE,'YYYY.MM.DD') RENOVATION_DATE,  " + 
     "         a.REPORT_LIMIT,   " + 
     "         a.LICENSE_COMPANY,   " + 
     "         a.EQUIPMENT_RETENTION,   " + 
     "         a.OFFICE_REMARK," +
	 "         a.LICENSE_BASIC," +
     "			b.license_name  " + 
     "    FROM R_GENERAL_LICENSE_REGISTER  a," + 
     "			R_CODE_LICENSE b" + 
     "   WHERE a.license_class_code = b.license_class_code (+) and" + 
     "			a.license_kind_code = b.license_kind_code (+) and" + 
     "			a.LICENSE_CLASS_CODE = " + "'" + arg_class + "'" + "  AND  " + 
     "         a.LICENSE_KIND_CODE = " + "'" + arg_kind + "'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>