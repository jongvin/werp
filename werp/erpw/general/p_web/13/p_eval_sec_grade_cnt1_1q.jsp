<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_sec_evaluator = req.getParameter("arg_sec_evaluator");
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
		"								from p_eval_mbo_list a,                                                         " +
		"							  			(select count(*) cnt                                                      " +
		"							     			from p_eval_mbo_list                                                   " +
		"								 		  where eval_code = '" + arg_eval_code + "'                               " +
		"								   	    and to_char(eval_year,'yyyy') = substr('" + arg_eval_degree + "',1,4) " +
		"											 and eval_degree = '" + arg_eval_degree + "'                           " +
		"											 and sec_evaluator = '" + arg_sec_evaluator + "'                       " ;
		
													if(arg_title.equals("1"))    		 // �ӿ�(Ư���̻�)
													   query += " and self_grade_code <= '10' ";
													else if(arg_title.equals("2"))		 // ����(��������)
													   query += " and self_grade_code > '10' ";
													   
						query +=	"			) b " ;
						query +=	"	where eval_code = '" + arg_eval_code + "'          " ;
						query +=	"	  and to_char(eval_year,'yyyy') = substr('" + arg_eval_degree + "',1,4) " ;
						query +=	"	  and eval_degree = '" + arg_eval_degree + "'      " ;
						query +=	"	  and sec_evaluator = '" + arg_sec_evaluator + "'  " ;
						query += "    and b.cnt > 0 ";
					
					if(arg_title.equals("1"))    		 // �ӿ�(Ư���̻�)
					   query += " and a.self_grade_code <= '10' ";
					else if(arg_title.equals("2"))		 // ����(��������)
					   query += " and a.self_grade_code > '10' ";

					query +=	"	group by fir_suggest_grade, b.cnt ) a ";					   
		
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>