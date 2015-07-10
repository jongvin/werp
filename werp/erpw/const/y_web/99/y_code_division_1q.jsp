<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("division",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("division_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_division",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  y_code_division.division ," + 
     "          y_code_division.division_name,  " + 
     "          y_code_division.division key_division  " + 
     "         FROM y_code_division   " + 
     "    ORDER BY y_code_division.division          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>