<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("p_estate",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_estate",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("live_type_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("house_type_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("plottage",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("floor_space",GauceDataColumn.TB_DECIMAL,18,4));
     dSet.addDataColumn(new GauceDataColumn("room_count",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  p_pers_wealth.emp_no ," + 
     "          p_pers_wealth.p_estate ," + 
     "          p_pers_wealth.r_estate ," + 
     "          p_pers_wealth.live_type_code ," + 
     "          p_pers_wealth.house_type_code ," + 
     "          p_pers_wealth.plottage ," + 
     "          p_pers_wealth.floor_space ," + 
     "          p_pers_wealth.room_count     FROM p_pers_wealth        " +
     "   where p_pers_wealth.emp_no = '" + arg_emp_no   + "'    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>