<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("detail_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,19));
    String query = " select a.dept_code," + 
     "               		 a.wbs_code," + 
     "               		 a.name," + 
     "               		 b.detail_code," + 
     "               		 b.name detail_name," + 
     "               		 b.ssize," + 
     "               		 b.unit," + 
     "               		 b.qty," + 
     "               		 b.price," + 
     "               		 b.amt," + 
     "               		 b.remark," + 
     "               		 c.long_name," + 
     "                		 to_char(c.chg_const_start_date,'YYYY.MM.DD') chg_const_start_date," + 
     "               		 to_char(c.chg_const_end_date,'YYYY.MM.DD')   chg_const_end_date," + 
     "               		 c.chg_const_term, " + 
     "                      sysdate " +
     "                 from y_projmng_amt_wbs a," + 
     "                      y_projmng_amt b," + 
     "                 	    z_code_dept c" + 
     "                where a.dept_code = c.dept_code(+)" + 
     "                  and a.dept_code = b.dept_code(+)" + 
     "                  and a.wbs_code = b.wbs_code (+)" + 
     "                  and b.spec_unq_num <> 0" + 
     "                  and a.dept_code = " + "'" + arg_dept_code + "'" + 
     "                  and a.spec_no_seq <> 0" + 
     "             order by a.wbs_code asc, b.detail_code asc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>