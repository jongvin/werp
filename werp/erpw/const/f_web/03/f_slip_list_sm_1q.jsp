<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("slip_check",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("notax_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("adv_deduct",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_deduct",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vender_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("v_desc",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("vender_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
    String query = "     select 'M'                   res_type, " + 
						"			   'F'                      slip_check, " + 
						"			   0                        order_number, " + 
						"			   nvl(sum(b.amt),0)        amt, " + 
						"			   0                        notax_amt, " + 
						"			   nvl(sum(b.vatamt),0)     vat, " + 
						"			   nvl(d.deduct_amt, 0)     adv_deduct, " + 
						"			   nvl(a.res_amt, 0)        etc_deduct, " + 
						"			   c.vender_name, " + 
						"			   c.owner, " + 
						"			   trim(max(a.inputtitle))  v_desc, " + 
						"			   a.vender_code, " +  
						"			   to_char(a.receipt_bal_date, 'yyyy.mm.dd')   receipt_date " + 
						"		  FROM m_input             a, " + 
						"		       m_input_detail      b, " + 
						"		       m_code_collaborator c, " + 
						"		       m_prepay_master     d " + 
						"		 WHERE a.dept_code   = b.dept_code " +      
						"		   and a.yymmdd      = b.yymmdd  " +    
						"		   and a.seq         = b.seq " +          
						"			and a.vender_code = c.vender_code(+) " +    
						"			and a.dept_code   = d.dept_code(+) " +    
						"			and a.vender_code = d.vender_code(+) " +   
						"			and d.issue_date(+) between '" + arg_from_date + "' and '" + arg_to_date + "' " +    
						"			and a.dept_code   = '" + arg_dept_code + "' " +   
						"			and a.yymmdd between '" + arg_from_date + "' and '" + arg_to_date + "' " +    
						"			and ( a.inouttypecode = 'A' or a.inouttypecode = 'B' ) " + 
						"		GROUP BY a.vender_code, " +  
						"				   c.vender_name, " + 
						"				   c.owner, " + 
						"				   nvl(d.deduct_amt, 0), " +  
						"				   nvl(a.res_amt, 0), " +  
						"				   a.receipt_bal_date " + 
						"	union all " + 
						"	   SELECT  'S'                          res_type, " + 
						"			     'F'                          slip_check, " + 
						"				   a.order_number, " + 
						"				   a.tm_prgs  		             amt, " + 
						"				   a.tm_prgs_notax             notax_amt, " + 
						"				   a.tm_vat   		             vat, " + 
						"				   a.tm_advance_deduction      adv_deduct, " +  
						"				   a.tm_etc_amt                etc_deduct, " + 
						"	  			   c.sbcr_name                 vender_name, " + 
						"	  			   c.representative_name1      owner, " + 
						"				   b.sbc_name                  v_desc, " + 
						"				   ''                          vender_code, " + 
						"		 		   decode(a.pay_dt,null,'" + arg_to_date + "',to_char(a.pay_dt,'yyyy.mm.dd'))  RECEIPT_DATE " +  
						"			  from s_pay      a, " + 
						"	 			    s_cn_list  b, " + 
						"	     		    s_sbcr     c " + 
						"				 where a.dept_code    = b.dept_code " + 
						"				   and a.order_number = b.order_number " + 
						"				   and b.sbcr_code    = c.sbcr_code " + 
						"				   and (a.tm_prgs  <> 0 or a.tm_prgs_notax <> 0) " +  
						"				   and a.dept_code    = '" + arg_dept_code + "' " +   
						"				   and a.yymm between '" + arg_from_date + "' and '" + arg_to_date + "' " +   
						"	order by res_type, receipt_date, vender_code  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>