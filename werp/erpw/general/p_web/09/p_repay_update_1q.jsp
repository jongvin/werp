<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_repay_date = req.getParameter("arg_repay_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("repay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("repay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("interest_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_last_repay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("b_loan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("b_loan_amt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("b_interest",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("b_loan_rem",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_repay_yn",GauceDataColumn.TB_STRING,1));
    String query =   "	SELECT  			" +
	"               a.spec_no_seq ,                                          " +
	"               to_char(a.repay_date, 'YYYY.MM.DD') repay_date ,         " +
	"               a.repay_amt ,                                            " +
	"               a.interest_amt ,                                         " +
	"               a.remark     ,                                           " +
	"              b.spec_no_seq b_spec_no_seq,                                          " +
	"	       to_char(b.LAST_REPAY_DATE, 'YYYY.MM.DD') b_last_repay_date,     " +
	"	       to_char(b.LOAN_DATE, 'YYYY.MM.DD') b_loan_date,                 " +
	"	       b.loan_amt b_loan_amt,                                   " +
	"	       b.INTEREST b_interest,                                   " +
	"	       b.LOAN_REM b_loan_rem,                                    " +
	"	       b.repay_yn b_repay_yn                                    " +
	"	FROM p_gen_repay a, p_gen_loan b                                " +
	"   where b.repay_yn = '1'		                                  	" +		// 상환중인것
	"     and b.repay_method   = '2' 	         							" +		// 분할상환인것
	"     and a.spec_no_seq (+) = b.spec_no_seq                               " +
	"     and trunc(b.loan_date,'mm')        <= trunc(to_date('" + arg_repay_date + "'),'mm')    " +              
	"     and trunc(b.last_repay_date,'mm')  >= trunc(to_date('" + arg_repay_date + "'),'mm')	  " +
	"     and a.repay_date (+) = '1900.01.01' 	         " +
	"   ORDER BY a.repay_date                                                  " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>