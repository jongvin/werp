<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_shortname",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("survey_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tender_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_position",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.RECEIVE_CODE,   " + 
     "                       a.NAME,   " + 
     "                       a.CONST_SHORTNAME,   " + 
     "                       a.ORDER_NO,   " + 
     "                 		  b.order_name," + 
     "                       a.REGION_CODE, " + 
     "            	  		  c.name          region_name,  " + 
     "                       a.survey_amt, " +
     "                       to_char(a.tender_date,'YYYY.MM.DD') tender_date, " +
     "                       a.CONST_POSITION   " + 
     "                  FROM r_receive_code  a," + 
     "            	  		  r_code_order b," + 
     "             	  		  y_region_code c" + 
     "                 WHERE a.order_no = b.order_no (+)" + 
     "            	    and a.region_code = c.region_code (+)" + 
     "                   and a.name Like " + "'" + arg_name + "'" +
     "              order by a.receive_code desc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>