<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("holiday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("holiday_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_emp",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("update_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("update_emp",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  to_char(p_attend_holiday.holiday, 'YYYY.MM.DD') holiday ," + 
     "          p_attend_holiday.contents ," + 
     "          decode(p_attend_holiday.holiday_tag,'1','일','2','월','3','화','4','수','5','목','6','금','7','토','') holiday_tag," + 
     "          to_char(p_attend_holiday.input_date, 'YYYY.MM.DD') input_date ," + 
     "          p_attend_holiday.input_emp ," + 
     "          to_char(p_attend_holiday.update_date, 'YYYY.MM.DD') update_date ," + 
     "          p_attend_holiday.update_emp     FROM p_attend_holiday       " +
     "  where  trunc(to_date(p_attend_holiday.holiday), 'YYYY') = '" + arg_work_year + "'     " +
     " order by p_attend_holiday.holiday " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>