<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT DEPT_CODE,   " + 
     "         WBS_CODE,   " + 
     "         nvl(SPEC_NO_SEQ,0) spec_no_seq,   " + 
     "         NAME,   " + 
     "         AMT,   " + 
     "         to_char(WORK_DT,'YYYY.MM.DD') work_dt,   " + 
     "         NOTE,   " + 
     "         to_char(INPUT_DT,'YYYY.MM.DD') input_dt,   " + 
     "         INPUT_NAME  " + 
     "    FROM Y_PROJMNG_AMT_WBS  " + 
     "   WHERE DEPT_CODE = " + "'" + arg_dept_code  + "'" + 
     "ORDER BY WBS_CODE ASC " + 
     "                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>