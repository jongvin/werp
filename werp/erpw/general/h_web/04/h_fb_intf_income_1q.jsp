<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_from = req.getParameter("arg_from");
 String arg_to = req.getParameter("arg_to");
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
     dSet.addDataColumn(new GauceDataColumn("transfer_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ex_col1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_col4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ex_dt1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ex_dt2",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("fb_seq",GauceDataColumn.TB_DECIMAL,18,0));
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
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));

	  dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("v_account_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_ex_col1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("res_ex_col2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("res_ex_col3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("res_ex_col4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("res_ex_dt1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("res_ex_dt2",GauceDataColumn.TB_STRING,18));
    String query = "SELECT A.FB_SEQ, " + 
     "       A.FB_ACCOUNT_NUM, " + 
     "       A.FB_GUBUN_CD, " +
	  "       DECODE(a.fb_gubun_cd, '1', a.fb_cms, '2', a.fb_account_num, NULL) intf_code, "+
     "       A.FB_BANK_CD, " + 
     "       A.FB_RECV_AMT, " + 
     "       A.FB_REMAIN_AMT, " + 
     "       A.FB_ACCOUNT_NAME, " + 
     "       A.FB_CMS, " + 
     "       A.FB_RECV_DATE, " + 
     "       A.FB_RECV_TIME, " + 
     "       A.FB_DOCU_NUMC, " + 
     "       A.FB_JUMIN_NO, " + 
     "       to_char(A.TRANSFER_DATE, 'yyyy.mm.dd hh24:mi:ss') transfer_date," + 
     "       A.EX_COL1," + 
     "       A.EX_COL2," + 
     "       A.EX_COL3," + 
     "       A.EX_COL4," + 
     "       to_char(A.EX_DT1, 'yyyy.mm.dd') ex_dt1," + 
     "       to_char(A.EX_DT2, 'yyyy.mm.dd') ex_dt2," + 
     "       B.FB_SEQ, " + 
     "       to_char(B.APPLY_DATE, 'yyyy.mm.dd hh24:mi:ss') apply_date , " + 
     "       B.APPLY_OK, " + 
     "       B.ERROR_CODE, " + 
     "       B.ERROR_MSG, " + 
     "       to_char(B.MAN_APPLY_DATE, 'yyyy.mm.dd hh24:mi:ss') man_apply_date, " + 
     "       B.MAN_APPLY_OK, " + 
     "       B.MAN_ERROR_CODE, " + 
     "       B.MAN_ERROR_MSG, " + 
     "       B.MAN_NOTE, " + 
     "       B.DEPT_CODE, " + 
     "       B.SELL_CODE, " +
	  "      (SELECT LONG_NAME FROM H_CODE_DEPT WHERE DEPT_CODE = B.DEPT_CODE) long_name,   "+ 
     "      (SELECT code_name FROM h_code_common WHERE code_div = '03' AND code = b.sell_code) sell_name, "+
     "       B.DONGHO, " + 
     "       B.SEQ, " + 
	  "       (select c.cust_name from h_code_cust c, h_sale_master m where m.dept_code = b.dept_code  "+
	  "                    and m.sell_code = b.sell_code and m.dongho = b.dongho and m.seq = b.seq and m.cust_code = c.cust_code) cust_name, "+
     "       to_char(B.RECEIPT_DATE, 'yyyy.mm.dd') receipt_date, " + 
     "       B.DAILY_SEQ, " + 
     "       B.DEPOSIT_NO, " + 
     "       B.V_ACCOUNT_NO, " + 
     "       B.EX_COL1 res_ex_col1, " + 
     "       B.EX_COL2 res_ex_col2, " + 
     "       B.EX_COL3 res_ex_col3, " + 
     "       B.EX_COL4 res_ex_col4, " + 
     "       to_char(B.EX_DT1, 'yyyy.mm.dd') res_ex_dt1, " + 
     "       to_char(B.EX_DT2, 'yyyy.mm.dd') res_ex_dt2" + 
     "  FROM H_FB_INTF_INCOME a," + 
     "       H_FB_INTF_INCOME_RES b" + 
     " WHERE a.fb_seq = b.fb_seq(+)" + 
	  "   AND A.TRANSFER_DATE  BETWEEN  '" + arg_from + "' AND to_date('" + arg_to + "')+1"	+
     "  ORDER BY A.FB_SEQ     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>