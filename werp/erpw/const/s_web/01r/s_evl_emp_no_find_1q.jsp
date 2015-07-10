<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_code = req.getParameter("arg_code");
     String arg_num = req.getParameter("arg_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("evl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fi_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_note",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.sbcr_unq_num ," + 
     "          a.profession_wbs_code ," + 
     "          b.profession_wbs_name ," + 
     "          a.emp_no ," + 
     "          a.emp_name ," + 
     "          a.evl_date ," + 
     "          a.const_score ," + 
     "          a.fi_score ," + 
     "          a.etc_score ," + 
     "          a.evl_note ," + 
     "          a.remark   " +
     "      FROM s_req_evl_summary a, s_req_wbs_request b    " +
     "    where a.sbcr_unq_num = b.sbcr_unq_num " +
     "      and a.profession_wbs_code = b.profession_wbs_code " +
     "      and a.profession_wbs_code = '" + arg_code + "' " +
     "      and a.sbcr_unq_num = " + arg_num + "   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>