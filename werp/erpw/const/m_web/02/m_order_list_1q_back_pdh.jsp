<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("APPROTITLE",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("input_totamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("rem_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("drank",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select tag, 																											" +		
    	"						APPROTITLE,                                                                               " +
    	"						decode(drank,1,exe_amt,0) exe_amt,                                                        " +
    	"						decode(drank,1,bud_amt,0) bud_amt,                                                        " +
    	"						decode(drank,1,amt,0) amt,                                                                " +
      "                 sbcr_name,                                                                                " +
      "                 rep_name1,                                                                                " +
    	"						decode(drank,1,input_totamt,input_totamt) input_totamt,                                   " +
    	"						decode(drank,1,rate,rate) rate,                                                           " +
    	"						decode(drank,1,decode(tag,3,rem_amt,0),0) rem_amt,                                        " +
    	"						decode(drank,1,input_amt,input_amt) input_amt ,                                            " +
    	"						drank                                           " +
      " from (select tag, RANK() OVER (PARTITION BY APPROTITLE ORDER BY sbcr_name) drank,                      " +
      "                     APPROTITLE, exe_amt, bud_amt, amt, sbcr_name, rep_name1,                           " +
      "                     input_amt, decode(amt,0,0,(input_totamt/amt)*100) rate,                        		" +
      "                     amt - input_totamt2 rem_amt, input_totamt															" + 
		      " from (select 3 tag,																											   " +						
				"				  a.APPROTITLE, 																											" +	
				"				  nvl(d.exe_amt,0) exe_amt,                                                                     " +   
				"				  nvl(d.bud_amt,0) bud_amt,                                                                     " +   
				"				  nvl(d.amt,0) amt,                                                                             " +
				"				  c.sbcr_name,                                                                                  " +   
				"				  c.rep_name1,                                                                                  " +
				"				  nvl(e.input_amt,0) input_amt,                                                                 " +       
				"				  nvl(e.input_totamt,0) input_totamt,                                                           " +            
				"				  nvl(f.input_totamt2,0) input_totamt2                                                          " +            
				"		 from m_approval a,                                                                                   " +   
				"		 	 m_approval_sbcr b,                                                                                " +
				"			 s_sbcr c,                                                                                         " +
				"			( select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT,                                            " +
				"			  	    sum(nvl(c.mat_amt,0)) exe_amt, sum(nvl(b.qty,0)*nvl(b.bud_price,0)) bud_amt,                " +
				"			  	    sum(nvl(b.qty,0)*nvl(a.unitprice,0)) amt                                                    " +
				"				from m_approval_detail a,                                                                       " +
				"					m_request_detail b,                                                                          " +
				"					y_budget_detail c                                                                            " +
				"			  where a.dept_code 	      = '" + arg_dept_code + "'                                               " +
				"			    and a.DEPT_CODE 	 	 = b.dept_code(+)                                                             " +   
				"			    and a.request_unq_num 	 = b.request_unq_num(+)                                                    " +
				"			    and a.request_chg_cnt 	 = b.chg_cnt(+)                                                            " +
				"			    and a.DEPT_CODE 	 	 = c.dept_code(+)                                                             " +
				"			    and a.spec_no_seq 	      = c.spec_no_seq(+)                                                   " +     
				"			    and a.spec_unq_num	      = c.spec_unq_num(+)                                                  " +     
				"			  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT                                           " +
				"		     ) d,                                                                                             " +
				"		     (select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code,                              " +
				"				   sum(nvl(c.amt,0)) input_totamt,                                                              " +
				"				   sum(decode(trunc(a.approdate,'mm'),to_date('" + arg_yymm + "'),nvl(c.amt,0),0)) input_amt    " +                                 
				"					from m_approval a,                                                                           " +
				"						m_approval_detail b,                                                                      " +
				"						m_input_detail c                                                                          " +
				"			  where a.dept_code 	  	 = b.dept_code                                                             " +        
				"			    and a.APPROYM 		  	 = b.approym                                                            " +              
				"			    and a.APPROSEQ 	  		 = b.approseq                                                           " +              
				"			    and a.chg_cnt		  	 = b.chg_cnt                                                               " +           
				"			    and a.dept_code 		 = '" + arg_dept_code + "'                                                 " +
				"			    and trunc(a.approdate,'mm') <= '" + arg_yymm + "' 	                                          " +
				"			    and b.DEPT_CODE 	 	 = c.dept_code(+)                                                          " +
				"			    and b.approval_unq_num 	 	 = c.approval_unq_num(+)                                          " +
				"			  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code) e,                          " +
				"		     (select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT,        												" +
				"				   sum(nvl(b.amt,0)) input_totamt2                                                              " +
				"					from m_approval_detail a,                                                                    " +
				"						m_input_detail b                                                                          " +
				"			  where a.dept_code 		 = '" + arg_dept_code + "'                                                 " +
				"			    and a.DEPT_CODE 	 	 = b.dept_code(+)                                                          " +
				"			    and a.approval_unq_num 	 = b.approval_unq_num(+)                                             " +
				"			  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT) f                                        " +
				"		where a.dept_code 	  = b.dept_code                                                                  " +   
				"			and a.APPROYM 		  = b.approym                                                                    " +      
				"			and a.APPROSEQ 	  = b.approseq                                                                   " +      
				"			and a.chg_cnt		  = b.chg_cnt                                                                    " +      
				"			and b.sbcr_code	  = c.sbcr_code(+)                                                               " +      
				"			and a.DEPT_CODE	  = d.dept_code                                                                  " +      
				"			and a.APPROYM 		  = d.approym                                                                 " +      
				"			and a.APPROSEQ 	  = d.approseq                                                                   " +      
				"			and a.chg_cnt		  = d.chg_cnt                                                                    " +
				"			and a.DEPT_CODE	  = e.dept_code                                                                  " +      
				"			and a.APPROYM 		  = e.approym                                                                    " +      
				"			and a.APPROSEQ 	  = e.approseq                                                                   " +      
				"			and a.chg_cnt		  = e.chg_cnt                                                                    " +
				"			and b.sbcr_code	  = e.sbcr_code(+)                                                               " +      
				"			and a.DEPT_CODE	  = f.dept_code                                                                  " +      
				"			and a.APPROYM 		  = f.approym                                                                    " +      
				"			and a.APPROSEQ 	  = f.approseq                                                                   " +      
				"			and a.chg_cnt		  = f.chg_cnt                                                                    " +
				"			and a.price_class = '0'                                                                            " +          
				"			and a.app_tag = '3'                                                                                " +      
				"			and trunc(a.approdate,'mm') <= '" + arg_yymm + "'                                                  " +       
				"			and a.dept_code = '" + arg_dept_code + "'                                                          " +
				"		union all                                                                                             " +
				"		select 1 tag,											                                                         " +
				"				  a.APPROTITLE, 																											" +	
				"				  nvl(d.exe_amt,0) exe_amt,                                                                     " +   
				"				  nvl(d.bud_amt,0) bud_amt,                                                                     " +   
				"				  nvl(d.amt,0) amt,                                                                             " +
				"				  c.sbcr_name,                                                                                  " +   
				"				  c.rep_name1,                                                                                  " +
				"				  nvl(e.input_amt,0) input_amt,                                                                 " +       
				"				  nvl(e.input_totamt,0) input_totamt,                                                           " +            
				"				  0 input_totamt2							                                                            " +            
				"		 from m_approval a,                                                                                   " +   
				"		 	 m_approval_sbcr b,                                                                                " +
				"			 s_sbcr c,                                                                                         " +
				"			( select a.DEPT_CODE, a.APPROYM,  a.APPROSEQ, a.CHG_CNT,                                           " +
				"			  	    sum(nvl(c.mat_amt,0)) exe_amt, sum(nvl(b.qty,0)*nvl(b.bud_price,0)) bud_amt,                " +
				"			  	    sum(nvl(b.qty,0)*nvl(a.unitprice,0)) amt                                                    " +
				"				from m_approval_detail a,                                                                       " +
				"					m_request_detail b,                                                                          " +
				"					y_budget_detail c                                                                            " +
				"			  where a.dept_code 	      = '" + arg_dept_code + "'                                               " +
				"			    and a.DEPT_CODE 	 	 = b.dept_code                                                             " +   
				"			    and a.request_unq_num 	 = b.request_unq_num                                                    " +
				"			    and a.request_chg_cnt 	 = b.chg_cnt                                                            " +
				"			    and a.DEPT_CODE 	 	 = c.dept_code                                                             " +
				"			    and a.spec_no_seq 	      = c.spec_no_seq(+)                                                   " +     
				"			    and a.spec_unq_num	      = c.spec_unq_num(+)                                                  " +     
				"			  group by a.dept_code, a.APPROYM,  a.APPROSEQ, a.CHG_CNT                                          " + 
				"		     ) d,                                                                                             " +
				"		     (select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code,                              " +
				"				   sum(nvl(c.amt,0)) input_totamt,                                                              " +
				"				   sum(decode(trunc(a.approdate,'mm'),to_date('" + arg_yymm + "'),nvl(c.amt,0),0)) input_amt    " +                                 
				"					from m_approval a,                                                                           " +
				"						m_approval_detail b,                                                                      " +
				"						m_input_detail c                                                                          " +
				"			  where a.dept_code 	  	 = b.dept_code                                                             " +        
				"			    and a.APPROYM 		  	 = b.approym                                                            " +              
				"			    and a.APPROSEQ 	  		 = b.approseq                                                           " +              
				"			    and a.chg_cnt		  	 = b.chg_cnt                                                               " +           
				"			    and a.dept_code 		 = '" + arg_dept_code + "'                                                 " +
				"			    and trunc(a.approdate,'mm') <= '" + arg_yymm + "' 	                                          " +
				"			    and b.DEPT_CODE 	 	 = c.dept_code(+)                                                          " +
				"			    and b.approval_unq_num 	 	 = c.approval_unq_num(+)                                          " +
				"			  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code) e                           " +
				"		where a.dept_code 	  = b.dept_code                                                                  " +   
				"			and a.APPROYM 		  = b.approym                                                                    " +      
				"			and a.APPROSEQ 	  = b.approseq                                                                   " +      
				"			and a.chg_cnt		  = b.chg_cnt                                                                    " +      
				"			and b.sbcr_code	  = c.sbcr_code(+)                                                               " +      
				"			and a.DEPT_CODE	  = d.dept_code                                                                  " +      
				"			and a.APPROYM 		  = d.approym                                                                    " +      
				"			and a.APPROSEQ 	  = d.approseq                                                                   " +      
				"			and a.chg_cnt		  = d.chg_cnt                                                                    " +      
				"			and a.DEPT_CODE	  = e.dept_code                                                                  " +      
				"			and a.APPROYM 		  = e.approym                                                                    " +      
				"			and a.APPROSEQ 	  = e.approseq                                                                   " +      
				"			and a.chg_cnt		  = e.chg_cnt                                                                    " +
				"			and b.sbcr_code	  = e.sbcr_code(+)                                                               " +      
				"			and a.price_class = '1'                                                                            " +          
				"			and a.app_tag = '3'                                                                                " +      
				"			and trunc(a.approdate,'mm') <= '" + arg_yymm + "'                                                  " +       
				"			and a.dept_code = '" + arg_dept_code + "'			                                                   " +
				"		union all                                                                                             " +
				"		select 2 tag,											                                                         " +
				"				  a.APPROTITLE, 																											" +	
				"				  nvl(d.exe_amt,0) exe_amt,                                                                     " +   
				"				  nvl(d.bud_amt,0) bud_amt,                                                                     " +   
				"				  nvl(d.amt,0) amt,                                                                             " +
				"				  c.sbcr_name,                                                                                  " +   
				"				  c.rep_name1,                                                                                  " +
				"				  nvl(e.input_amt,0) input_amt,                                                                 " +       
				"				  nvl(e.input_totamt,0) input_totamt,                                                           " +            
				"				  0 input_totamt2							                                                            " +            
				"		 from m_approval a,                                                                                   " +   
				"		 	 m_approval_sbcr b,                                                                                " +
				"			 s_sbcr c,                                                                                         " +
				"			( select a.DEPT_CODE, a.APPROYM,  a.APPROSEQ, a.CHG_CNT,                                           " +
				"			  	    sum(nvl(c.mat_amt,0)) exe_amt, sum(nvl(b.qty,0)*nvl(b.bud_price,0)) bud_amt,                " +
				"			  	    sum(nvl(b.qty,0)*nvl(a.unitprice,0)) amt                                                    " +
				"				from m_approval_detail a,                                                                       " +
				"					m_request_detail b,                                                                          " +
				"					y_budget_detail c                                                                            " +
				"			  where a.dept_code 	      = '" + arg_dept_code + "'                                               " +
				"			    and a.DEPT_CODE 	 	 = b.dept_code                                                             " +   
				"			    and a.request_unq_num 	 = b.request_unq_num                                                    " +
				"			    and a.request_chg_cnt 	 = b.chg_cnt                                                            " +
				"			    and a.DEPT_CODE 	 	 = c.dept_code                                                             " +
				"			    and a.spec_no_seq 	      = c.spec_no_seq(+)                                                   " +     
				"			    and a.spec_unq_num	      = c.spec_unq_num(+)                                                  " +     
				"			  group by a.dept_code, a.APPROYM,  a.APPROSEQ, a.CHG_CNT                                          " + 
				"		     ) d,                                                                                             " +
				"		     (select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code,                              " +
				"				   sum(nvl(c.amt,0)) input_totamt,                                                              " +
				"				   sum(decode(trunc(a.approdate,'mm'),to_date('" + arg_yymm + "'),nvl(c.amt,0),0)) input_amt    " +                                 
				"					from m_approval a,                                                                           " +
				"						m_approval_detail b,                                                                      " +
				"						m_input_detail c                                                                          " +
				"			  where a.dept_code 	  	 = b.dept_code                                                             " +        
				"			    and a.APPROYM 		  	 = b.approym                                                            " +              
				"			    and a.APPROSEQ 	  		 = b.approseq                                                           " +              
				"			    and a.chg_cnt		  	 = b.chg_cnt                                                               " +           
				"			    and a.dept_code 		 = '" + arg_dept_code + "'                                                 " +
				"			    and trunc(a.approdate,'mm') <= '" + arg_yymm + "' 	                                          " +
				"			    and b.DEPT_CODE 	 	 = c.dept_code(+)                                                          " +
				"			    and b.approval_unq_num 	 	 = c.approval_unq_num(+)                                          " +
				"			  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT, c.sbcr_code) e                           " +
				"		where a.dept_code 	  = b.dept_code                                                                  " +   
				"			and a.APPROYM 		  = b.approym                                                                    " +      
				"			and a.APPROSEQ 	  = b.approseq                                                                   " +      
				"			and a.chg_cnt		  = b.chg_cnt                                                                    " +      
				"			and b.sbcr_code	  = c.sbcr_code(+)                                                               " +      
				"			and a.DEPT_CODE	  = d.dept_code                                                                  " +      
				"			and a.APPROYM 		  = d.approym                                                                    " +      
				"			and a.APPROSEQ 	  = d.approseq                                                                   " +      
				"			and a.chg_cnt		  = d.chg_cnt                                                                    " +      
				"			and a.DEPT_CODE	  = e.dept_code                                                                  " +      
				"			and a.APPROYM 		  = e.approym                                                                    " +      
				"			and a.APPROSEQ 	  = e.approseq                                                                   " +      
				"			and a.chg_cnt		  = e.chg_cnt                                                                    " +
				"			and b.sbcr_code	  = e.sbcr_code(+)                                                               " +      
				"			and a.price_class = '2'                                                                            " +          
				"			and a.app_tag = '3'                                                                                " +      
				"			and trunc(a.approdate,'mm') <= '" + arg_yymm + "'                                                  " +       
				"			and a.dept_code = '" + arg_dept_code + "'	) )	                                                   " +
				"		order by tag, approtitle	                                                                      " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>