<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_sell_code = req.getParameter("as_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("porch",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom6",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom7",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom8",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom9",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bedroom10",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("restroom1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("restroom2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("etc_key",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("out_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_1",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("key_2",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code," + 
     "	   a.sell_code," + 
     "	   a.dongho," + 
     "	   nvl(a.seq, 0) seq," + 
     "	   decode(a.porch, 'Y', 'T', 'F') porch," + 
     "	   decode(a.bedroom1, 'Y', 'T', 'F') bedroom1," + 
     "	   decode(a.bedroom2, 'Y', 'T', 'F') bedroom2," + 
     "	   decode(a.bedroom3, 'Y', 'T', 'F') bedroom3," + 
     "	   decode(a.bedroom4, 'Y', 'T', 'F') bedroom4," + 
     "	   decode(a.bedroom5, 'Y', 'T', 'F') bedroom5," + 
     "	   decode(a.bedroom6, 'Y', 'T', 'F') bedroom6," + 
     "	   decode(a.bedroom7, 'Y', 'T', 'F') bedroom7," + 
     "	   decode(a.bedroom8, 'Y', 'T', 'F') bedroom8," + 
     "	   decode(a.bedroom9, 'Y', 'T', 'F') bedroom9," + 
     "	   decode(a.bedroom10, 'Y', 'T', 'F') bedroom10," + 
     "	   decode(a.restroom1, 'Y', 'T', 'F') restroom1," + 
     "	   decode(a.restroom2, 'Y', 'T', 'F') restroom2," + 
     "	   decode(a.etc_key, 'Y', 'T', 'F') etc_key," + 
     "	   to_char(a.out_date, 'yyyy.mm.dd') out_date," + 
     "	   a.remark," + 
     "      c.cust_name," + 
     "      a.dongho key_1," +
     "      a.seq    key_2"  +
     "  from h_sale_key    a," + 
     "       h_sale_master b," + 
     "	   h_code_cust   c" + 
     " where a.dept_code = b.dept_code" + 
     "   and a.sell_code = b.sell_code " + 
     "   and a.dongho    = b.dongho" + 
     "   and a.seq       = b.seq" + 
     "   and b.cust_code = c.cust_code" + 
     "   and a.dept_code = '" + as_dept_code + "'" + 
     "   and a.sell_code = '" + as_sell_code +    "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>