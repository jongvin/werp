<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pr_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_7",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_8",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_9",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("m_12",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
    String query = " SELECT  a.work_year, " + 
     					 "          a.spec_no_seq ," + 
     					 "          a.no_seq ," + 
     					 "          a.dept_name ," + 
     					 "          a.pr_div ," + 
     					 "				a.tag, " +
     					 "          a.m_1 ," + 
     					 "          a.m_2 ," + 
     					 "          a.m_3 ," + 
     					 "          a.m_4 ," + 
     					 "          a.m_5 ," + 
     					 "          a.m_6 ," + 
     					 "          a.m_7 ," + 
     					 "          a.m_8 ," + 
     					 "          a.m_9 ," + 
     					 "          a.m_10 ," + 
     					 "          a.m_11 ," + 
     					 "          a.m_12  " +
     					 "     FROM ( SELECT  to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
     					 " 			         a.spec_no_seq ," + 
     					 " 			         a.no_seq ," + 
     					 " 			         a.dept_name ," + 
     					 " 			         a.pr_div ," + 
     					 "							'A' tag, " +
     					 " 			         a.m_1 ," + 
     					 " 			         a.m_2 ," + 
     					 " 			         a.m_3 ," + 
     					 " 			         a.m_4 ," + 
     					 " 			         a.m_5 ," + 
     					 " 			         a.m_6 ," + 
     					 " 			         a.m_7 ," + 
     					 " 			         a.m_8 ," + 
     					 " 			         a.m_9 ," + 
     					 " 			         a.m_10 ," + 
     					 " 			         a.m_11 ," + 
     					 " 			         a.m_12  " +
     					 " 			    FROM g_mis_dept_ord_result    a  " +
     					 " 			   where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy') "+
     					 " 			union all " +
     					 " 			 SELECT  to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
     					 " 			         0 ," + 
     					 " 			         99999 ," + 
     					 " 			         '합계' ," + 
     					 " 			         a.pr_div ," + 
     					 "							'B' tag, " +
     					 " 			         sum(a.m_1 ) ," + 
     					 " 			         sum(a.m_2 ) ," + 
     					 " 			         sum(a.m_3 ) ," + 
     					 " 			         sum(a.m_4 ) ," + 
     					 " 			         sum(a.m_5 ) ," + 
     					 " 			         sum(a.m_6 ) ," + 
     					 " 			         sum(a.m_7 ) ," + 
     					 " 			         sum(a.m_8 ) ," + 
     					 " 			         sum(a.m_9 ) ," + 
     					 " 			         sum(a.m_10) ," + 
     					 " 			         sum(a.m_11) ," + 
     					 " 			         sum(a.m_12)  " +
     					 " 			    FROM g_mis_dept_ord_result    a  " +
     					 " 			   where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy') "+
     					 " 			group by to_char(a.work_year,'yyyy.mm.dd')  ," + 
     					 " 			         a.pr_div " +
     					 " 			) a " +
     					 " order by a.no_seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>