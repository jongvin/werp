<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     //String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT DEPT_CODE," + 
		"             LONG_NAME,        " +
		"            'F' chk_tag        " +
		"       FROM Z_CODE_DEPT       " +
		"      WHERE ( PROCESS_CODE = '01' ) AND " +
		"            ( USE_TAG = 'Y' )          ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>