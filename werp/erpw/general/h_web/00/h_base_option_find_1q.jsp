<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cls_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cls_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("elem_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("elem_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("base_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT b.CLS_NAME,   " + 
     "                       a.CLS_CODE,   " + 
     "                       a.ELEM_CODE,   " + 
     "                       a.ELEM_NAME,   " + 
     "                       a.BASE_YN  " + 
     "                  FROM H_BASE_OPTION_DETAIL a,   " + 
     "                       H_BASE_OPTION_MASTER b " + 
     "                 WHERE b.DEPT_CODE = a.DEPT_CODE " + 
     "                   AND b.CLS_CODE = a.CLS_CODE " + 
     "                   AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "              ORDER BY a.CLS_CODE ASC,   " + 
     "                       a.ELEM_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>