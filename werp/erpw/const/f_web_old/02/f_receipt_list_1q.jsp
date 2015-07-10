<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("nopay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("susi_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("jung_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT																			" + 
	"			yymm,             																		" + 
	"			nopay_amt, 			                                                      " + // 미지급청구
	"			susi_amt, 			                                                      " + // 예비비청구(수시)
	"			jung_amt, 			                                                      " + // 예비비청구(정기)
	"			receipt_amt,		                                                      " + // 예비비정산액
	"			profit_amt,			                                                      " + // 수익금
   "        sum(amt)	 over (order by yymm) amt													" + // 잔액누계
	"		FROM ( SELECT                                                              " + 
	"			substr(yymm,1,4) || '년 ' || substr(yymm,6,2) || '월' yymm,             " + 
	"			sum(decode(tag,'1',amt,0)) nopay_amt, 			                           " + // 미지급청구
	"			sum(decode(tag,'2',amt,0)) susi_amt, 			                           " + // 예비비청구(수시)
	"			sum(decode(tag,'3',amt,0)) jung_amt, 			                           " + // 예비비청구(정기)
	"			sum(decode(tag,'4',amt,0)) receipt_amt,		                           " + // 예비비정산액
	"			sum(decode(tag,'5',amt,0)) profit_amt,			                           " + // 수익금
	"        nvl(sum(decode(tag,'2',amt,0)),0) + 												" +		
	"			nvl(lag(sum(decode(tag,'3',amt,0)),1) over (order by yymm),0) -         " +
	"			nvl(sum(decode(tag,'4',amt,0)),0) +													" +	 
	"			nvl(sum(decode(tag,'5',amt,0)),0)  amt       									" + 
	"		FROM                                                                       " + 
	"		(                                                                          " + 
	"		select '1' tag, to_char(request_date,'yyyy.mm') yymm,                      " + 
	"				sum(nvl(amt,0)+nvl(vat,0)) amt                                       " + 
	"		from f_nopay_request                                                 		" + // 미지급청구 
	"		where dept_code='" + arg_dept + "'                                      	" + 
	"		and to_char(request_date,'yyyy.mm') <= '" + arg_yymm + "'               	" + 
	"		group by to_char(request_date,'yyyy.mm')                                	" + 
	"		                                                                        	" + 
	"		UNION ALL                                                               	" + 
	"		                                                                        	" + 
	"		select '2' tag, to_char(request_date,'yyyy.mm') yymm,                   	" + 
	"				sum(decode(class,1,nvl(cash_amt,0)+nvl(bill_amt,0))) amt             " + 
	"		from f_preamt_request                                                  		" + // 예비비청구(수시)
	"		where dept_code='" + arg_dept + "'                                      	" + 
	"		and to_char(request_date,'yyyy.mm') <= '" + arg_yymm + "'               	" + 
	"		group by to_char(request_date,'yyyy.mm')                                	" + 
	"		                                                                        	" + 
	"		UNION ALL                                                               	" + 
	"		                                                                        	" + 
	"		select '3' tag, to_char(request_date,'yyyy.mm') yymm,                   	" + 
	"				sum(decode(class,2,nvl(cash_amt,0)+nvl(bill_amt,0))) amt             " + 
	"		from f_preamt_request                                                  		" + // 예비비청구(정기)
	"		where dept_code='" + arg_dept + "'                                         " + 
	"		and to_char(request_date,'yyyy.mm') <= '" + arg_yymm + "'                  " + 
	"		group by to_char(request_date,'yyyy.mm')                                   " + 
	"		                                                                           " + 
	"		UNION ALL                                                                  " + 
	"		                                                                           " + 
	"		select '4' tag, to_char(rqst_date,'yyyy.mm') yymm,                         " + 
	"				sum(decode(cr_class,1,nvl(amt,0)+nvl(vat,0)-nvl(profit_amt,0),       " +
	"											 nvl(profit_amt,0)-nvl(amt,0)-nvl(vat,0))) amt  " + 
	"		from f_request                                                 				" + // 예비비정산액
	"		where dept_code='" + arg_dept + "'                             				" + 
	"		and to_char(rqst_date,'yyyy.mm') <= '" + arg_yymm + "'         				" + 
	"		group by to_char(rqst_date,'yyyy.mm')                          				" + 
	"		                                                               				" + 
	"		UNION ALL                                                                  " + 
	"		                                                                           " + 
	"		select '5' tag, to_char(inst_date,'yyyy.mm') yymm,                         " + 
	"				sum(nvl(amt,0)+nvl(vat,0)) amt                                       " + 
	"		from f_profit_detail                                                  		" + // 수익금
	"		where dept_code='" + arg_dept + "'                                         " + 
	"		and to_char(inst_date,'yyyy.mm') <= '" + arg_yymm + "'                     " + 
	"		group by to_char(inst_date,'yyyy.mm')                                      " + 
	"		)                                                                          " + 
	"		group by yymm  )                                                           " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>