<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_progress_cnt = req.getParameter("arg_progress_cnt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("progress_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("accept_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("accept_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("accept_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  c_progress_amt_detail.dept_code ," + 
     "          c_progress_amt_detail.progress_cnt ," + 
     "          c_progress_amt_detail.no_seq ," + 
     "          to_char(c_progress_amt_detail.accept_date,'yyyy.mm.dd') accept_date ," + 
     "          c_progress_amt_detail.accept_amt ," + 
     "          c_progress_amt_detail.accept_vat ," + 
     "          c_progress_amt_detail.bigo  " + 
     "        FROM c_progress_amt_detail   " + 
     "       WHERE ( c_progress_amt_detail.dept_code = '" + arg_dept_code + "') " + 
     "         and ( c_progress_amt_detail.progress_cnt = " + arg_progress_cnt + ") " + 
     "       order by c_progress_amt_detail.no_seq,c_progress_amt_detail.accept_date ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>