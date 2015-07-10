<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rentamt",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT DEPT_CODE,   " + 
     "         MTRCODE,   " + 
     "         DITAG,   " + 
     "         NAME,   " + 
     "         SSIZE,   " + 
     "         UNITCODE,   " + 
     "         QTY,   " + 
     "         0       input_qty," +
     "         0       input_amt," +
     "         ''           comp_chk, " +
     "         trunc(amt /QTY,0) unitprice," + 
     "         AMT,   " + 
     "         RENTAMT  " + 
     "    FROM M_CURRSTOCK  " + 
     "   WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( QTY > 0 )      " +
     "  order by ditag asc, name asc   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>