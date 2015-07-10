<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
//   dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));

//     dSet.addDataColumn(new GauceDataColumn("cntp_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("cnts_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts_this",GauceDataColumn.TB_DECIMAL,18,0));
     
//     dSet.addDataColumn(new GauceDataColumn("exep_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exep_sum",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("exep_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("exes_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes_this",GauceDataColumn.TB_DECIMAL,18,0));
     
//     dSet.addDataColumn(new GauceDataColumn("cosp_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("coss_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss_this",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " 	" +
"		select  " +		
					/*도급계획 cntp */ 	 
"			 		nvl(p.cntp_this,0) / a.won cntp_this, " +
"			 		nvl(p.cntp,0) / a.won cntp, " +
"			 		nvl(p.cntp_sum,0) / a.won cntp_sum, " +
					 
			 		/*도급실적 cnts */
"			 		nvl(s.cnts_pre,0) / a.won cnts_pre, " +
"			 		nvl(s.cnts,0) / a.won cnts, " +
"			 		nvl(s.cnts_sum,0) / a.won cnts_sum, " +
"			 		(nvl(s.cnts_pre,0) + nvl(s.cnts_sum,0)) / a.won cnts_this, " +
					 
					/*실행계획 exep */
"			 		nvl(p.exep_this,0) / a.won exep_this, " +
"			 		nvl(p.exep,0) / a.won exep, " +
"			 		nvl(p.exep_sum,0) / a.won exep_sum, " +
				 			 
			 		/*실행실적 exes */
"			 		nvl(s.exes_pre,0) / a.won exes_pre, " +
"			 		nvl(s.exes,0) / a.won exes, " +
"			 		nvl(s.exes_sum,0) / a.won exes_sum, " +
"			 		(nvl(s.exes_pre,0) + nvl(s.exes_sum,0)) / a.won exes_this, " +

					/*원가계획 cosp */	
"			 		nvl(p.cosp_this,0) / a.won cosp_this, " +
"			 		nvl(p.cosp,0) / a.won cosp, " +
"			 		nvl(p.cosp_sum,0) / a.won cosp_sum, " +

			 		/*원가실적 coss */		 
"			 		nvl(s.coss_pre,0) / a.won coss_pre, " +
"			 		nvl(s.coss,0) / a.won coss, " +
"			 		nvl(s.coss_sum,0) / a.won coss_sum, " +
"			 		(nvl(s.coss_pre,0) + nvl(s.coss_sum,0)) / a.won coss_this " +

" 			from 	(select substr('" + arg_yymm + "', 1,4) yr , substr('" + arg_yymm + "',5,2) mon , '" + arg_won + "' won, '" + arg_dept_code + "' dept_code  from dual) a, " +
"					(select	a.dept_code, " +
			 		/*도급계획 cntp */      
"       			sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cnt_amt,0) else 0 end ) cntp_this, " +
"       			sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon , nvl(c.cnt_amt,0), 0 )) cntp,  " +
"       			sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon  then nvl(c.cnt_amt,0) else 0 end ) cntp_sum, 	" +

			 		/*실행계획 exep */
"       			sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.plan_mm_amt,0) else 0 end ) exep_this, " +
"       			sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(c.plan_mm_amt,0), 0 )) exep, " +
"       			sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(c.plan_mm_amt,0) else 0 end ) exep_sum, " +

			 		/*원가계획 cosp */  
"       			sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cost_amt,0) else 0 end ) cosp_this, " +
"       			sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(c.cost_amt,0), 0 )) cosp, " +
"       			sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(c.cost_amt,0) else 0 end ) cosp_sum " +
			 
"  		from (select substr('" + arg_yymm + "', 1,4) yr , substr('" + arg_yymm + "',5,2) mon , '" + arg_won + "' won, '" + arg_dept_code + "' dept_code  from dual) a, " +
"			 		c_progress_detail c, " +
"       			y_chg_budget_detail b, " +
"		  	 		c_spec_const_detail sp " +
"		where c.dept_code = a.dept_code and " +
"      		to_char(c.year,'yyyy') <= a.yr and " +
"      		c.chg_seq = (select nvl(max(chg_seq), -1)  " +
"      			 	   		from c_chg_progress  " +
"      			     			where dept_code = '" + arg_dept_code + "' and " +
"      				        			app_yn = 'Y' ) and " +
"      		c.dept_code = b.dept_code and " +
"      		c.chg_no_seq = b.chg_no_seq and " +
"		   	c.spec_unq_num = b.spec_unq_num and " +
"      		c.spec_no_seq  = b.spec_no_seq and " +
"				c.dept_code    = sp.dept_code and " +
"      		c.year         = sp.yymm and " +
"      		c.spec_unq_num = sp.spec_unq_num and  " +
"      		c.spec_no_seq  = sp.spec_no_seq and " +
"      		sp.yymm <= last_day(to_date(substr('" + arg_yymm + "', 1,4) || '12','yyyymm')) " +
"				group by a.dept_code ) p, " +
"			(select a.dept_code," +	
					/*도급실적 cnts */				 			 		
"			 		sum( case when to_char(s.yymm,'yyyy') < a.yr then nvl(s.cnt_result_amt,0) else 0 end) cnts_pre, " +
"			 		sum(decode(to_char(s.yymm,'yyyymm'), a.yr||a.mon, nvl(s.cnt_result_amt,0), 0 )) cnts, " +
"			 		sum( case when to_char(s.yymm, 'yyyy') = a.yr and to_char(s.yymm, 'mm') <= a.mon then nvl(s.cnt_result_amt,0) else 0 end ) cnts_sum, " +
					
					/*실행실적 exes */
"			 		sum( case when to_char(s.yymm,'yyyy') < a.yr then nvl(s.result_amt,0) else 0 end) exes_pre, " +
"			 		sum(decode(to_char(s.yymm,'yyyymm'), a.yr||a.mon, nvl(s.result_amt,0), 0 )) exes, " +
"			 		sum( case when to_char(s.yymm, 'yyyy') = a.yr and to_char(s.yymm, 'mm') <= a.mon then nvl(s.result_amt,0) else 0 end ) exes_sum, " +
					
					/*원가실적 coss */
"			 		sum( case when to_char(s.yymm,'yyyy') < a.yr then nvl(s.cost_amt,0) else 0 end) coss_pre, " +
"			 		sum(decode(to_char(s.yymm,'yyyymm'), a.yr||a.mon, nvl(s.cost_amt,0), 0 )) coss, " +
"			 		sum( case when to_char(s.yymm, 'yyyy') = a.yr and to_char(s.yymm, 'mm') <= a.mon then nvl(s.cost_amt,0) else 0 end ) coss_sum " +

" 			from (select substr('" + arg_yymm + "', 1,4) yr , substr('" + arg_yymm + "',5,2) mon , '" + arg_won + "' won, '" + arg_dept_code + "' dept_code  from dual) a, " +
"			 		c_spec_const_detail s	" +		 	 
"			where a.dept_code = s.dept_code and " +
"					to_char(s.yymm, 'yyyy') <= a.yr  " +
"			group by a.dept_code) s " +
"		where a.dept_code = p.dept_code(+) and " +
"				a.dept_code = s.dept_code(+) " ;
            
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					