<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_compcode = req.getParameter("arg_compcode") + "%" ;
     String arg_year = req.getParameter("arg_year");
     String arg_orderno = "%" + req.getParameter("arg_orderno") + "%" ;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("decision_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("send_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_office",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.order_no,   " + 
     "         to_char(a.input_date,'yyyy.mm.dd') input_date,   " + 
     "         a.comp_code,   " + 
     "         a.order_title,   " + 
     "         to_char(a.decision_date,'yyyy.mm.dd') decision_date,   " + 
     "         to_char(a.send_date,'yyyy.mm.dd') send_date,   " + 
     "         a.order_office  " + 
     "    FROM p_order_paperno   a" + 
     "	where a.comp_code like '" + arg_compcode + "' " + 
     "	  and trunc(a.input_date,'year')   = '" + arg_year + "' " + 
     "	  and (a.order_no    like '" + arg_orderno + "' " + 
     "		or  a.order_title like '" + arg_orderno + "' )     " +
     "  order by a.order_no desc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>