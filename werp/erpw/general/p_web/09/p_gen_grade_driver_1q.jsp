<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("driver_amt",GauceDataColumn.TB_DECIMAL,12,0));
     dSet.addDataColumn(new GauceDataColumn("parking_amt",GauceDataColumn.TB_DECIMAL,12,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  to_char(p_gen_grade_driver.work_yymm, 'YYYY.MM.DD') work_yymm , " + 
     "          p_gen_grade_driver.grade_code ," + 
     "          p_gen_grade_driver.comp_code ," + 
     "          p_gen_grade_driver.driver_amt ," + 
     "          p_gen_grade_driver.parking_amt ," + 
     "          p_gen_grade_driver.remark, " +
     "			 'Y' ret_tag " +
     "     FROM p_gen_grade_driver " +  
     "  where  p_gen_grade_driver.work_yymm = '" + arg_work_yymm + "'     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>