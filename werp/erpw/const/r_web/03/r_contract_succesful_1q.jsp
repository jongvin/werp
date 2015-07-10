<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_cont_no = req.getParameter("arg_cont_no");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("membership_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("customer_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("company_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("operation_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("division_rate",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("division_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("operation_rate",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("operation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("charger",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         nvl(a.CONT_NO,0) CONT_NO,   " + 
     "         nvl(a.CHG_DEGREE,0) CHG_DEGREE,   " + 
     "         a.MEMBERSHIP_NO,   " + 
     "			b.membership_name," + 
     "         a.CUSTOMER_NO,   " + 
     "         a.COMPANY_TAG,   " + 
     "         a.OPERATION_TAG,   " + 
     "         nvl(a.DIVISION_RATE,0) DIVISION_RATE,   " + 
     "         nvl(a.DIVISION_AMT,0)  DIVISION_AMT,   " + 
     "         nvl(a.OPERATION_RATE,0) OPERATION_RATE,   " + 
     "         nvl(a.OPERATION_AMT,0)  OPERATION_AMT,   " + 
     "         a.CHARGER,   " + 
     "         a.TEL,   " + 
     "         a.REMARK  " + 
     "    FROM R_CONTRACT_SUCCESFUL_BID  a," + 
     "			r_code_membership b" + 
     "   WHERE a.membership_no = b.membership_no (+) and" + 
     "			a.DEPT_CODE = " + "'" + arg_dept_code + "'" + "  AND  " + 
     "         a.CONT_NO = " +  arg_cont_no +  " AND  " + 
     "         a.CHG_DEGREE = " +  arg_chg_degree + " " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>