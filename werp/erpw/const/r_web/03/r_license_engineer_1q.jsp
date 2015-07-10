<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
     String arg_kind = req.getParameter("arg_kind");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("engineer_empno",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("key_engineer_empno",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("regist_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("license_term",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("engineer_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("work_tag",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT A.LICENSE_CLASS_CODE,   " + 
     "         A.LICENSE_KIND_CODE,   " + 
     "         A.SEQ,   " + 
     "         A.ENGINEER_EMPNO,   " + 
     "         A.ENGINEER_EMPNO   KEY_ENGINEER_EMPNO,   " + 
     "         A.REGIST_TAG,   " + 
     "         A.LICENSE_TERM,   " + 
     "         A.ENGINEER_NAME,  " + 
     "			B.stsgbn work_tag " +
     "    FROM R_GENERAL_LICENSE_ENGINEER A, " + 
     " 		   PMAS001VV@CJHRM B " +
     "   WHERE A.ENGINEER_EMPNO = B.empno(+) AND " +
     "			A.LICENSE_CLASS_CODE = " + "'" + arg_class + "'" + "  AND  " + 
     "         A.LICENSE_KIND_CODE = " + "'" + arg_kind + "'" + " AND  " + 
     "         A.SEQ = " + "'" + arg_seq   + "'" + 
     "ORDER BY A.ENGINEER_EMPNO ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>