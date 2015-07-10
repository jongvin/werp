<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_sec_evaluator = req.getParameter("arg_sec_evaluator");
     String arg_grade = req.getParameter("arg_grade");
     String arg_title = req.getParameter("arg_title");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("fir_ic",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_pe",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_ee",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_ga",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_gm",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_ng",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_sum",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select max(a.fir_ic) fir_ic, max(a.fir_pe) fir_pe, max(a.fir_ee) fir_ee, 					  " +
		" 							  max(a.fir_ga) fir_ga, max(a.fir_gm) fir_gm, max(a.fir_ng) fir_ng,                " +
		" 							  sum(nvl(a.fir_ic,0) + nvl(a.fir_pe,0) + nvl(a.fir_ee,0) + " +
		"									nvl(a.fir_ga,0) + nvl(a.fir_gm,0) + nvl(a.fir_ng,0)) fir_sum  " +		
		"			  		 from ( select decode(fir_suggest_grade,'1',trunc( (count(*) / b.cnt *100),0) ) fir_ic,  " +
		"								 		decode(fir_suggest_grade,'2',trunc( (count(*) / b.cnt *100),0) ) fir_pe,  " +
		"								 		decode(fir_suggest_grade,'3',trunc( (count(*) / b.cnt *100),0) ) fir_ee,  " +
		"								 		decode(fir_suggest_grade,'4',trunc( (count(*) / b.cnt *100),0) ) fir_ga,  " +
		"								 		decode(fir_suggest_grade,'5',trunc( (count(*) / b.cnt *100),0) ) fir_gm,  " +
		"								 		decode(fir_suggest_grade,'6',trunc( (count(*) / b.cnt *100),0) ) fir_ng   " +
		"								from p_eval_world_list a,                                                         " +
		"							  			(select count(*) cnt                                                      " +
		"							     			from p_eval_world_list                                                   " +
		"								 		  where eval_code = '" + arg_eval_code + "'                               " +
		"											 and eval_degree = '" + arg_eval_degree + "'                           " +
		"											 and sec_evaluator = '" + arg_sec_evaluator + "'                       " ;													
													if(arg_grade.equals("1"))    		 // 과장이상
													   query += " and self_grade_code <= '31' ";
													else if(arg_grade.equals("2"))		 // 과장미만
													   query += " and self_grade_code > '31' ";	
													   
													if(arg_title.equals("1"))    		 // 임원(특위이상)
													   query += " and self_grade_code <= '10' ";
													else if(arg_title.equals("2"))		 // 팀장(부장이하)
													   query += " and self_grade_code > '10' ";
													   
						query +=	"			) b " ;
						query +=	"	where eval_code = '" + arg_eval_code + "'          " ;
						query +=	"	  and eval_degree = '" + arg_eval_degree + "'      " ;
						query +=	"	  and sec_evaluator = '" + arg_sec_evaluator + "'  " ;
										
					if(arg_grade.equals("1"))    		 // 과장이상
					   query += "    and a.self_grade_code <= '31' ";
					else if(arg_grade.equals("1"))	    // 과장미만
					   query += "    and a.self_grade_code > '31' ";
					
					if(arg_title.equals("1"))    		 // 임원(특위이상)
					   query += " and a.self_grade_code <= '10' ";
					else if(arg_title.equals("2"))		 // 팀장(부장이하)
					   query += " and a.self_grade_code > '10' ";
					   
			query +=	"	group by fir_suggest_grade, b.cnt ) a ";
		
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>