<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	  String arg_to_date = req.getParameter("arg_to_date");
     String arg_from_date = req.getParameter("arg_from_date");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("SSIZE",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("UNITCODE",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("QTY",GauceDataColumn.TB_DECIMAL,10,3));
	  dSet.addDataColumn(new GauceDataColumn("MAT_CONDITION",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("CONDITION1",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("CONDITION2",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("CONDITION3",GauceDataColumn.TB_STRING,1));

   String query = "  SELECT   " + 
     "      a.DEPT_CODE     , "  +
     "      (select long_name from z_code_dept where dept_code = a.dept_code) dept_name , "  +
	  "      to_char(a.YYMMDD,'yyyymmdd') yymmdd   , "  +
     "      a.SEQ           , "  +
     "      a.NAME          , "  +
     "      a.SSIZE         , "  +
     "      a.UNITCODE      , "  +
     "      a.QTY           , "  +
     "      a.MAT_CONDITION , "  +
	  "      decode(a.MAT_CONDITION,'A','T','F') CONDITION1 , " +
	  "      decode(a.MAT_CONDITION,'B','T','F') CONDITION2 , " +
	  "      decode(a.MAT_CONDITION,'C','T','F') CONDITION3  " +
	  "   FROM M_CUSTODY_MAT_CHK a " + 
     "   WHERE   " + 
	  "       to_char(a.YYMMDD,'yyyymmdd') >= '" + arg_to_date + "' and " +     
	  "       to_char(a.YYMMDD,'yyyymmdd') <= '" + arg_from_date + "' and  " +
	  "       dept_code = '" +arg_dept_code  + "'" +
	  "   ORDER BY 3   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>