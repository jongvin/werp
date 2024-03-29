<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_name = req.getParameter("arg_name");
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     String arg_wbs = req.getParameter("arg_wbs");
     arg_name = '%' + arg_name + '%';
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
     arg_wbs = '%' + arg_wbs + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("evl_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("evl_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("evl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("id2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("score1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("score2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eva_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("add_score",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("evl_desc1",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("evl_desc2",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("temp_col",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.evl_year ," + 
					    "          a.degree ," + 
					    "          a.evl_class ," + 
					    "          a.dept_code ," + 
					    "          a.order_number ," + 
					    "          a.sbcr_code ," + 
					    "          a.sbcr_name ," + 
					    "          decode(a.evl_yn,'Y','T','F') evl_yn ," + 
					    "          a.profession_wbs_code ," + 
					    "          a.profession_wbs_name ," + 
					    "          a.sbc_name ," + 
					    "          a.order_class ," + 
					    "          a.evl_id ," + 
					    "          a.evl_name ," + 
					    "          a.id2 ," + 
					    "          a.name2 ," + 
					    "          a.score1 ," + 
					    "          a.score2 ," + 
					    "          a.eva_score ," + 
					    "          a.add_score ," + 
					    "          a.evl_desc1 ," + 
					    "          a.evl_desc2, " +
					    "          '' temp_col ,  " +
					    "          b.long_name " +
					    "     FROM s_evl_proj_evlsbcr a, " +
					    "          s_evl_evldept b " +
					    "    WHERE a.evl_year =  b.evl_year " +
					    "      and a.degree = b.degree " +
					    "      and a.evl_class = b.evl_class  " +
					    "      and a.dept_code = b.dept_code " +
					    "      and b.long_name like '" + arg_name + "'" +
					    "      and a.EVL_YEAR = '" + arg_year + "'" +
					    "      and a.DEGREE = " + arg_degree +
					    "      and a.EVL_CLASS = '" + arg_class + "'" +
					    "      and a.sbcr_name like '" + arg_sbcr_name + "'" +
					    "      and a.profession_wbs_code like '" + arg_wbs + "'" +
					    "      and a.evl_yn = 'Y' " +
					    " ORDER BY a.dept_code          ASC," + 
					    "          a.sbcr_name          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>