<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code  = req.getParameter("arg_dept_code");
     String arg_cont_no    = req.getParameter("arg_cont_no");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pq_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("estimation_standard",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("identity_standard",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pq_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.CONT_NO,   " + 
     "         a.CHG_DEGREE,   " + 
     "         a.PQ_CODE,   " + 
     "         a.PQ_AMT,   " + 
     "         a.ESTIMATION_STANDARD,   " + 
     "         a.IDENTITY_STANDARD,   " + 
     "         b.PQ_NAME  " + 
     "    FROM R_TENDER_PQ a,   " + 
     "         R_CODE_PQ b " + 
     "   WHERE a.PQ_CODE    = b.PQ_CODE  and  " + 
     "         a.DEPT_CODE  = " + "'" + arg_dept_code + "'" + "  AND  " + 
     "         a.CONT_NO    = " + "'" + arg_cont_no + "'" + " AND  " + 
     "         a.CHG_DEGREE = " + "'" + arg_chg_degree + "'" ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>