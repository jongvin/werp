<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_no_seq = req.getParameter("arg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("h_sms_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sms_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("email_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.no_seq ," + 
     "          a.h_sms_unq_num ," + 
     "          a.tag ," + 
     "          a.dept_code ," + 
     "          b.long_name ," + 
     "          a.sell_code ," + 
     "          a.dongho ," + 
     "          a.pyong ," + 
     "          a.cust_code ," + 
     "          a.cust_name ," + 
     "          to_char(a.contract_date,'yyyy.mm.dd') contract_date ," + 
     "          a.sms_yn ," + 
     "          a.cell_phone ," + 
     "          a.email_yn ," + 
     "          a.e_mail  " + 
     "      FROM h_sms_detail a, h_code_dept b  " + 
     "      WHERE ( a.no_seq = " + arg_no_seq  + ") " + 
     "        and a.dept_code = b.dept_code (+) " + 
     "      ORDER BY a.tag          ASC," + 
     "          a.dept_code          ASC," + 
     "          a.sell_code          ASC," + 
     "          a.dongho          ASC," + 
     "          a.pyong          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>