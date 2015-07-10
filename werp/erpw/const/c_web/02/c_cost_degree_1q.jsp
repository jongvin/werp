<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("chg_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,32759));
    String query = "  SELECT a.dept_code,   " + 
     "         a.chg_no_seq,   " + 
     "         a.tag,   " + 
     "         a.chg_title,   " + 
     "         a.approve_class,   " + 
     "         to_char(a.work_dt,'yyyy.mm.dd') work_dt,   " + 
     "         to_char(a.request_dt,'yyyy.mm.dd') request_dt," + 
     "         to_char(a.approve_dt,'yyyy.mm.dd') approve_dt,   " + 
     "         a.remark  " + 
     "    FROM c_cost_degree a " + 
     "   WHERE a.dept_code = '" + arg_dept_code + "'  " + 
     "ORDER BY a.chg_no_seq DESC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>