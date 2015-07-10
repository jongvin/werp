<%@ page session="true" 	  contentType="text/html;charset=EUC_KR"   import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("loan_yn",GauceDataColumn.TB_STRING,1,0));
	 dSet.addDataColumn(new GauceDataColumn("loan_date",GauceDataColumn.TB_STRING,18,0));
	 dSet.addDataColumn(new GauceDataColumn("loan_interest_tag",GauceDataColumn.TB_STRING,2,0));
	 dSet.addDataColumn(new GauceDataColumn("loan_bank_code",GauceDataColumn.TB_STRING,8,0));
	 dSet.addDataColumn(new GauceDataColumn("loan_rdm_yn",GauceDataColumn.TB_STRING,1,0));
	 dSet.addDataColumn(new GauceDataColumn("prt_tax",GauceDataColumn.TB_STRING,4));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       a.DEGREE_CODE  key_degree_code,   " + 
     "                 		  b.code_name," + 
     "                       to_char(a.AGREE_DATE,'YYYY.MM.DD') agree_date, " + 
     "                       nvl(a.LAND_AMT,0)  land_amt,   " + 
     "                       nvl(a.BUILD_AMT,0) build_amt,   " + 
     "                       nvl(a.VAT_AMT,0) vat_amt,   " + 
     "                       nvl(a.SELL_AMT,0) sell_amt,   " + 
     "                       a.F_PAY_YN,   " + 
     "                       nvl(a.TOT_AMT,0) tot_amt,   " + 
     "                       to_char(a.WORK_DATE,'YYYY.MM.DD') work_date,   " + 
     "                       nvl(a.WORK_NO,0) work_no,  " +
	 "                       a.loan_yn, "+
     "                       to_char(a.loan_date,'yyyy.mm.dd') loan_date, "+
	 "                       a.loan_interest_tag, "+
	 "                       a.loan_bank_code, "+
	 "                        a.loan_rdm_yn, "+
	 "                         decode(a.work_no, null, '', '출력')  prt_tax "+
     "                  FROM H_SALE_AGREE  a ," + 
     "              			  h_code_common b" + 
     "                 WHERE a.degree_code = b.code (+)" + 
     "              	  and b.code_div = '02'" + 
     "              	  and a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   and a.DONGHO = " + "'" + arg_dongho + "'" + 
     "                   and a.SEQ = " + "'" + arg_seq + "'" + 
     "              ORDER BY a.DEGREE_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>