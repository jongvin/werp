<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
  
 String arg_deposit = req.getParameter("arg_deposit");


 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("fb_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fb_account_num",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("fb_gubun_cd",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("intf_code",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("fb_bank_cd",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fb_recv_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fb_remain_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fb_account_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("fb_cms",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("fb_recv_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("fb_recv_time",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("fb_docu_numc",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("fb_jumin_no",GauceDataColumn.TB_STRING,13));
	  dSet.addDataColumn(new GauceDataColumn("fb_loan_yn",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("fb_trade_gb",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("fb_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("transfer_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("apply_ok",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("error_msg",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("man_apply_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("man_apply_ok",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("man_error_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("man_error_msg",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("man_note",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("v_account_no",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("ex_col1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_dt1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ex_dt2",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("work_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT A.FB_SEQ, " + 
     "       A.FB_ACCOUNT_NUM, " + 
     "       a.fb_cms,DECODE(a.fb_gubun_cd, '1', DECODE(a.fb_cms, NULL, '3', '1'), A.FB_GUBUN_CD) FB_GUBUN_CD , " +
	  "       DECODE(a.fb_gubun_cd, '1', decode(a.fb_cms, null,a.fb_account_num, a.fb_cms) , '2', a.fb_account_num, NULL) intf_code, "+
     "       A.FB_BANK_CD, " + 
     "       A.FB_RECV_AMT, " + 
     "       A.FB_REMAIN_AMT, " + 
     "       A.FB_ACCOUNT_NAME, " + 
     "       A.FB_CMS, " + 
     "       A.FB_RECV_DATE, " + 
     "       A.FB_RECV_TIME, " + 
     "       A.FB_DOCU_NUMC, " + 
     "       A.FB_JUMIN_NO, " + 
	  "       A.FB_LOAN_YN, "+
	  "       a.fb_trade_gb, " + 
	  "       a.fb_dongho, " +
     "       to_char(A.TRANSFER_DATE, 'yyyy.mm.dd hh24:mi:ss') transfer_date," + 
     "       A.EX_COL1," + 
     "       A.EX_COL2," + 
     "       A.EX_COL3," + 
     "       A.EX_COL4," + 
     "       to_char(A.EX_DT1, 'yyyy.mm.dd') ex_dt1," + 
     "       to_char(A.EX_DT2, 'yyyy.mm.dd') ex_dt2," + 
     "       to_char(A.APPLY_DATE, 'yyyy.mm.dd hh24:mi:ss') apply_date , " + 
     "       A.APPLY_OK, " + 
     "       A.ERROR_CODE, " + 
     "       A.ERROR_MSG, " + 
     "       to_char(A.MAN_APPLY_DATE, 'yyyy.mm.dd hh24:mi:ss') man_apply_date, " + 
     "       A.MAN_APPLY_OK, " + 
     "       A.MAN_ERROR_CODE, " + 
     "       A.MAN_ERROR_MSG, " + 
     "       A.MAN_NOTE, " + 
     "       A.DEPT_CODE, " + 
     "       A.SELL_CODE, " +
	  "      (SELECT LONG_NAME FROM H_CODE_DEPT WHERE DEPT_CODE = A.DEPT_CODE) long_name,   "+ 
     "      (SELECT code_name FROM h_code_common WHERE code_div = '03' AND code = A.sell_code) sell_name, "+
     "       A.DONGHO, " + 
     "       A.SEQ, " +
	  "       (select c.cust_name from h_code_cust c, h_sale_master m where m.dept_code = a.dept_code  "+
	  "                    and m.sell_code = a.sell_code and m.dongho = a.dongho and m.seq = a.seq and m.cust_code = c.cust_code) cust_name, "+
     "       to_char(A.RECEIPT_DATE, 'yyyy.mm.dd') receipt_date, " + 
     "       A.DAILY_SEQ, " + 
     "       A.DEPOSIT_NO, " + 
     "       A.V_ACCOUNT_NO, " + 
     "       'F' chk, "+
	  "       work_seq "+
     "  FROM H_FB_INTF_INCOME a" + 
     " WHERE (A.apply_ok = 'N' OR A.APPLY_OK IS NULL) " +
	  "        and  a.fb_account_num like decode('"+ arg_deposit +"' , 'ALL', '%', '"+arg_deposit +"')"+
     "  ORDER BY A.FB_SEQ     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>