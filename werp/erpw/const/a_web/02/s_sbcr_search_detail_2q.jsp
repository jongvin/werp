<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("b_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("a_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("c_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("eva_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score_tot",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT  evl_year ," + 
     					 "          profession_wbs_name ," + 
     					 "          b_score ," + 
     					 "          a_score ," + 
     					 "          c_score ," + 
     					 "          eva_score ," + 
     					 "          add_score_tot ," + 
     					 "          tot_score " +
     					 "     FROM s_evl_totevl " +
     					 "    WHERE SBCR_CODE = '" + arg_sbcr_code + "'" +
     					 " ORDER BY evl_year          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>