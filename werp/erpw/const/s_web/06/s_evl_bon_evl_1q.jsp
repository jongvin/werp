<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     String arg_wbs = req.getParameter("arg_wbs");
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
     arg_wbs = '%' + arg_wbs + '%';
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
                   "          a.evl_desc2  " +
                   "     FROM s_evl_bon_evlsbcr a " +
                   "    WHERE a.EVL_YEAR = '" + arg_year + "'" +
                   "      and a.DEGREE = " + arg_degree + 
                   "      and a.EVL_CLASS = '" + arg_class + "'" +
                   "      and a.sbcr_name like '" + arg_sbcr_name + "'" +
                   "      and a.profession_wbs_code like '" + arg_wbs + "'" +
                   " ORDER BY a.profession_wbs_code          ASC," + 
                   "          a.sbcr_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>