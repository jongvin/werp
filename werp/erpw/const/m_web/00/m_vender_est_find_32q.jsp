<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_seq = req.getParameter("arg_seq");
     String arg_chg_cnt = req.getParameter("arg_chg_cnt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT a.mtrcode,   " + 
     					"          a.name,   " + 
     					"          a.ssize,  " + 
     					"          a.unitcode, " +
     					"          a.qty " +
     					"     FROM m_request_detail a   " + 
     					"    WHERE a.dept_code = '" + arg_dept_code + "'" + 
     					"      and a.requestseq = " + arg_seq + 
     					"      and a.chg_cnt =  " + arg_chg_cnt +
     					" ORDER BY a.mtrcode ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>