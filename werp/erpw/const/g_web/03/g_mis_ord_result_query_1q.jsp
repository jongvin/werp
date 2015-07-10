<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pr_div",GauceDataColumn.TB_STRING,10));
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
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  '당월' tag , " +
				       "          a.pr_div ," + 
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
				       "  from (SELECT  decode(a.pr_div,'1','계획','실적') pr_div ," + 
				       " 		         sum(a.m_1 ) m_1 ," + 
				       " 		         sum(a.m_2 ) m_2 ," + 
				       " 		         sum(a.m_3 ) m_3 ," + 
				       " 		         sum(a.m_4 ) m_4 ," + 
				       " 		         sum(a.m_5 ) m_5 ," + 
				       " 		         sum(a.m_6 ) m_6 ," + 
				       " 		         sum(a.m_7 ) m_7 ," + 
				       " 		         sum(a.m_8 ) m_8 ," + 
				       " 		         sum(a.m_9 ) m_9 ," + 
				       " 		         sum(a.m_10) m_10 ," + 
				       " 		         sum(a.m_11) m_11 ," + 
				       " 		         sum(a.m_12) m_12  " +
				       " 		    FROM g_mis_dept_ord_result   a  " +
				       " 		   where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy')  " +
				       " 		group by decode(a.pr_div,'1','계획','실적')  " +
     					 " 		union all " +
     					 " 		 SELECT  '차이' pr_div ," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_1 ,0)) - sum(decode(a.pr_div, '1', a.m_1 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_2 ,0)) - sum(decode(a.pr_div, '1', a.m_2 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_3 ,0)) - sum(decode(a.pr_div, '1', a.m_3 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_4 ,0)) - sum(decode(a.pr_div, '1', a.m_4 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_5 ,0)) - sum(decode(a.pr_div, '1', a.m_5 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_6 ,0)) - sum(decode(a.pr_div, '1', a.m_6 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_7 ,0)) - sum(decode(a.pr_div, '1', a.m_7 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_8 ,0)) - sum(decode(a.pr_div, '1', a.m_8 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_9 ,0)) - sum(decode(a.pr_div, '1', a.m_9 , 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_10,0)) - sum(decode(a.pr_div, '1', a.m_10, 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_11,0)) - sum(decode(a.pr_div, '1', a.m_11, 0))," + 
				       " 		         sum(decode(a.pr_div, '2', a.m_12,0)) - sum(decode(a.pr_div, '1', a.m_12, 0)) " +
				       " 		    FROM g_mis_dept_ord_result   a  " +
				       " 		   where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy')  " +
     					 "  	) a " +
     					 " union all " +
     					 "  SELECT  '누계' tag , " +
				       "      		decode(a.pr_div,'1','계획','실적') pr_div ," + 
				       "         sum(a.m_1 ) m_1 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '03'),-1, a.m_1 + a.m_2, 0)) m_2 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '04'),-1, a.m_1 + a.m_2 + a.m_3 )) m_3 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '05'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 )) m_4 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '06'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 )) m_5 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '07'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 )) m_6 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '08'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 )) m_7 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '09'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 + a.m_8 )) m_8 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '10'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 + a.m_8 + a.m_9 )) m_9 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '11'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 + a.m_8 + a.m_9 + a.m_10)) m_10 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '12'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 + a.m_8 + a.m_9 + a.m_10 + a.m_11)) m_11 ," + 
				       "         sum(decode(sign(to_char(a.work_year,'mm') - '13'),-1, a.m_1 + a.m_2 + a.m_3 + a.m_4 + a.m_5 + a.m_6 + a.m_7 + a.m_8 + a.m_9 + a.m_10 + a.m_11 + a.m_12)) m_12  " +
				       "    FROM g_mis_dept_ord_result   a  " +
				       "   where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy')  " +
				       " group by decode(a.pr_div,'1','계획','실적')  " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>