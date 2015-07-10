<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
     //dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("last_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_y_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_y_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_y_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_m_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_m_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_m_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_s_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_s_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_s_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
     dSet.addDataColumn(new GauceDataColumn("all_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("all_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("all_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_y_cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_y_exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_m_cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_m_exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_s_cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_s_exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_cnt2_cha",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_exe2_cha",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select nvl(a.last_cnt_amt, 0)/" + arg_won + " as last_cnt_amt,										" +
      "  						nvl(a.last_result_amt, 0)/" + arg_won + " as last_result_amt,								" +
		"	 						nvl(a.last_cost_amt, 0)/" + arg_won + " as last_cost_amt,									" +
		
		"	 						nvl(b.plan_cnt_amt, 0)/" + arg_won + " as plan_y_cnt_amt,									" +
		"	 						nvl(b.plan_result_amt, 0)/" + arg_won + " as plan_y_result_amt,							" +
		"	 						nvl(b.plan_cost_amt, 0)/" + arg_won + " as plan_y_cost_amt,									" +
		
		"	 						nvl(c.plan_cnt_amt, 0)/" + arg_won + " as plan_m_cnt_amt,									" +
		"	 						nvl(c.plan_result_amt, 0)/" + arg_won + " as plan_m_result_amt,							" +
		"	 						nvl(c.plan_cost_amt, 0)/" + arg_won + " as plan_m_cost_amt,									" +
		
		"	 						nvl(d.plan_cnt_amt, 0)/" + arg_won + " as plan_s_cnt_amt,									" +
		"	 						nvl(d.plan_result_amt, 0)/" + arg_won + " as plan_s_result_amt,							" +
		"	 						nvl(d.plan_cost_amt, 0)/" + arg_won + " as plan_s_cost_amt,									" +
		
		"	 						nvl(e.cnt_amt, 0)/" + arg_won + " as cnt_amt,													" +
		"	 						nvl(e.result_amt, 0)/" + arg_won + " as result_amt,											" +
		"	 						nvl(e.cost_amt, 0)/" + arg_won + " as cost_amt,													" +
		
		"	 						nvl(f.s_cnt_amt, 0)/" + arg_won + " as s_cnt_amt,												" +
		"	 						nvl(f.s_result_amt, 0)/" + arg_won + " as s_result_amt,										" +
		"	 						nvl(f.s_cost_amt, 0)/" + arg_won + " as s_cost_amt,											" +
		
		"			(nvl(a.last_cnt_amt, 0)+nvl(f.s_cnt_amt, 0))/" + arg_won + " as all_cnt_amt,							" +
		"			(nvl(a.last_result_amt, 0)+nvl(f.s_result_amt, 0))/" + arg_won + " as all_result_amt,				" +
		"			(nvl(a.last_cost_amt, 0)+nvl(f.s_cost_amt, 0))/" + arg_won + " as all_cost_amt,						" +
		
		"        (nvl(a.last_cnt_amt, 0)-nvl(a.last_cost_amt, 0))/" + arg_won + " as last_cnt2_cha,					" +
		"        (nvl(a.last_result_amt, 0)-nvl(a.last_cost_amt, 0))/" + arg_won + " as last_exe2_cha,				" +
		
		"        (nvl(b.plan_cnt_amt, 0)-nvl(b.plan_cost_amt, 0))/" + arg_won + " as plan_y_cnt2_cha,				" +
		"        (nvl(b.plan_result_amt, 0)-nvl(b.plan_cost_amt, 0))/" + arg_won + " as plan_y_exe2_cha,			" +
		
		"        (nvl(c.plan_cnt_amt, 0)-nvl(c.plan_cost_amt, 0))/" + arg_won + " as plan_m_cnt2_cha,				" +
		"        (nvl(c.plan_result_amt, 0)-nvl(c.plan_cost_amt, 0))/" + arg_won + " as plan_m_exe2_cha,			" +
		
		"        (nvl(d.plan_cnt_amt, 0)-nvl(d.plan_cost_amt, 0))/" + arg_won + " as plan_s_cnt2_cha,				" +
		"        (nvl(d.plan_result_amt, 0)-nvl(d.plan_cost_amt, 0))/" + arg_won + " as plan_s_exe2_cha,			" +
		
		"        (nvl(e.cnt_amt, 0)-nvl(e.cost_amt, 0))/" + arg_won + " as cnt2_cha,										" +
		"        (nvl(e.result_amt, 0)-nvl(e.cost_amt, 0))/" + arg_won + " as exe2_cha,									" +
		
		"        (nvl(f.s_cnt_amt, 0)-nvl(f.s_cost_amt, 0))/" + arg_won + " as s_cnt2_cha,								" +
		"        (nvl(f.s_result_amt, 0)-nvl(f.s_cost_amt, 0))/" + arg_won + " as s_exe2_cha							" +
  		"					 from																							" +
		"	 						(select  a.dept_code,															" +
      "										sum(a.cnt_result_amt) last_cnt_amt,								" +
		"	 									sum(a.result_amt) last_result_amt,								" +
		"										sum(a.cost_amt) last_cost_amt										" +
  		"	 							 from c_spec_const_parent a,												" +
	   " 	 									y_budget_parent b														" +
		"								where a.dept_code = b.dept_code and										" +
		"		      						a.spec_no_seq = b.spec_no_seq and								" +
		"										b.llevel = '1' and													" +
		"										a.dept_code = '" + arg_dept_code + "' and						" +
		"										to_char(a.yymm,'yyyy') < substr('" + arg_yymm + "',0,4)	" +
		"								group by a.dept_code															" +
		"	  						) a,																					" +
		"	  																												" +
		"	  						(select  a.dept_code,															" +
		"	          						sum(a.cnt_amt) plan_cnt_amt,										" +
		"				 						sum(a.plan_mm_amt) plan_result_amt,								" +
		"				 						sum(a.cost_amt) plan_cost_amt										" +
		"		  						 from c_progress_detail a													" +
		"		 						where a.dept_code = '" + arg_dept_code + "' and						" +
		"                             a.chg_seq = (select max(chg_seq) 								" +
		"                                            from c_chg_progress 								" +
		"                                           where dept_code = '" + arg_dept_code + "' and " +
		"                                                 app_yn='Y' group by dept_code) and	" +
		"		       						to_char(a.year, 'yyyy') = substr('" + arg_yymm + "',0,4)	" +
		"		 						group by a.dept_code															" +
		"	  						) b,																					" +
		"	  																												" +
		"	  						(select  a.dept_code,															" +
		"	          						sum(a.cnt_amt) plan_cnt_amt,										" +
		"				 						sum(a.plan_mm_amt) plan_result_amt,								" +
		"				 						sum(a.cost_amt) plan_cost_amt										" +
		"		  						 from c_progress_detail a													" +
		"		 						where a.dept_code = '" + arg_dept_code + "' and						" +
		"		       						to_char(a.year, 'yyyy.mm') = '" + arg_yymm + "'				" +
		"		 						group by a.dept_code															" +
		"	  						) c,																					" +
		"	  																												" +
		"	  						(select  a.dept_code,															" +
		"	          						sum(a.cnt_amt) plan_cnt_amt,										" +
		"				 						sum(a.plan_mm_amt) plan_result_amt,								" +
		"				 						sum(a.cost_amt) plan_cost_amt										" +
		"		  						 from c_progress_detail a													" +
		"		 						where a.dept_code = '" + arg_dept_code + "' and						" +
		"		       						to_char(a.year, 'yyyy') = substr('" + arg_yymm + "',0,4) and	" +
		"		       						to_char(a.year, 'yyyy.mm') <= '" + arg_yymm + "'			" +
		"		 						group by a.dept_code															" +
		"	  						) d,																					" +
		"	  																												" +
		"	  						(select  a.dept_code,															" +
      "										sum(a.cnt_result_amt) cnt_amt,									" +
		"	 									sum(a.result_amt) result_amt,										" +
		"										sum(a.cost_amt) cost_amt											" +
  		"	 							 from c_spec_const_parent a,												" +
	   " 	 									y_budget_parent b														" +
		"								where a.dept_code = b.dept_code and										" +
		"		      						a.spec_no_seq = b.spec_no_seq and								" +
		"										b.llevel = '1' and													" +
		"										a.dept_code = '" + arg_dept_code + "' and						" +
		"										to_char(a.yymm,'yyyy.mm') = '" + arg_yymm + "'				" +
		"								group by a.dept_code															" +
		"	  						) e,																					" +
		"																													" +
		"	  						(select  a.dept_code,															" +
      "										sum(a.cnt_result_amt) s_cnt_amt,									" +
		"	 									sum(a.result_amt) s_result_amt,										" +
		"										sum(a.cost_amt) s_cost_amt											" +
  		"	 							 from c_spec_const_parent a,												" +
	   " 	 									y_budget_parent b														" +
		"								where a.dept_code = b.dept_code and										" +
		"		      						a.spec_no_seq = b.spec_no_seq and								" +
		"										b.llevel = '1' and													" +
		"										a.dept_code = '" + arg_dept_code + "' and						" +
		"                             to_char(a.yymm,'yyyy') = substr('" + arg_yymm + "',0,4) and	" +
		"										to_char(a.yymm,'yyyy.mm') <= '" + arg_yymm + "'				" +
		"								group by a.dept_code															" +
		"	  						) f																					" +
 		"					where e.dept_code = d.dept_code(+) and												" +
      " 							e.dept_code = a.dept_code(+) and												" +
		"	 						e.dept_code = b.dept_code(+) and												" +
		"	 						e.dept_code = c.dept_code(+) and												" +
		"                    e.dept_code = f.dept_code(+)													" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					