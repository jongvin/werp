<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
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
     dSet.addDataColumn(new GauceDataColumn("contract_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("t_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("house_type",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("vat_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("lease_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT A.DEPT_CODE,   " + 
     "                       A.SELL_CODE,   " + 
     "                       A.DONGHO,   " + 
     "                       A.SEQ,   " + 
     "                       to_char(A.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
	  "                       A.CONTRACT_DIV, " +
     "                       decode(b.cust_div,'01',substr(a.cust_code,1,6) || '-' || substr(a.cust_code,7,7),substr(a.cust_code,1,3) || '-' || substr(a.cust_code,4,2) || '-' || substr(a.cust_code,6,5)) t_cust_code,   " + 
     "                       A.CUST_CODE,   " + 
     "                       A.HOUSE_TYPE,   " + 
     "                       A.GUARANTEE_AMT,   " + 
     "                       to_char(A.S_DATE,'YYYY.MM.DD') s_date,   " + 
     "                       to_char(A.E_DATE,'YYYY.MM.DD') e_date,   " + 
     "                       to_char(A.MOVEINTO_DATE,'YYYY.MM.DD') moveinto_date,   " + 
     "                       B.CUST_NAME,   " + 
     "                       A.VAT_YN,   " + 
     "                       A.LEASE_SUPPLY,   " + 
     "                       A.LEASE_VAT,  " + 
     "                       A.real_name " +
     "                  FROM H_LEAS_MASTER A,   " + 
     "                       H_CODE_CUST B  " + 
     "                 WHERE A.CUST_CODE = B.CUST_CODE (+)   " + 
     "              	  AND a.dept_code = '" + arg_dept_code + "'" + 
     "              	  AND a.sell_code = '" + arg_sell_code + "'" + 
     "              	  AND a.dongho    = '" + arg_dongho + "'" + 
     "                 AND a.seq       = '" + arg_seq + "'" + 
     "              ORDER BY A.CONTRACT_DATE DESC     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>
