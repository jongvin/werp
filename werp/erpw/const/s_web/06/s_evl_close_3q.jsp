<%@ page contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ll_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_ave",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("evl_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.evl_year ," + 
                   "          a.degree ," + 
                   "          a.evl_class ," + 
                   "          '본    사'  ll_name, " +
                   "          decode(d.cnt_a,0,0,(c.cnt_a / d.cnt_a) * 100)  dept_rt, " +
                   "          decode(c.cnt_a,0,0,c.tot_score / c.cnt_a) tot_ave, " +
                   "          nvl(c.cnt_a,0)  evl_cnt, " +
                   "          nvl(d.cnt_a,0) tot_cnt " +
                   "     FROM s_evl_evlplan a, " +
                   "        ( select nvl(count(*),0) cnt_a,nvl(sum(tot_score),0) tot_score,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_bon_evlsbcr " +
                   "           where tot_score > 0 " +
                   "        group by evl_year,degree,evl_class ) c," +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_bon_evlsbcr " +
                   "        group by evl_year,degree,evl_class ) d" +
                   "    WHERE a.evl_year  = c.evl_year(+) " +
                   "      and a.degree    = c.degree(+) " +
                   "      and a.evl_class = c.evl_class(+) " +
                   "      and a.evl_year  = d.evl_year(+) " +
                   "      and a.degree    = d.degree(+) " +
                   "      and a.evl_class = d.evl_class(+) " +
                   "      and a.EVL_YEAR = '" + arg_year + "'" + 
                   "      and a.degree   = " + arg_degree +
                   "      and a.EVL_CLASS = '" + arg_class + "'" + 
                   " ORDER BY a.evl_year          DESC," + 
                   "          a.degree          DESC," + 
                   "          a.evl_class          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>