<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("APPROTITLE",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_totamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("rem_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select 																													" +
    	"						APPROTITLE,                                                                               " +
      "                  sbcr_name,                                                                               " +
      "                  rep_name1,                                                                               " +
    	"						decode(drank,1,exe_amt,0) exe_amt,                                                        " +
    	"						decode(drank,1,bud_amt,0) bud_amt,                                                        " +
    	"						decode(drank,1,amt,0) amt,                                                                " +
    	"						decode(drank,1,input_totamt,0) input_totamt,                                              " +
    	"						decode(drank,1,rate,0) rate,                                                              " +
    	"						decode(drank,1,rem_amt,0) rem_amt,            		                                       " +
    	"						decode(drank,1,input_amt,0) input_amt                                                     " +
		"			from                                                                                               " +
		"    		(	select RANK() OVER (PARTITION BY a.APPROTITLE ORDER BY c.sbcr_name) drank,								" +			
		"    	 			  a.APPROTITLE, 																										" +		
		"					  c.sbcr_name,                                                                               " +      
		"					  c.rep_name1,                                                                               " +      
		"					  nvl(d.exe_amt,0) exe_amt,                                                                  " +      
		"					  nvl(d.bud_amt,0) bud_amt,                                                                  " +      
		"					  nvl(a.amt,0) amt,				                                                               " +      
		"					  nvl(e.input_totamt,0) input_totamt,                                                        " +      
		"					  decode(nvl(a.amt,0),0,0,(nvl(e.input_totamt,0)/nvl(a.amt,0))*100) rate,                    " +      
		"					  nvl(a.amt,0) - nvl(e.input_totamt,0) rem_amt,                                              " +      
		"					  nvl(e.input_amt,0) input_amt                                                               " +      
		"			 from m_approval a,                                                                                " +      
		"			 		 m_approval_sbcr b,                                                                          " +      
		"					 s_sbcr c,                                                                                   " +      
		"					( select a.DEPT_CODE, a.APPROYM, a.APPROSEQ, a.CHG_CNT,                                      " +      
		"					  	    sum(nvl(c.mat_amt,0)) exe_amt, sum(nvl(b.BUD_AMT,0)) bud_amt                          " +      
		"						from m_approval_detail a,                                                                 " +      
		"							m_request_detail b,                                                                    " +      
		"							y_budget_detail c                                                                      " +      
		"					  where a.dept_code = '" + arg_dept_code + "'                                                " +      
		"					    and a.DEPT_CODE 	 = b.dept_code                                                          " +      
		"					    and a.request_unq_num 	 = b.request_unq_num                                              " +      
		"					    and a.request_chg_cnt 	 = b.chg_cnt                                                      " +      
		"					    and a.DEPT_CODE 	 	 = c.dept_code                                                       " +      
		"					    and a.spec_no_seq 	 = c.spec_no_seq(+)                                                  " +      
		"					    and a.spec_unq_num	 = c.spec_unq_num(+)                                                 " +      
		"					  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT                                     " +      
		"					   ) d,                                                                                      " +      
		"					( select a.dept_code, a.approym, a.approseq, a.chg_cnt, a.input_amt, b.input_totamt          " +      
		"						from                                                                                      " +      
		"							(select a.DEPT_CODE, to_char(a.APPROYM,'yyyy.mm.dd') approym, a.APPROSEQ, a.CHG_CNT,   " +      
		"									  	    sum(nvl(b.amt,0)) input_amt, 0 input_totamt                               " +      
		"										from m_approval_detail a,                                                     " +      
		"											m_input_detail b                                                           " +      
		"									  where a.dept_code = '" + arg_dept_code + "'                                    " +      
		"									    and a.DEPT_CODE 	 		 	= b.dept_code(+)                                   " +      
		"									    and a.approval_unq_num 	= b.approval_unq_num(+)                            " +      
		"									  group by a.dept_code, a.APPROYM, a.APPROSEQ, a.CHG_CNT) a,                     " +      
		"							(select a.DEPT_CODE, '1' , a.APPROSEQ, a.CHG_CNT,                                      " +      
		"									  	    0, sum(nvl(b.amt,0)) input_totamt                                         " +      
		"										from m_approval_detail a,                                                     " +      
		"											m_input_detail b                                                           " +      
		"									  where a.dept_code = '" + arg_dept_code + "'                                    " +      
		"									    and a.DEPT_CODE 	 		 	= b.dept_code(+)                                   " +      
		"									    and a.approval_unq_num 	= b.approval_unq_num(+)                            " +      
		"									  group by a.dept_code, a.APPROSEQ, a.CHG_CNT) b                                 " +      
		"					 where	                                                                                    " +      
		"						a.dept_code = b.dept_code(+)                                                              " +      
		"						and a.approseq = b.approseq(+)		                                                      " +      
		"					   ) e                                                                                       " +      
		"			where a.dept_code 	  = b.dept_code                                                               " +      
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
		"			and a.app_tag = '3'                                                                                " +      
		"			and trunc(a.approdate,'mm') = '" + arg_yymm + "'                                                   " +      
		"			and a.dept_code = '" + arg_dept_code + "'  				)                                            " ;	
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>