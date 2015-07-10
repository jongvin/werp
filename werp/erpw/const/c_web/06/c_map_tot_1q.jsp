<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_homeforeign_tag1 = req.getParameter("arg_homeforeign_tag1");
     String arg_homeforeign_tag2 = req.getParameter("arg_homeforeign_tag2");
     String arg_homeforeign_tag3 = req.getParameter("arg_homeforeign_tag3");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  z_code_dept.dept_code ," + 
     "          z_code_dept.comp_code ," + 
     "          z_code_dept.long_name ," + 
     "          z_code_dept.proj_pos ," + 
     "          z_code_dept.proj_charge ," + 
     "          to_char(z_code_dept.chg_const_start_date,'YYYY.MM.DD') chg_const_start_date ," + 
     "          to_char(z_code_dept.chg_const_end_date,'YYYY.MM.DD')  chg_const_end_date," + 
     "          y_region_code.name name ," + 
     "          z_code_dept.process_code " + 
     "      FROM z_code_dept ," + 
     "          y_region_code   " + 
     "      WHERE ( z_code_dept.region_code = y_region_code.region_code (+)) and " + 
     "            ( z_code_dept.dept_proj_tag = 'P' )       "  + 
     "       ORDER BY  z_code_dept.long_name      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>