<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_dept = req.getParameter("arg_dept");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
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
     dSet.addDataColumn(new GauceDataColumn("evl_f_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("evl_t_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("from_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.evl_year ," + 
     					 "          a.degree ," + 
     					 "          a.evl_class ," + 
     					 "          a.dept_code ," + 
     					 "          a.long_name ," + 
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
     					 "          to_char(b.evl_f_date,'YYYY.MM.DD')  evl_f_date, " +
     					 "          to_char(b.evl_t_date,'YYYY.MM.DD')  evl_t_date, " +
     					 "          to_char(b.from_date, 'YYYY.MM.DD')  from_date, " +
     					 "          to_char(b.to_date,   'YYYY.MM.DD')  to_date   " +
     					 "     FROM s_evl_evldept a ," +
     					 "          s_evl_evlplan b " +
     					 "    WHERE a.evl_year  = b.evl_year " +
     					 "      and a.degree    = b.degree " +
     					 "      and a.evl_class = b.evl_class " +
     					 "      and a.EVL_YEAR = '" + arg_year + "'" +
     					 "      and a.DEGREE = " + arg_degree +
     					 "      and a.EVL_CLASS = '" + arg_class + "'" +
     					 "      and a.dept_code = '" + arg_dept + "'" +
     					 " ORDER BY a.dept_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>