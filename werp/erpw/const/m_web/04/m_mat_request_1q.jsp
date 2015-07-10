<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("kind_bussinesstype",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("kinditem",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acnt_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("yyyymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamount",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("codetag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("acnt_status",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("acnt_workdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paycondition",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("work_process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("inv_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.dept_code ," + 
     					 "          a.sbcr_code ," + 
					    "          decode(length(b.businessman_number),10,substrb(b.businessman_number,1,3) || '-' || substrb(b.businessman_number,4,2) || '-' || substrb(b.businessman_number,6,5),substrb(b.businessman_number,1,6) || '-' || substrb(b.businessman_number,7,7)) cust_code, " +
					    "          b.rep_name1, " +
					    "          b.address1," +
					    "          b.kind_bussinesstype, " +
					    "          b.kinditem ," +
     					 "          a.vat_unq_num, " +
     					 "          to_char(a.work_dt,'YYYY.MM.DD') work_dt ," + 
     					 "          a.acnt_code ," + 
     					 "          a.vatcode ," + 
     					 "          to_char(a.yyyymmdd,'YYYY.MM.DD') yyyymmdd ," + 
     					 "          a.amt ," + 
     					 "          a.vatamount ," + 
     					 "          a.cont ," + 
     					 "          a.codetag ," + 
     					 "          a.acnt_status ," + 
     					 "          a.acnt_workdate ," + 
     					 "          a.wbs_code ," + 
     					 "          a.paycondition ," + 
     					 "          a.spec_unq_num ," + 
     					 "          a.cash_amt ," + 
     					 "          a.bill_amt, " +
     					 "          b.sbcr_name ," +
     					 "          to_char(a.approym,'YYYY.MM.DD') approym," +
     					 "          a.approseq, " +
     					 "          a.chg_cnt," +
     					 "          a.invoice_num, " +
     					 "          a.work_process ," +
     					 "          a.inv_id,a.bill_day,a.ditag, " +
     					 "          decode(a.invoice_num,null,'A',F_T_SLIP_STAT(to_number(a.invoice_num))) slip_st ,a.process_tag" +
     					 "     FROM m_vat  a,  " +
     					 "          s_sbcr b " +
     					 "    WHERE a.sbcr_code = b.sbcr_code " +
     					 "      And a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      And trunc(a.yyyymmdd,'MM') = '" + arg_date + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>