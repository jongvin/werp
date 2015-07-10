<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contract_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("t_cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("house_type",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("vat_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("real_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_status",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') key_contract_date,   " + 
     "                       a.CONTRACT_DIV,   " + 
     "              			  a.CUST_CODE," + 
     "                       decode(b.cust_div,'01',substrb(a.CUST_CODE,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5)) t_cust_code,   " + 
     "                       a.HOUSE_TYPE,   " + 
     "                       a.vat_yn, " +
     "                       a.GUARANTEE_AMT,   " + 
     "                       a.lease_supply,   " + 
     "                       a.lease_vat,   " + 
     "                       to_char(a.S_DATE,'YYYY.MM.DD') s_date,   " + 
     "                       to_char(a.E_DATE,'YYYY.MM.DD') e_date,   " + 
     "                       to_char(a.MOVEINTO_DATE,'YYYY.MM.DD') moveinto_date," + 
     "							  a.real_name, " +
     "              			  b.cust_name,  " + 
     "                       'N'       chk_status " +
     "                  FROM H_LEAS_MASTER  a," + 
     "              			  H_CODE_CUST b" + 
     "                 WHERE a.cust_code = b.cust_code (+)" + 
     "              	    AND a.DEPT_CODE = '" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = '" + arg_sell_code + "'" + 
     "                   AND a.DONGHO = '" + arg_dongho + "'" + 
     "                   AND a.SEQ = '" + arg_seq  + "'" + 
     "              ORDER BY a.CONTRACT_DATE DESC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>