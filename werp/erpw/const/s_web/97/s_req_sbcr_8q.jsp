<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("othercompany_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_othercompany_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("othercompany_construction",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("othercompany_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("othercompany_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("othercompany_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("year_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  sbcr_unq_num ," + 
					    "          othercompany_seq ," + 
					    "          othercompany_seq key_othercompany_seq," + 
					    "          owner ," + 
					    "          profession_wbs_name ," + 
					    "          othercompany_construction ," + 
					    "          to_char(othercompany_start_date,'YYYY.MM.DD') othercompany_start_date," + 
					    "          to_char(othercompany_end_date,'YYYY.MM.DD') othercompany_end_date ," + 
					    "          othercompany_amt ," + 
					    "          sale_amt ," + 
					    "          bigo ,year_class    " +
					    "     FROM s_req_const  " +
					    "    WHERE SBCR_UNQ_NUM = " + arg_unq_num +
					    " ORDER BY year_class,othercompany_seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>