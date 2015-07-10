<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_dept_name = req.getParameter("arg_dept_name");
     arg_dept_name = '%' + arg_dept_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("app_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("charge",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bill_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("prepayment",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deliverymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("deliverylimitdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("deliverycondition",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("check_method",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("appro_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("price_sup_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("price_rt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pre_pay_dat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_guar_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("as_guar_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("as_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("const_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark2",GauceDataColumn.TB_STRING,2000));
   String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.APPROYM,'YYYY.MM.DD') APPROYM,   " + 
     "         a.APPROSEQ,   " + 
     "         a.CHG_CNT,   " + 
     "         to_char(a.APPRODATE,'YYYY.MM.DD') APPRODATE,  " + 
     "         a.APPROTITLE,   " + 
     "         a.APP_TAG,   " + 
     "         a.CHARGE,   " + 
     "         a.VATTAG,   " + 
     "         a.AMT,   " + 
     "         a.VATAMT,   " + 
     "         a.CASH_RT,   " + 
     "         a.BILL_RT,   " + 
     "         a.PREPAYMENT,   " + 
     "         a.DELIVERYMETHOD,   " + 
     "         to_char(a.DELIVERYLIMITDATE,'YYYY.MM.DD')  DELIVERYLIMITDATE, " + 
     "         a.DELIVERYCONDITION,   " + 
     "         a.PAYMENTMETHOD,   " + 
     "         a.REMARK1,   " + 
     "         a.REQUESTSEQ,   " + 
     "         b.long_name, " +
     "         a.owner, " +
     "         a.check_method, " +
     "         a.approseq || '-' || a.chg_cnt appro_no, " +
     "         a.order_class, " +
     "         to_char(a.estimateyymm,'YYYY.MM.DD') estimateyymm, " +
     "         a.estimateseq ," +
     "         a.price_class, " +
     "         a.price_sup_class, " +
     "         a.price_rt ," +
     "         a.chg_class ," +
     "         a.pre_pay_dat," +
     "         a.const_guar_amt," +
     "         a.as_guar_amt," +
     "         a.as_term," +
     "         a.delay_amt, " +
     "         a.const_class, " +
     "         a.process_tag ," +
     "         a.const_no,a.remark2 " +
     "    FROM M_APPROVAL a ,  " + 
     "         z_code_dept  b " + 
     "   WHERE ( (a.dept_code = b.dept_code)   " + 
     "     and   (b.long_name like '" + arg_dept_name + "')    " + 
     "     and    (a.APPROYM >= '" + arg_date + "')   " + 
     "     and  (a.APPROYM <= '" + arg_to_date + "'))" +
     "     or  ( (a.dept_code = b.dept_code)  " + 
     "       and (b.long_name like '" + arg_dept_name + "') " + 
     "       and    (a.app_tag = '1' or a.app_tag = '2')  )   " + 
     " ORDER BY a.dept_code asc,a.APPROYM desc,a.APPROSEQ DESC,a.chg_cnt desc        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>