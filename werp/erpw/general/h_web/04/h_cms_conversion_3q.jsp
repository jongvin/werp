<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("receipt_seq",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("receipt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("receipt_class_code",GauceDataColumn.TB_STRING,4));
     String query = "  SELECT ''dongho,''receipt_date,0 receipt_seq,0 receipt_amt,'' receipt_code,''deposit_no,''receipt_class_code " +
     "                  FROM dual ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>