<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_wbs_code = req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("key_profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("register_req_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("register_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("treatkind_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("rep_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("recommender_department",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("recommender_grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("recommender_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("recommender_rel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("recommender_reson",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("our_const_proj",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("our_const_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chrg_year",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  sbcr_unq_num ," + 
    					 "          profession_wbs_code ," + 
    					 "          profession_wbs_code key_profession_wbs_code," + 
    					 "          register_chk ," + 
    					 "          to_char(register_req_date,'YYYY.MM.DD') register_req_date ," + 
    					 "          to_char(register_date,'YYYY.MM.DD')  register_date," + 
    					 "          profession_wbs_name ," + 
    					 "          treatkind_code ," + 
    					 "          rep_year ," + 
    					 "          recommender_department ," + 
    					 "          recommender_grade ," + 
    					 "          recommender_name ," + 
    					 "          recommender_rel ," + 
    					 "          recommender_reson ," + 
    					 "          our_const_proj ," + 
    					 "          our_const_amt, " +
    					 "          chrg_year " +
    					 "     FROM s_req_wbs_request " +
    					 "    WHERE SBCR_UNQ_NUM = " + arg_unq_num +
    					 "      AND profession_wbs_code = '" + arg_wbs_code + "'" +
    					 " ORDER BY profession_wbs_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>