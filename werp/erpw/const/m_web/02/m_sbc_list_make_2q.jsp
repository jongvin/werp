<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
     String arg_chg = req.getParameter("arg_chg");
     String arg_sbcr = req.getParameter("arg_sbcr");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("accept_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_number",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_issueday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_kind",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("guarantee_sbcr",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("send_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("nosend_reson",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  dept_code ," + 
     					 "          to_char(approym,'YYYY.MM.DD') approym ," + 
     					 "          approseq ," + 
     					 "          chg_cnt ," + 
     					 "          sbcr_code ," + 
     					 "          seq ," + 
     					 "          guarantee_class ," + 
     					 "          to_char(accept_dt,'YYYY.MM.DD') accept_dt ," + 
     					 "          guarantee_number ," + 
     					 "          guarantee_amt ," + 
     					 "          guarantee_vat ," + 
     					 "          to_char(guarantee_issueday,'YYYY.MM.DD') guarantee_issueday," + 
     					 "          to_char(guarantee_start_dt,'YYYY.MM.DD') guarantee_start_dt," + 
     					 "          to_char(guarantee_end_dt,'YYYY.MM.DD') guarantee_end_dt," + 
     					 "          guarantee_kind ," + 
     					 "          guarantee_sbcr ," + 
     					 "          note ," + 
     					 "          invoice_num ," + 
     					 "          send_yn ," + 
     					 "          nosend_reson " +
     					 "     FROM m_guarantee " +
     					 "    WHERE DEPT_CODE = '" + arg_dept + "'" +
     					 "      and APPROYM = '" + arg_date + "'" +
     					 "      And APPROSEQ = " + arg_seq +
     					 "      And CHG_CNT =  " + arg_chg +
     					 "      And SBCR_CODE = '" + arg_sbcr + "'" +
     					 "  ORDER BY seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>