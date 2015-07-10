<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prgs_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,8,0));
     dSet.addDataColumn(new GauceDataColumn("web_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("check_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("slipseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_pay",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_bill",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT B.SBCR_NAME,   " + 
     "         a.SBC_NAME,   " + 
     "         a.order_number,   " + 
     "         to_char(c.YYMM,'YYYY.MM.DD') yymm,   " + 
     "         c.PRGS_DEGREE,   " + 
     "         to_char(a.START_DT,'YYYY.MM.DD')  START_DT,  " + 
     "         to_char(a.END_DT,'YYYY.MM.DD') END_DT,  " + 
     "         a.dept_code,  " + 
     "         c.seq,  " + 
     "         c.web_yn, " +
     "         to_char(c.check_dt,'YYYY.MM.DD') check_dt, " +
     "         to_char(c.pay_dt,'YYYY.MM.DD') pay_dt, " +
     "         c.slipseq ," +
     "         c.tm_pay + (c.tm_vat - c.tm_pre_vat) tm_pay, " +
     "         c.tm_cash, " +
     "         c.tm_bill " +
     "    FROM s_sbcr B,   " + 
     "         S_CN_LIST a,   " + 
     "         S_PAY  c, " +
     "         s_account_process d " +
     "   WHERE d.corp_reg_no = b.sbcr_code " + 
     "     and d.DEPT_CODE   = a.DEPT_CODE  " + 
     "     and d.cst_doc_no  = a.ORDER_NUMBER  " + 
     "     and d.inv_id      = c.slipseq " +
     "     and d.DEPT_CODE   = '" + arg_dept_code + "'" + 
     "     and d.PROC_GB     = '2' " +
     "order by c.YYMM desc" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>