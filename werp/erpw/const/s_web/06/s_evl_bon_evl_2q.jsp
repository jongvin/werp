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
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("evl_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("evl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("id2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("score1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("score2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_desc1",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("evl_desc2",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("evl_f_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("evl_t_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("from_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.evl_year ," + 
                   "          a.degree ," + 
                   "          a.evl_class ," + 
                   "          a.profession_wbs_code ," + 
                   "          a.sbcr_code ," + 
                   "          a.profession_wbs_name ," + 
                   "          a.sbcr_name ," + 
                   "          a.evl_id ," + 
                   "          a.evl_name ," + 
                   "          a.id2 ," + 
                   "          a.name2 ," + 
                   "          a.score1 ," + 
                   "          a.score2 ," + 
                   "          a.tot_score ," + 
                   "          a.evl_desc1 ," + 
                   "          a.evl_desc2,  " +
     					 "          to_char(b.evl_f_date,'YYYY.MM.DD')  evl_f_date, " +
     					 "          to_char(b.evl_t_date,'YYYY.MM.DD')  evl_t_date, " +
     					 "          to_char(b.from_date, 'YYYY.MM.DD')  from_date, " +
     					 "          to_char(b.to_date,   'YYYY.MM.DD')  to_date   " +
                   "     FROM s_evl_bon_evlsbcr a, " +
                   "          s_evl_evlplan b " +
                   "    WHERE a.evl_year  = b.evl_year " +
                   "      and a.degree    = b.degree " +
                   "      and a.evl_class = b.evl_class " +
                   "      and a.EVL_YEAR = '" + arg_year + "'" +
                   "      and a.DEGREE = " + arg_degree + 
                   "      and a.EVL_CLASS = '" + arg_class + "'" +
                   "      and a.sbcr_code = '" + arg_sbcr_code + "'" +
                   "      and a.profession_wbs_code = '" + arg_wbs + "'" +
                   " ORDER BY a.profession_wbs_code          ASC," + 
                   "          a.sbcr_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>