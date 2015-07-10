<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_class = req.getParameter("arg_class");
     arg_year = "%" + arg_year + "%";
     arg_class = "%" + arg_class + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("evl_f_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("evl_t_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("from_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("proj_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bon_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_dept",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cnt_bon",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.evl_year ," + 
                   "          a.degree ," + 
                   "          a.evl_class ," + 
                   "          to_char(a.evl_f_date,'YYYY.MM.DD') evl_f_date ," + 
                   "          to_char(a.evl_t_date,'YYYY.MM.DD')  evl_t_date," + 
                   "          to_char(a.from_date,'YYYY.MM.DD')  from_date," + 
                   "          to_char(a.to_date,'YYYY.MM.DD')  to_date," + 
                   "          a.dept_code ," + 
                   "          a.proj_close ," + 
                   "          a.bonsa_close, " +
                   "          b.long_name ," +
                   "          decode(d.cnt_a,0,0,(c.cnt_a / d.cnt_a) * 100)  dept_rt, " +
                   "          decode(f.cnt_a,0,0,(e.cnt_a / f.cnt_a) * 100)  bon_rt, " +
                   "          nvl(c.cnt_a,0) || '/' || nvl(d.cnt_a,0) cnt_dept," +
                   "          nvl(e.cnt_a,0) || '/' || nvl(f.cnt_a,0) cnt_bon "  +
                   "     FROM s_evl_evlplan a, " +
                   "          z_code_dept b, " +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_proj_evlsbcr " +
                   "           where evl_yn = 'Y' " +
                   "             and eva_score > 0 " +
                   "        group by evl_year,degree,evl_class ) c," +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_proj_evlsbcr " +
                   "           where evl_yn = 'Y' " +
                   "        group by evl_year,degree,evl_class ) d," +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_bon_evlsbcr " +
                   "           where tot_score > 0 " +
                   "        group by evl_year,degree,evl_class ) e," +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_bon_evlsbcr " +
                   "        group by evl_year,degree,evl_class ) f" +
                   "    WHERE a.evl_year  = c.evl_year(+) " +
                   "      and a.degree    = c.degree(+) " +
                   "      and a.evl_class = c.evl_class(+) " +
                   "      and a.evl_year  = d.evl_year(+) " +
                   "      and a.degree    = d.degree(+) " +
                   "      and a.evl_class = d.evl_class(+) " +
                   "      and a.evl_year  = e.evl_year(+) " +
                   "      and a.degree    = e.degree(+) " +
                   "      and a.evl_class = e.evl_class(+) " +
                   "      and a.evl_year  = f.evl_year(+) " +
                   "      and a.degree    = f.degree(+) " +
                   "      and a.evl_class = f.evl_class(+) " +
                   "      and a.dept_code = b.dept_code(+) " +
                   "      and a.EVL_YEAR like '" + arg_year + "'" + 
                   "      and a.EVL_CLASS like '" + arg_class + "'" + 
                   " ORDER BY a.evl_year          DESC," + 
                   "          a.degree          DESC," + 
                   "          a.evl_class          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>