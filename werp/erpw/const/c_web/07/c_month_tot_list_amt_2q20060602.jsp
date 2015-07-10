<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
//   dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));

     dSet.addDataColumn(new GauceDataColumn("cntp_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cntp_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("cnts_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnts_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("exep_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exep_sum",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("exep_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("exes_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exes_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("cosp_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cosp_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("coss_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("coss_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("cnte_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnte",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnte_this",GauceDataColumn.TB_DECIMAL,18,0));

     dSet.addDataColumn(new GauceDataColumn("exee_pre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exee",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exee_this",GauceDataColumn.TB_DECIMAL,18,0));
     
     
    String query = "      select 					" +
           
                 /*도급계획 cntp */
      "          sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cnt_amt,0) else 0 end ) / a.won cntp_pre, " +
      "          sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon , nvl(c.cnt_amt,0), 0 )) / a.won cntp, " +
      "          sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon  then nvl(c.cnt_amt,0) else 0 end ) / a.won cntp_sum, " +	      
      "          sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cnt_amt,0) else 0 end ) / a.won cntp_this,  " +
      
                /*도급실적 cnts */
      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1 then nvl(sp.cnt_result_amt,0) else 0 end ) / a.won cnts_pre,  " +
//      "          sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.cnt_result_amt,0), 0 )) / a.won cnts, " +
		"			  (select sum(cnt_result_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyymm')=a.yr||a.mon) / a.won cnts, " +
		"			  (select sum(cnt_result_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyy')=a.yr and to_char(yymm,'yyyymm')<=a.yr||a.mon) / a.won cnts_sum, " +
//      "          sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(sp.cnt_result_amt,0) else 0 end ) / a.won cnts_sum, " +
//      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) / a.won cnts_this, " +
      "          (sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1 then nvl(sp.cnt_result_amt,0) else 0 end ) + " +
      "			  sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(sp.cnt_result_amt,0) else 0 end ))  / a.won cnts_this, " +
      
                /*실행계획 exep */
      "          sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.plan_mm_amt,0) else 0 end ) / a.won exep_pre,    " + 
      "          sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(c.plan_mm_amt,0), 0 )) / a.won exep, " +
      "          sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(c.plan_mm_amt,0) else 0 end ) / a.won exep_sum, " +
      "          sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.plan_mm_amt,0) else 0 end ) / a.won exep_this,  " +
                
                /*실행실적 exes */
      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr -1 then nvl(sp.result_amt,0) else 0 end ) / a.won exes_pre,  " +
//      "          sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.result_amt,0), 0 )) / a.won exes, " +
		"			  (select sum(result_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyymm')=a.yr||a.mon) / a.won exes, " +
		"			  (select sum(result_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyy')=a.yr and to_char(yymm,'yyyymm')<=a.yr||a.mon) / a.won exes_sum, " + 		
//      "          sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(sp.result_amt,0) else 0 end ) / a.won exes_sum, " + 		  
//      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end ) / a.won exes_this, " +
      "          (sum( case when to_char(sp.yymm,'yyyy') = a.yr -1 then nvl(sp.result_amt,0) else 0 end ) + " +
      "				sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(sp.result_amt,0) else 0 end )) / a.won exes_this, " +
                
                /*원가계획 cosp */
      "          sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cost_amt,0) else 0 end ) / a.won cosp_pre, " +
      "          sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(c.cost_amt,0), 0 )) / a.won cosp, " +
      "          sum( case when to_char(c.year,'yyyy') =  a.yr and  to_char(c.year,'mm') <=  a.mon then nvl(c.cost_amt,0) else 0 end ) / a.won cosp_sum,  "+		  
      "          sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cost_amt,0) else 0 end ) / a.won cosp_this,  " +
                
                /*원가실적 coss */
      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1  then nvl(sp.cost_amt,0) else 0 end ) / a.won coss_pre, " +
//      "          sum(decode(to_char(sp.yymm,'yyyymm'), a.yr||a.mon, nvl(sp.cost_amt,0), 0 )) / a.won coss, " +
		"			  (select sum(cost_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyymm')=a.yr||a.mon) / a.won coss, " +
		"			  (select sum(cost_amt) from c_spec_const_detail where dept_code=a.dept_code and to_char(yymm,'yyyy')=a.yr and to_char(yymm,'yyyymm')<=a.yr||a.mon) / a.won coss_sum, " +
//      "          sum( case when to_char(sp.yymm,'yyyy') =  a.yr and  to_char(sp.yymm,'yyyymm') <=  a.yr||a.mon then nvl(sp.cost_amt,0) else 0 end ) / a.won coss_sum, " +		  
//      "          sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) / a.won coss_this, " +
      "          (sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1  then nvl(sp.cost_amt,0) else 0 end ) + " +     
      "				sum( case when to_char(sp.yymm,'yyyy') =  a.yr and  to_char(sp.yymm,'yyyymm') <=  a.yr||a.mon then nvl(sp.cost_amt,0) else 0 end ))  / a.won coss_this, " +
 
                /*도급손익 cnte */
      "          ( sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1 then nvl(sp.cnt_result_amt,0) else 0 end ) " +
      "          - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) ) / a.won cnte_pre,  " +
		"           (      sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.cnt_result_amt,0), 0 )) " +
      "         - sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.cost_amt,0), 0 ))) / a.won cnte, " +
      "          (sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) " +
      "          - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end )) / a.won cnte_this, " +
 
                /*실행손익 exee */
      "         (sum( case when to_char(sp.yymm,'yyyy') = a.yr - 1 then nvl(sp.result_amt,0) else 0 end ) " +
      "          - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end )) / a.won exee_pre, " +
      "             (  sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.result_amt,0), 0 )) " +
      "                - sum(decode(to_char(c.year,'yyyymm'), a.yr||a.mon, nvl(sp.cost_amt,0), 0 )) )/ a.won exee, " +
      "                (sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end ) " +
      "                - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) )/ a.won exee_this    " +             

      "           from c_progress_detail c, " +
      "                y_chg_budget_detail b, " +
      "                c_spec_const_detail sp, " +
      "					  (select  a.dept_code,			" +												
      "										sum(a.cnt_result_amt) cnt_amt,									" +
		"	 									sum(a.result_amt) result_amt,										" +
		"										sum(a.cost_amt) cost_amt											" +
  		"	 							 from c_spec_const_parent a,												" +
	   "	 									y_budget_parent b														" +
		"								where a.dept_code = b.dept_code and										" +
		"		      						a.spec_no_seq = b.spec_no_seq and								" +
		"										b.llevel = '1' and													" +
		"										a.dept_code = '"+arg_dept_code+"' and						" +
		"										to_char(a.yymm,'yyyymm') = '"+arg_yymm+"'				" +
		"								group by a.dept_code) s,	" +
      "                (select substr('"+arg_yymm+"', 1,4) yr , substr('"+arg_yymm+"',5,2) mon , '"+arg_won+"' won, '"+arg_dept_code+"' dept_code  from dual) a " +
      "          where c.dept_code = '"+arg_dept_code+"' " +
      "            and to_char(c.year,'yyyy') <= a.yr " +
      "           and c.chg_seq =  " +
      "			(select nvl(max(chg_seq), -1) select_1  " +
      "			 from c_chg_progress  " +
      "			 where dept_code = '"+arg_dept_code+"' " +
      "				   and app_yn = 'Y' ) " +
      "            and c.dept_code = b.dept_code  " +
      "            and c.chg_no_seq = b.chg_no_seq " +
		"      and c.spec_unq_num = b.spec_unq_num " +
      "            and c.spec_no_seq  = b.spec_no_seq " +
      "            and c.dept_code    = sp.dept_code " +
      "            and c.year         = sp.yymm " +
      "            and c.spec_unq_num = sp.spec_unq_num " +
      "            and c.spec_no_seq  = sp.spec_no_seq " +
      "				 and c.dept_code = s.dept_code(+) " +
      "      and sp.yymm <= last_day(to_date(substr('"+arg_yymm+"', 1,4) || '12','yyyymm') ) " +
      "			group by s.cnt_amt, s.result_amt, s.cost_amt	" ;
            
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					