<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
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
     dSet.addDataColumn(new GauceDataColumn("invoice_num1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("send_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("nosend_reson",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pay_dt",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.dept_code,   " + 
    					 "         a.order_number,   " + 
    					 "         a.seq,   " + 
    					 "         a.guarantee_class,   " + 
    					 "         to_char(a.accept_dt,'yyyy.mm.dd') accept_dt,   " + 
    					 "         a.guarantee_number,   " + 
    					 "         a.guarantee_amt,   " + 
    					 "         a.guarantee_vat,   " + 
    					 "         to_char(a.guarantee_issueday,'yyyy.mm.dd') guarantee_issueday,   " + 
    					 "         to_char(a.guarantee_start_dt,'yyyy.mm.dd')  guarantee_start_dt,  " + 
    					 "         to_char(a.guarantee_end_dt,'yyyy.mm.dd') guarantee_end_dt,   " + 
    					 "         a.guarantee_kind,   " + 
    					 "         a.guarantee_sbcr,   " + 
    					 "         a.note,  " + 
    					 "         a.invoice_num, " +
    					 "         a.invoice_num1, " +
				       "         a.send_yn," +
				       "         a.nosend_reson, " +
     					 "         decode(a.guarantee_class,'2',decode(a.invoice_num,null,'A',F_T_SLIP_STAT(to_number(a.invoice_num))),'X') slip_st, " +
    					 "         to_char(a.pay_dt,'yyyy.mm.dd') pay_dt   " + 
    					 "    FROM s_guarantee_accept a " + 
    					 "   WHERE ( a.dept_code = '" + arg_dept_code + "') AND  " + 
    					 "         ( a.order_number = " + arg_order_number + ")         " + 
    					 "     ORDER BY a.seq " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>