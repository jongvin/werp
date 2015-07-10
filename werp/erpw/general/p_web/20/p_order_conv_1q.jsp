<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_name = req.getParameter("arg_emp_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empl_numb",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("empl_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("resi_numb",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_site",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("annc_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("annc_kind",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("annc_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pstn_kind",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pstn_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grad_kind",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("paym_step",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("serv_name",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remk_text",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("stat_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seqn_numb",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("clos_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_user",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));	  
	  dSet.addDataColumn(new GauceDataColumn("prev_comp",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("prev_dept_site",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("prev_dept_site_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("prev_pstn",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("prev_pstn_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("prev_grad",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_paym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_serv",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_empl",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_psdt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_grdt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_stdt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prev_mvdt",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("prev_redt",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("ok_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.empl_numb,   " + 
     					 "         b.empl_name,   " + 
     					 "         substr(b.resi_numb,1,6) resi_numb,   " + 
     					 "         a.comp_code,   " + 
     					 "         a.dept_code,    " +
     					 "         to_char(to_date(a.annc_date), 'yyyy.mm.dd') annc_date,   " +
						 "			  a.annc_kind    ,  " +
						 "			  c.code_name annc_name    ,  " +
						 "			  a.prev_comp    ,  " +
						 "			  e.desc_name prev_comp_name    ,  " +		// 전사업체명
						 "			  a.prev_dept_site ,  " +
						 "			  f.code_name  prev_dept_site_name    ,  " +		// 전부서명
						 "			  a.prev_pstn    ,  " +
						 "			  d.code_name prev_pstn_name   ,  " +		// 전직위명
						 "			  a.prev_grad    ,  " +
						 "			  a.prev_paym    ,  " +
						 "			  a.prev_serv    ,  " +
						 "			  a.prev_empl    ,  " +
						 "			  a.prev_psdt    ,  " +
						 "			  a.prev_grdt    ,  " +
						 "			  a.prev_stdt    ,  " +
						 "			  a.prev_mvdt    ,  " +
						 "			  a.prev_redt    ,  " +
						 
						 "			  a.comp_code    ,  " +
						 "			  h.desc_name comp_name    ,  " +		// 사업체명
						 "			  a.dept_site,  " +
						 "			  i.code_name  dept_name  ,  " +		// 부서명
						 "			  a.pstn_kind    ,  " +
						 "			  g.code_name  pstn_name  ,  " +		// 직위명
						 
						 "			  a.grad_kind    ,  " +
						 "			  a.paym_step    ,  " +
						 "			  a.serv_name    ,  " +
						 "			  a.annc_text    ,  " +
						 "			  a.remk_text    ,  " +
						 "			  a.stat_year ||'-0'|| a.seqn_numb  stat_year ,  " +
						 "			  a.seqn_numb    ,  " +
						 "			  a.clos_date    ,  " +
						 "			  a.last_user    ,  " +
						 "			  a.last_dtim    ,  " +
						 "			  a.spec_no_seq  ,  " +
						 "         'F' ok_tag    " +
     					 "    FROM erpc.hrt126        a," + 
     					 "         erpc.hrt110  		b," +
     					 "         erpc.hrt010  		c," +		// 발령
						 "         erpc.hrt010        d," +			// 전직위
						 "	        erpc.act010_con		e," +		// 전사업체
						 "	        erpc.hrv621_con		f," +		// 전부서
						 "         erpc.hrt010        g," +			// 직위
						 "	        erpc.act010_con		h," +		// 사업체
						 "	        erpc.hrv621_con		i " +		// 부서
     					 "	where a.empl_numb = b.empl_numb " +     					 
						 "   and (c.code_type = '25' and a.annc_kind = c.code_kind(+)) " +
						 "   and (d.code_type = '01' and a.prev_pstn = d.code_kind(+)) " +		// 전직위
						 "   and a.prev_comp  = e.old_code(+) " +											// 전사업체
						 "   and (a.prev_dept_site = f.old_code(+) and a.comp_code = f.old_comp(+)) " +   // 전부서
                   
						 "   and (g.code_type = '01' and a.pstn_kind = g.code_kind(+)) " +		// 직위
						 "   and a.comp_code  = h.old_code(+) " +											// 사업체
						 "   and (a.dept_site = i.old_code(+) and a.comp_code = i.old_comp(+)) " +  // 부서
						 
                   "   and b.empl_name = '" + arg_emp_name + "' " +                   
						 " order by a.empl_numb, a.annc_date ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>