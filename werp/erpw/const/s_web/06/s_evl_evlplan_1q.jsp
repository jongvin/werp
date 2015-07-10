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
     dSet.addDataColumn(new GauceDataColumn("proj_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_dept",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.evl_year ," + 
                   "          a.degree ," + 
                   "          a.evl_class ," + 
                   "          to_char(a.evl_f_date,'YYYY.MM.DD') evl_f_date ," + 
                   "          to_char(a.evl_t_date,'YYYY.MM.DD')  evl_t_date," + 
                   "          to_char(a.from_date,'YYYY.MM.DD')  from_date," + 
                   "          to_char(a.to_date,'YYYY.MM.DD')  to_date," + 
                   "          a.dept_code ," + 
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
                   "          a.proj_close ," + 
                   "          a.bonsa_close, " +
                   "          b.long_name ," +
                   "          nvl(c.cnt_a,0) || '/' || nvl(d.cnt_b,0) cnt_dept" +
                   "     FROM s_evl_evlplan a, " +
                   "          z_code_dept b, " +
                   "        ( select nvl(count(*),0) cnt_a,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_evldept " +
                   "           where evl_yn = 'Y' " +
                   "        group by evl_year,degree,evl_class ) c," +
                   "        ( select nvl(count(*),0) cnt_b,max(evl_year) evl_year,max(degree) degree,max(evl_class) evl_class " +
                   "            from s_evl_evldept " +
                   "        group by evl_year,degree,evl_class ) d " +
                   "    WHERE a.evl_year  = c.evl_year(+) " +
                   "      and a.degree    = c.degree(+) " +
                   "      and a.evl_class = c.evl_class(+) " +
                   "      and a.evl_year  = d.evl_year(+) " +
                   "      and a.degree    = d.degree(+) " +
                   "      and a.evl_class = d.evl_class(+) " +
                   "      and a.dept_code = b.dept_code(+) " +
                   "      and a.EVL_YEAR like '" + arg_year + "'" + 
                   "      and a.EVL_CLASS like '" + arg_class + "'" + 
                   " ORDER BY a.evl_year          DESC," + 
                   "          a.degree          DESC," + 
                   "          a.evl_class          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>