<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("receive_date",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_class",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("remarks",GauceDataColumn.TB_STRING,15));
    String query = "  SELECT  " + 
     "          ' '  dongho, " + 
     "          '1000.01.01' receive_date, " + 
     "          0 amt, " + 
     "          ' ' input_class, " + 
     "          ' ' deposit_no, " + 
     "          0 seq, " + 
     "          ' '  contract_date, " + 
     "          ' '  cust_code, " + 
     "          ' '  cust_name, " + 
     "          ' ' remarks " + 
     "            from dual  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>