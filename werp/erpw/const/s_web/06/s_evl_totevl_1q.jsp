<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_wbs = req.getParameter("arg_wbs");
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     arg_wbs = '%' + arg_wbs + '%';
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("b_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("a_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("c_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("eva_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score3",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score4",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score5",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score6",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score_tot",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("guarantee_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.evl_year ," + 
   					 "          a.profession_wbs_code ," + 
   					 "          a.sbcr_code ," + 
   					 "          a.profession_wbs_name ," + 
   					 "          a.sbcr_name ," + 
   					 "          a.b_score ," + 
   					 "          a.a_score ," + 
   					 "          a.c_score ," + 
   					 "          a.eva_score ," + 
   					 "          a.add_score1 ," + 
   					 "          a.add_score2 ," + 
   					 "          a.add_score3 ," + 
   					 "          a.add_score4 ," + 
   					 "          a.add_score5 ," + 
   					 "          a.add_score6 ," + 
   					 "          a.add_score_tot ," + 
   					 "          a.tot_score ," + 
   					 "          a.guarantee_yn ," + 
   					 "          a.proj_cnt ,   " +
   					 "          a.tot_close, " +
   					 "          b.register_chk " +
   					 "     FROM s_evl_totevl a, " +
   					 "          s_wbs_request b " +
   					 "    WHERE a.sbcr_code = b.sbcr_code (+) " +
   					 "      and a.profession_wbs_code = b.profession_wbs_code (+) " +
   					 "      and a.EVL_YEAR = '" + arg_year + "'" +
   					 "      and a.PROFESSION_WBS_CODE like '" + arg_wbs + "'" +
   					 "      and a.SBCR_NAME like '" + arg_sbcr_name + "'" +
   					 " order by a.profession_wbs_code ,a.sbcr_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>