<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_evl_class = req.getParameter("arg_evl_class");
     String arg_proj_class = req.getParameter("arg_proj_class");
     String arg_class1 = req.getParameter("arg_class1");
     arg_proj_class = '%' + arg_proj_class + '%';
     arg_class1 = '%' + arg_class1 + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("class1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mng_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_proj_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_class1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_mng_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("b_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  a.evl_year , "+
    					 "          a.degree, " +
    					 "          a.evl_class , "+
    					 "          a.proj_class ," + 
     					 "          a.class1 ," + 
     					 "          a.mng_class ," + 
     					 "          a.seq, " +
     					 "          a.proj_class key_proj_class, " +
     					 "          a.class1    key_class1," + 
     					 "          a.mng_class key_mng_class," + 
     					 "          a.seq       key_seq, " +
     					 "          a.name ," + 
     					 "          a.b_score ," + 
     					 "          a.note     " +
     					 "     FROM s_comm_evlcode a " +
     					 "    WHERE a.evl_year = '" + arg_year + "'" +
     					 "      and a.degree  =  " + arg_degree +
     					 "      and a.evl_class = '" + arg_evl_class + "'" +
     					 "      and a.PROJ_CLASS like '" + arg_proj_class + "'" +
     					 "      and a.CLASS1 like '" + arg_class1 + "'" +
     					 " ORDER BY a.proj_class          ASC," + 
     					 "          a.class1          ASC," + 
     					 "          a.mng_class          ASC,      " +
     					 "          a.seq asc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>