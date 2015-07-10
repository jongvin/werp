<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("regist_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("monthly_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_bill",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("payterm",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_regist_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("eqp_vender_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bill_day",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.YYMM,'YYYY.MM.DD') yymm,   " + 
     "         decode(b.cust_type,'1',substrb(a.REGIST_NO,1,3) || '-' || substrb(a.regist_no,4,2) || '-' || substrb(a.regist_no,6,5),decode(b.cust_type,'2',substrb(a.regist_no,1,6) || '-' || substrb(a.regist_no,7,7),a.regist_no)) regist_no, " + 
     "         a.MONTHLY_AMT,   " + 
     "         a.VAT,   " + 
     "         a.MONTHLY_AMT + a.VAT comp_amt," +
     "         a.PAY_CASH,   " + 
     "         a.PAY_BILL,   " + 
     "         a.PAYTERM,   " + 
     "         a.REMARK,   " + 
     "         a.regist_no key_regist_no,   " + 
     "         b.EQP_VENDER_NAME , " + 
     "         a.bill_day, " +
     "         a.invoice_num, " +
     "          decode(a.invoice_num,null,'A',F_T_SLIP_STAT(to_number(a.invoice_num))) slip_st " +
     "    FROM Q_MONTHLY_PAYMENT a,   " + 
     "         Q_CODE_EQP_VENDER b " + 
     "   WHERE ( a.REGIST_NO = b.REGIST_NO ) and  " + 
     "         ( ( a.DEPT_CODE = " + "'" + arg_dept + "'" + " ) AND  " + 
     "         ( to_char(a.YYMM,'yyyy.mm') = " + "'" + arg_date  + "'" + ") )         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>