<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("company_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("operation_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("division_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("charger",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
    String query = "SELECT A.DEPT_CODE,   " + 
     "		 A.CUST_CODE,   " + 
     "		 B.CUST_NAME,   " + 
     "		 A.COMPANY_TAG,   " + 
     "		 A.OPERATION_TAG,   " + 
     "		 NVL(A.DIVISION_RATE, 0) DIVISION_RATE, " + 
     "		 A.CHARGER,   " + 
     "		 A.TEL,   " + 
     "		 A.REMARK  " + 
     "  FROM F_UNI_CONT A, " +
     "       Z_CODE_CUST_CODE B " +
     " WHERE A.CUST_CODE = B.CUST_CODE AND " +
     			"A.DEPT_CODE = " + "'" + as_dept_code + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>