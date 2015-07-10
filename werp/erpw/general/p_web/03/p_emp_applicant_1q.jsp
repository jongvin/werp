<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_degree = req.getParameter("arg_degree");
     String arg_appl_no = req.getParameter("arg_appl_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("apply_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("birth_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("age",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tel_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.employ_degree ," + 
     "          a.appl_no ," + 
     "          a.apply_code ," + 
     "          a.appl_name ," + 
     "          a.appl_part ," + 
     "          a.birth_date ," + 
     "          a.age ," + 
     "          a.sex ," + 
     "          a.tel_no ," + 
     "          a.addr     FROM p_emp_applicant a, p_emp_degree b " +
     "   where a.employ_degree = b.employ_degree " +
     "     and a.employ_degree = '" + arg_degree + "' " +
     "     and a.appl_no = '" + arg_appl_no + "'         ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>