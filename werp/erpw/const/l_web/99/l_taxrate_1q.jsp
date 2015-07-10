<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("taxrate_apply_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_taxrate_apply_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("deduction_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_taxrate",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("civil_taxrate",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("deduction_taxrate",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("comp_text",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("insurance_taxrate",GauceDataColumn.TB_DECIMAL,4,2));
    String query = "  SELECT to_char(TAXRATE_APPLY_DATE,'YYYY.MM.DD') TAXRATE_APPLY_DATE," + 
     "             to_char(TAXRATE_APPLY_DATE,'YYYY.MM.DD') KEY_TAXRATE_APPLY_DATE," + 
     "             DEDUCTION_AMT," + 
     "             INCOME_TAXRATE," + 
     "             CIVIL_TAXRATE," + 
     "             DEDUCTION_TAXRATE," + 
     "             INSURANCE_TAXRATE, " +
     "             ''        comp_text " + 
     "        FROM L_TAXRATE         " +
     "        ORDER BY TAXRATE_APPLY_DATE DESC ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>