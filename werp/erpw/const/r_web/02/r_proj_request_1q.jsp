<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_position",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("const_from",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_to",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("parent_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_name2",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.receive_code,   " + 
     "         a.NAME,   " + 
     "         a.CONST_POSITION,   " + 
     "         a.PQ_TAG,   " + 
     "         to_char(a.CONST_FROM,'YYYY.MM.DD')  CONST_FROM, " + 
     "         to_char(a.CONST_TO,'YYYY.MM.DD')   CONST_TO, " + 
     "         a.DEPT_CODE,   " + 
     "         a.PARENT_DEPT_CODE,   " + 
     "         a.APPROVE_CLASS,   " + 
     "		b.order_name," + 
     "		c.order_name    order_name2 " + 
     "    FROM r_receive_code  a," + 
     "		r_code_order b," + 
     "		r_code_order c" + 
     "   WHERE a.order_no = b.order_no (+)" + 
     "	  and a.order_no1 = c.order_no (+)" + 
     "	  and a.approve_class = " + "'" + arg_class + "'" + 
     "order by a.receive_code desc                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>