<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vender_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("gubun",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_user_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  user_code ," + 
     "          password ," + 
     "          sbcr_code, " +
     "          vender_code, " +
     "          businessman_number ," + 
     "          gubun ," + 
     "          note ," + 
     "          user_code comp_user_code,  " + 
     "          sbcr_name   " + 
     "    FROM z_webuser_code   " +   
     "      ORDER BY z_webuser_code.user_code          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>