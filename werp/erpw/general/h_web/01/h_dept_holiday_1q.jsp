<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("delay_discount_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("process_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("process_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("old_delay_discount_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("old_yymmdd",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  h_dept_holiday.dept_code ," + 
     "          h_dept_holiday.sell_code ," + 
     "          h_dept_holiday.delay_discount_div ," + 
     "          to_char(h_dept_holiday.yymmdd,'yyyymmdd') yymmdd ," + 
     "          h_dept_holiday.process_days ," + 
     "          h_dept_holiday.process_div ," + 
     "          h_dept_holiday.remark, " + 
     "          h_dept_holiday.delay_discount_div old_delay_discount_div," + 
     "          to_char(h_dept_holiday.yymmdd,'yyyymmdd') old_yymmdd " + 
     "       FROM h_dept_holiday   " + 
     "       WHERE ( h_dept_holiday.dept_code = '" + arg_dept_code + "') and  " + 
     "        ( h_dept_holiday.sell_code = '" + arg_sell_code  + "')       " + 
     "        order by h_dept_holiday.delay_discount_div,h_dept_holiday.yymmdd     "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>