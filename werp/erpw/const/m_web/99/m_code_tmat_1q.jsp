<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tmat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("key_tmat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.tmat_code ," + 
     "          a.tmat_code  key_tmat_code, " +
     "          a.name ," + 
     "          a.ssize ," + 
     "          a.unitcode ," + 
     "          a.bigo     FROM m_tmat_code a  ORDER BY a.tmat_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>