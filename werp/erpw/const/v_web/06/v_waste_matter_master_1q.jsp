<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("waste_matter_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_waste_matter_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("waste_matter_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("key_waste_matter_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.dept_code,														" + 
     "                       a.waste_matter_code,											" + 
     "                       a.waste_matter_code key_waste_matter_code,				" + 
     "                       a.waste_matter_name, 											" +       
     "                       a.waste_matter_name key_waste_matter_name				" +  
     "                  FROM v_waste_matter_master a 										" +  
     "                 WHERE a.dept_code='" + arg_dept_code + "'						" +
     "              ORDER BY a.dept_code ASC,												" + 
     "                       a.waste_matter_code ASC         							";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>