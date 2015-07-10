<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("evl_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("t_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("t_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("a_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("a_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("m_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("m_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("e_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("e_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("c_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("c_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("j_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("j_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("mat_id",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mat_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("id2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bak_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("eva_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ctrl_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("evl_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_rt",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT  a.evl_year ," + 
     					 "          a.degree ," + 
     					 "          a.evl_class ," + 
     					 "          a.dept_code ," + 
     					 "          a.long_name ," + 
     					 "          a.evl_yn ," + 
     					 "          a.t_id ," + 
     					 "          a.t_name ," + 
     					 "          a.a_id ," + 
     					 "          a.a_name ," + 
     					 "          a.m_id ," + 
     					 "          a.m_name ," + 
     					 "          a.e_id ," + 
     					 "          a.e_name ," + 
     					 "          a.c_id ," + 
     					 "          a.c_name ," + 
     					 "          a.j_id ," + 
     					 "          a.j_name ," + 
     					 "          a.mat_id ," + 
     					 "          a.mat_name ," + 
     					 "          a.id2 ," + 
     					 "          a.name2 ," + 
     					 "          a.eva_score bak_score," + 
     					 "          decode(b.cnt_a,0,0,(b.ll_eva + b.ll_add) / b.cnt_a) eva_score," +
     					 "          a.ctrl_score , " +
     					 "          b.cnt_a evl_cnt," +
     					 "          c.cnt_a tot_cnt, " +
     					 "          decode(c.cnt_a,0,0,(b.cnt_a / c.cnt_a) * 100) evl_rt " +
     					 "     FROM s_evl_evldept a ," +
                   "        ( select nvl(count(*),0) cnt_a,nvl(sum(eva_score),0) ll_eva, nvl(sum(add_score),0) ll_add,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class,max(dept_code) dept_code " +
                   "            from s_evl_proj_evlsbcr " +
                   "           where evl_yn = 'Y' " +
                   "             and eva_score > 0 " +
                   "        group by evl_year,degree,evl_class,dept_code ) b," +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class,max(dept_code) dept_code " +
                   "            from s_evl_proj_evlsbcr " +
                   "           where evl_yn = 'Y' " +
                   "        group by evl_year,degree,evl_class,dept_code ) c" +
     					 "    WHERE a.evl_year  = b.evl_year(+) " +
     					 "      and a.degree    = b.degree(+)" +
     					 "      and a.evl_class = b.evl_class(+) " +
     					 "      and a.dept_code = b.dept_code(+) " +
     					 "      and a.evl_year  = c.evl_year (+)" +
     					 "      and a.degree    = c.degree(+) " +
     					 "      and a.evl_class = c.evl_class(+) " +
     					 "      and a.dept_code = c.dept_code(+) " +
     					 "      and a.EVL_YEAR = '" + arg_year + "'" +
     					 "      and a.DEGREE = " + arg_degree +
     					 "      and a.EVL_CLASS = '" + arg_class + "'" +
     					 "      and a.evl_yn = 'Y'" +
     					 " ORDER BY a.evl_year          ASC," + 
     					 "          a.degree          ASC," + 
     					 "          a.evl_class          ASC," + 
     					 "          a.dept_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>