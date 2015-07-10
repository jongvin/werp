<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_year_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("completion_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_process_class",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT DEPT_CODE," + 
     "             CONT_NO," + 
     "             CONTRACT_YEAR_TAG," + 
     "             COMPLETION_TAG," + 
     "             ORDER_NO," + 
     "             CONST_NAME," + 
     "             CONST_PROCESS_CLASS     " +
     "        FROM R_CONTRACT_REGISTER " +
     "       WHERE CHG_DEGREE = 1 " +
     "    ORDER BY dept_code asc," + 
     "             cont_no desc                    ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>