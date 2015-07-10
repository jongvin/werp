<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_wbs = req.getParameter("arg_wbs");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("class1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mng_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("score1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("score2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.evl_year ," + 
     					 "          a.degree ," + 
     					 "          a.evl_class ," + 
     					 "          a.profession_wbs_code ," + 
     					 "          a.sbcr_code ," + 
     					 "          a.class1 ," + 
     					 "          a.mng_class ," + 
     					 "          a.seq ," + 
     					 "          a.b_score ," + 
     					 "          a.score1 ," + 
     					 "          a.score2 ," + 
     					 "          b.name " + 
     					 "     FROM s_evl_bon_sbcrdetail a," + 
     					 "          s_comm_evlcode b " +
     					 "    WHERE a.evl_year  = b.evl_year(+) " +
     					 "      and a.degree    = b.degree (+) " +
     					 "      and a.evl_class = b.evl_class (+) " +
     					 "      and a.class1    = b.class1(+) " +
     					 "      and a.mng_class = b.mng_class(+) " +
     					 "      and a.seq  = b.seq (+) " +
     					 "      and b.proj_class = '1' " +
     					 "      and a.EVL_YEAR = '" + arg_year + "'" +
     					 "      and a.DEGREE = " + arg_degree + 
     					 "      and a.EVL_CLASS = '" + arg_class + "'" +
     					 "      and a.profession_wbs_code = '" + arg_wbs + "'" + 
     					 "      And a.sbcr_code = '" + arg_sbcr_code + "'" +
     					 " order by a.class1,a.mng_class,a.seq " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>