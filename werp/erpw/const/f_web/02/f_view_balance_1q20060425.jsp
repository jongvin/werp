<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_month = req.getParameter("arg_month");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mnth",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("out_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_bal",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select std.mnth,"   +
"        b.amt in_amt,"   +
" 			 a.amt  out_amt,"   +
" 			 pre_in.amt - pre_out.amt pre_bal"   +
"   from (select distinct mnth mnth"   +
" 	        from ( select distinct to_char(rqst_date,'yyyy.mm') mnth"   +
" 					        from f_request  "   +
" 							 where dept_code = '"+arg_dept_code+"'"   +
" 							   and to_char(rqst_date,'yyyy.mm') <= '"+arg_month+"'"   +
"								and fund_type  in('2','4') "+
" 						  union all "   +
" 					     select distinct to_char(receive_date,'yyyy.mm') mnth"   +
" 					       from f_receive_amt "   +
" 							where dept_code = '"+arg_dept_code+"'"   +
" 							  and to_char(receive_date,'yyyy.mm') <= '"+arg_month+"' "   +
" 						)"   +
"     	 ) std,"   +
" 			 (select to_char(a.rqst_date,'yyyy.mm') mnth,"   +
" 			         sum(nvl(a.amt,0)) amt"   +
" 			    from f_request a"   +
" 				where a.dept_code = '"+arg_dept_code+"'"   +
" 				  and to_char(a.rqst_date,'yyyy.mm') <= '"+arg_month+"'"   +
"								and a.fund_type  in('2','4') "+
" 			  group by to_char(a.rqst_date,'yyyy.mm')) a,"   +
" 			 (select to_char(b.receive_date,'yyyy.mm') mnth,"   +
" 			         SUM(NVL(B.CASH_AMT,0)+NVL(B.BILL_AMT,0)+NVL(B.BANK_AMT,0)+NVL(B.ETC_AMT,0)) amt"   +
" 			    from f_receive_amt b"   +
" 				where b.dept_code = '"+arg_dept_code+"'"   +
" 				  and to_char(b.receive_date,'yyyy.mm') <= '"+arg_month+"'"   +
" 			  group by to_char(b.receive_date,'yyyy.mm') )b,"   +
" 			 (select std.mnth,"   +
" 				        sum(nvl(pre.amt,0)) amt"   +
" 				   from ("   +
" 					      select to_char(b.receive_date, 'yyyy.mm') mnth"   +
" 					        from f_receive_amt b"   +
" 					       where b.dept_code = '"+arg_dept_code+"'"   +
" 							   and to_char(b.receive_date, 'yyyy.mm') <= '"+arg_month+"'"   +
" 							GROUP BY to_char(b.receive_date, 'yyyy.mm')"   +
" 						  ) std 	,	  "   +
" 						  ("   +
" 						   select to_char(b.receive_date, 'yyyy.mm') mnth,"   +
" 							       SUM(NVL(B.CASH_AMT,0)+NVL(B.BILL_AMT,0)+NVL(B.BANK_AMT,0)+NVL(B.ETC_AMT,0)) amt"   +
" 							  from  f_receive_amt b"   +
" 							 where b.dept_code = '"+arg_dept_code+"'"   +
" 							   and to_char(b.receive_date, 'yyyy.mm') <= '"+arg_month+"'"   +
" 							GROUP BY to_char(b.receive_date, 'yyyy.mm')"   +
" 						  ) pre"   +
" 				 where std.mnth > pre.mnth(+) "   +
" 			   group by std.mnth				"   +
" 			  ) pre_in,"   +
" 			  (select std.mnth,"   +
" 				        sum(nvl(pre.amt,0)) amt"   +
" 				   from ("   +
" 					      select to_char(b.rqst_date, 'yyyy.mm') mnth"   +
" 					        from f_request b"   +
" 					       where b.dept_code = '"+arg_dept_code+"'"   +
" 							   and to_char(b.rqst_date, 'yyyy.mm') <= '"+arg_month+"'"   +
"								and b.fund_type  in('2','4') "+
" 							GROUP BY to_char(b.rqst_date, 'yyyy.mm')"   +
" 						  ) std 	,	  "   +
" 						  ("   +
" 						   select to_char(b.rqst_date, 'yyyy.mm') mnth,"   +
" 							       SUM(NVL(B.AMT,0)) amt"   +
" 							  from  f_request b"   +
" 							 where b.dept_code = '"+arg_dept_code+"'"   +
" 							   and to_char(b.rqst_date, 'yyyy.mm') <= '"+arg_month+"'"   +
"								and b.fund_type  in('2','4') "+
" 							GROUP BY to_char(b.rqst_date, 'yyyy.mm')"   +
" 						  ) pre"   +
" 				 where std.mnth > pre.mnth(+) "   +
" 			   group by std.mnth"   +
" 			  ) pre_out"   +
"  where std.mnth = a.mnth(+)"   +
"    and std.mnth = b.mnth(+)"   +
" 		and std.mnth = pre_in.mnth(+)"   +
"    and std.mnth = pre_out.mnth(+)"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>