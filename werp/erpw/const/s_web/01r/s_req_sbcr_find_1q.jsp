<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("register_req_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.sbcr_unq_num ," + 
                   "          a.sbcr_code ," + 
                   "          a.sbcr_name ," + 
                   "          b.profession_wbs_code ," + 
                   "          b.profession_wbs_name ," + 
                   "          to_char(b.register_req_date,'YYYY.MM.DD') register_req_date ," + 
                   "          a.businessman_number ," + 
                   "          a.rep_name1 " + 
                   "     FROM s_req_sbcr a, " +
                   "          s_req_wbs_request b " +
                   "    WHERE a.sbcr_unq_num = b.sbcr_unq_num (+) " +
                   " ORDER BY a.sbcr_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>