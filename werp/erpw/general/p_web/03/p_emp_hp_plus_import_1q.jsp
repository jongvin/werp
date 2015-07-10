<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("appl_part2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,50));        
     dSet.addDataColumn(new GauceDataColumn("car_tag",GauceDataColumn.TB_STRING,10));        
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,10));        
     dSet.addDataColumn(new GauceDataColumn("appl_date",GauceDataColumn.TB_STRING,18));        
    String query = "  SELECT a.employ_degree, a.appl_part , a.appl_part2," + 
     "          a.appl_no ," + 
     "          a.appl_name, " + 
     "          a.car_tag, " + 
     "          a.sex, " + 
     "          to_char(a.appl_date,'yyyy.mm.dd') appl_date " + 
     "   FROM p_emp_applicant  a " +
     " where a.employ_degree    = '" + arg_employ_degree   + "' "    ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>