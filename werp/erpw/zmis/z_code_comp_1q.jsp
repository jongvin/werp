<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("comp_addr",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("comp_owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("business_number",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("uptae",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("upjong",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  comp_code ," + 
     "          comp_name,   " +
     "          comp_addr,   " +
     "          comp_owner,   " +
     "          business_number, " +
     "          uptae, " +
     "          upjong " +
     "     FROM z_code_comp   order by  comp_code    ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>