<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,8));     
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,8)); 
     dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("k_yymmdd",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("status",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("status1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("make_dt",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("user_no",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT to_char(a.yymm, 'yyyy.mm') yymm,								" + 
     "                       to_char(a.yymm, 'yyyymmdd') yymmdd,              		" +
     "                       to_char(a.yymm, 'yyyy.mm.dd') key_yymmdd,              " +
     "                       to_char(a.yymm, 'yyyymmdd') k_yymmdd,                  " +
     "                       a.dept_code,															" + 
     "                       a.status,																" + 
     "                       decode(a.status,1,'작성중',2,'제출',3,'확정')	status1,  " +
     "                       to_char(a.make_dt, 'yyyy.mm.dd') make_dt,					" + 
     "                       a.user_no,															" + 
     "                       a.remark        													" +
     "                  FROM v_test_result a   													" +
     "                 WHERE a.dept_code='" + arg_dept_code + "' 							" +
     "              ORDER BY a.dept_code ASC,													" + 
     "                       a.yymm DESC															";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>