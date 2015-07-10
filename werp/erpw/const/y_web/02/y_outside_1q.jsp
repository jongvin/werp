<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_approve = req.getParameter("arg_approve");
     String arg_order = req.getParameter("arg_order");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("approve_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("approval_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  a.dept_code ," + 
     "          F_PARENT_NAME(b.dept_code,b.sum_code,b.llevel + 1) parent_name,   " + 
     "          a.spec_unq_num ," + 
     "          a.no_seq ," + 
     "          a.spec_no_seq ," + 
     "          a.detail_code ," + 
     "          a.name ," + 
     "          a.ssize ," + 
     "          a.unit ," + 
     "          a.mat_code ," + 
     "          a.cnt_qty ," + 
     "          a.qty ," + 
     "          to_char(a.work_dt,'yyyy.mm.dd') work_dt ," + 
     "          to_char(a.request_dt,'yyyy.mm.dd') request_dt ," + 
     "          to_char(a.approve_dt,'yyyy.mm.dd') approve_dt ," + 
     "          a.approve_class,  " + 
     "          a.name_key,  " + 
     "          a.approve_chk,  " + 
     "          a.remark,  " + 
     "          a.approval_name  " + 
     "       FROM y_outside  a, y_budget_parent b" + 
     "       WHERE a.DEPT_CODE    = b.DEPT_CODE (+) " + 
     "         AND a.SPEC_NO_SEQ  = b.SPEC_NO_SEQ (+)" + 
     "         AND a.dept_code = '" + arg_dept_code + "'  " + 
     "        " + arg_approve + "  " + 
     "       ORDER BY " + arg_order + "         ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>