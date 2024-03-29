<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yyyy = req.getParameter("arg_yyyy");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_tm_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class_6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_kind",GauceDataColumn.TB_STRING,18));
    String query = "select a.dept_code, 																" +
"									(select long_name from z_code_dept where dept_code=a.dept_code) long_name, " +
"			 						b.order_number, 															" +
"			 						b.order_name, 																" +
"			 						b.sbcr_name, 																" +
"			 						nvl(c.comp_tm_tot,0) comp_tm_tot, 									" +
"			 						decode(b.emp_class,'2',c.comp_tm_tot,null) class_1, 			" +
"			 						decode(b.emp_class,'3',c.comp_tm_tot,null) class_2, 			" +
"			 						decode(b.emp_class,'4',c.comp_tm_tot,null) class_3, 			" +
"			 						decode(b.emp_class,'5',c.comp_tm_tot,null) class_4, 			" +
"			 						decode(b.emp_class,'6',c.comp_tm_tot,null) class_5,	 		" +
"			 						decode(b.pay_guarantee_kind,null,null,c.comp_tm_tot) class_6, " +
"			 						b.pay_guarantee_kind 													" +
" 							from ( 																				" +
"									select   a.dept_code, 													" +
"						 						a.cont_no, 														" +
"						 						a.chg_degree, 													" +
"						 						a.const_name, 													" +
"						 						to_char(a.start_date,'YYYY.MM') start_date,  		" +
"						 						to_char(a.completion_date,'YYYY.MM') completion_date, " +
"			       							a.change_sum_amt, 											" +
"						 						a.payment_condition 											" +
"			  						from 		r_contract_register a, 										" +
"						 						(select  max(dept_code) dept_code, 						" +
"						 									max(cont_no) cont_no, 							" +
"															max(chg_degree) chg_degree 					" +
"							 					from 		r_contract_register 								" +
"												group by dept_code,cont_no) b 							" +
"						   		where 	a.dept_code = b.dept_code and  							" +
"						  		   			a.cont_no = b.cont_no and  								" +
"								   			a.chg_degree = b.chg_degree and  						" +
"								   			to_char(a.start_date ,'YYYY') <= '" + arg_yyyy + "' and  " +
"								   			to_char(a.completion_date,'YYYY') >= '" + arg_yyyy + "' 	" +
"									) a,																			" +		  
"									(																				" +  
"									select 	a.dept_code,   												" +
"						 						a.order_number,												" +
"						 						a.order_name,													" +
"						 						b.sbcr_code,													" +
"						 						b.sbcr_name,													" +
"						 						a.emp_class,													" +
"						 						a.pay_guarantee_kind											" +		 
"			  						from 		s_chg_cn_list a,												" +
"				     							s_sbcr b,														" +
"						 						(select 	dept_code,											" +
"						 									order_number,										" +
"															max(chg_degree) chg_degree						" +
"						    					from 		s_chg_cn_list										" +
"												group by dept_code,											" +
"															order_number										" +
"						 						) c,																" +
"												s_pay d															" +
"			 						where 	a.sbcr_code = b.sbcr_code and								" +
"			 			 						a.dept_code = c.dept_code and								" +
"						 						a.order_number = c.order_number and						" +
"						 						a.chg_degree = c.chg_degree and							" +
"						 						a.dept_code = d.dept_code and								" +
"						 						a.order_number = d.order_number and						" +
"						 						to_char(d.yymm,'yyyy') = '" + arg_yyyy + "'			" +
"									) b,																			" +		 	 
"									(																				" +
"									select 	a.dept_code,													" +
"						 						a.order_number,												" +
"						 						b.sbc_name,														" +
"						 						d.sbcr_code,													" +
"						 						d.sbcr_name,													" +
"			       							(sum(a.tm_prgs) + sum(a.tm_prgs_notax) + sum(a.tm_purchase_vat)) comp_tm_tot	" +
"			  						from 		s_pay a,															" +
"				     							s_cn_list b,													" +
"						 						s_sbcr d															" +
"			 						where 	a.dept_code = b.dept_code(+) and							" +
"			       							a.order_number = b.order_number and						" +
"						 						b.sbcr_code = d.sbcr_code and								" +
"						 						to_char(a.yymm,'yyyy') = '" + arg_yyyy + "'			" +
"			 						group by a.dept_code,													" +
"			 			 	 					a.order_number,												" +
"			  		 	 						b.sbc_name,														" +
"							 					d.sbcr_code,													" +
"							 					d.sbcr_name														" +
"									) c																			" +
"							where a.dept_code = b.dept_code(+) and										" +
"									b.dept_code = c.dept_code(+) and										" +
"									b.order_number = c.order_number(+)									" +
"							order by a.dept_code, b.order_number 										";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>