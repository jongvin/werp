<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("min_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("min_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mmax_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mmax_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("min_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select min.dept_code,														" +
		"	 						nvl(min.cnt_amt,0)/ " + arg_won + " as min_cnt_amt,	" +
		"	 						nvl(min.amt,0)/ " + arg_won + " as min_amt,				" +
		"	 						nvl(max.cnt_amt,0)/ " + arg_won + " as max_cnt_amt,	" +
		"	 						nvl(max.amt,0)/ " + arg_won + " as max_amt,				" +
		"	 						nvl(mmax.cnt_amt,0)/ " + arg_won + " as mmax_cnt_amt,	" +
		"	 						nvl(mmax.amt,0)/ " + arg_won + " as mmax_amt,			" +
		"	 						nvl(min_c.min_result_amt,0)/ " + arg_won + " as min_result_amt, " +
		"	 						nvl(max_c.max_result_amt,0)/ " + arg_won + " as	max_result_amt  " +
		"					from (select a.dept_code,												" +
      "       							 a.chg_no_seq,												" +
		"	       						 a.chg_degree,												" +
		"	 		 						 a.cnt_amt,													" +
		"	 		 						 a.amt														" +
  		" 							  from y_chg_degree a,											" +
	   "        						(select Min(chg_no_seq) min_seq						" +
      "          						   from y_chg_degree										" +
      "         						  where approve_class='4' and							" +
      "         								  chg_class='2' and								" +
		"	         							  dept_code='" + arg_dept_code + "') b		" +
      " 							 where a.chg_no_seq = b.min_seq and							" +
      "       							 a.approve_class='4' and								" +
		"	 		 						 a.chg_class='2' and										" +
		"	 		 						 a.dept_code = '" + arg_dept_code + "'				" +
		"                    ) min,																" +
		"	 																								" +
		"  					  (select a.dept_code,												" +
      "       							 a.chg_no_seq,												" +
		"	 		 						 a.chg_degree,												" +
		"	 		 						 a.cnt_amt,													" +
		"	 		 						 a.amt														" +
      "  						  from y_chg_degree a,											" +
	   "   		 						(select max(chg_no_seq) max_seq						" +
      "          							from y_chg_degree										" +
      "         						  where approve_class='4' and							" +
      "               						  chg_class='2' and								" +
		"	         							  dept_code='" + arg_dept_code + "') b		" +
      " 							 where a.chg_no_seq = b.max_seq and							" +
      "       							 a.approve_class='4' and								" +
		"	 		 						 a.chg_class='2' and										" +
		"	 		 						 a.dept_code = '" + arg_dept_code + "'				" +
		"						  ) max,																	" +
		"			 																						" +
		"  					  (select a.dept_code,												" +
      "       							 a.chg_no_seq,												" +
		"	 		 						 a.chg_degree,												" +
		"	 		 						 a.cnt_amt,													" +
		"	 		 						 a.amt														" +
      "  						  from y_chg_degree a,											" +
	   "   		 						(select max(chg_no_seq) max_seq						" +
      "          							from y_chg_degree										" +
      "         						  where approve_class='4' and							" +
		"	         							  dept_code='" + arg_dept_code + "') b		" +
      " 							 where a.chg_no_seq = b.max_seq and							" +
      "       							 a.approve_class='4' and								" +
		"	 		 						 a.dept_code = '" + arg_dept_code + "') mmax,	" +
		"			 																						" +
		"						  (select dept_code,													" +
      "        						 sum(pre_result_amt) min_result_amt					" +
      "   						  from c_spec_const_detail										" +
      "  						 where dept_code='" + arg_dept_code + "' and				" +
      "        						 yymm = (select Min(yymm)								" +
      "                  	  from c_spec_const_detail										" +
      "                 	 where dept_code='" + arg_dept_code + "')					" +
      "  						 group by dept_code												" +
      "                   ) min_c,																" +
		"	  																								" +
		"						  (select dept_code,													" +
      "        						 sum(pre_result_amt) max_result_amt					" +
      "   						  from c_spec_const_detail										" +
      "  						 where dept_code='" + arg_dept_code + "' and				" +
      "        						 yymm = (select Max(yymm)								" +
      "                  	  from c_spec_const_detail										" +
      "                 	 where dept_code='" + arg_dept_code + "')					" +
      "  						 group by dept_code												" +
      "						  ) max_c																" +
		"	 																								" +
		"				  where min.dept_code = max.dept_code and								" +
      "						  min.dept_code = mmax.dept_code and							" +
		"						  min.dept_code = min_c.dept_code(+) and						" +
		"						  min.dept_code = max_c.dept_code(+)							" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					