<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,20));
    String query = "  select school_car_code select_1 ," + 
     "          school_car_name select_2  from p_code_school_car order by school_car_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>
