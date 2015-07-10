<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_profession_wbs_code = req.getParameter("arg_profession_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("evl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fi_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_note",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.sbcr_unq_num ," + 
     					 "          a.emp_no ," + 
     					 "          a.emp_name ," + 
     					 "          to_char(a.evl_date,'YYYY.MM.DD') evl_date ," + 
     					 "          a.const_score ," + 
     					 "          a.fi_score ," + 
     					 "          a.etc_score ," + 
     					 "          a.const_score + a.fi_score + a.etc_score  tot_score," + 
     					 "          a.evl_note ," + 
     					 "          a.remark  " +
     					 "     FROM s_req_evl_summary a " +
     					 "    WHERE a.SBCR_UNQ_NUM = " + arg_unq_num +
     					 "      and a.profession_wbs_code = '" + arg_profession_wbs_code + "'" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>