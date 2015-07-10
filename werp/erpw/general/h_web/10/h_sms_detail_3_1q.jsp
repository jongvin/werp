<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code= req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_no_seq = req.getParameter("arg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("h_sms_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sms_yn",GauceDataColumn.TB_STRING,0));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("email_yn",GauceDataColumn.TB_STRING,0));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
    String query = "        select " + arg_no_seq + " seq," + 
     "               h_sms_unq_num.nextval h_sms_unq_num," + 
     "               '3' tag," + 
     "               a.dept_code, " + 
     "               c.long_name," + 
     "               a.sell_code, " + 
     "               a.prize_dongho dongho, " + 
     "               to_char(a.pyong,'999999') pyong," + 
     "               b.cust_code, " + 
     "               b.cust_name, " + 
     "               to_char(a.prize_date,'yyyy.mm.dd') contract_date," + 
     "        	    ''  sms_yn, " + 
     "        	    b.cell_phone, " + 
     "        	    '' email_yn, " + 
     "        	    b.e_mail" + 
     "             from  h_subs_master a," + 
     "                   h_code_cust b," + 
     "                   h_code_dept c" + 
     "             where  a.prize_dongho is not null 	" + 
     "               and  a.preparation_order = 0 " + 
     "               and  a.cust_code  = b.cust_code      " + 
     "               and  a.dept_code  = '" + arg_dept_code + "'" + 
     "               and  a.dept_code  = c.dept_code (+) " + 
     "               and  a.sell_code  = '" + arg_sell_code + "'     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>