<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("seq_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("subs_order",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("reg_no",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("subs_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("phone",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("bank",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_data",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("error_data_message",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  " +
	  "           unq_no , "+
     "            dept_code, " + 
     "            sell_code, " + 
     "            cust_code, " + 
     "            cust_name, " + 
     "            seq_no, " + 
     "            subs_order, " + 
     "            reg_no, " + 
     "            subs_date, " + 
     "            dong, " + 
     "            ho, " + 
     "            phone, " + 
     "            bank, " + 
     "            process, " + 
     "            error_process, " + 
     "            error_data, " + 
     "            error_data_message " + 
     "            from h_subs_reg_batch  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>