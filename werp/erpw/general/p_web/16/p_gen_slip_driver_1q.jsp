<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_work_yymm = req.getParameter("arg_work_yymm");
 //---------------------------------------------------------- 
 	  dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,12,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_code",GauceDataColumn.TB_STRING,10));
    String query = " SELECT decode(b.dept_proj_tag, 'P', '현장', '본사') dept_proj_tag,  " +
						 " 		 decode(b.dept_proj_tag, 'P', b.dept_code, b.level_code) dept_code,  " +
						 " 		 decode(b.dept_proj_tag, 'P', b.short_name, b.title_name) dept_name, " +
						 "	       sum(a.driver_amt) amt,                                                      " +
						 "	       a.invoice_num,                                                      " +
						 "        d.approval_num, " +
                   "        decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) chk_1, " + 
     					 "        decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N'))) chk_2, " + 
     					 "        c.proj_code  " + 
                   "	  FROM p_gen_driver_filial_piety a,                                        " +
						 "	       view_dept_code   b,                                                  " +
						 "        efin_invoice_header_itf  d, " +
						 
						 "          ( SELECT a.dept_code,c.proj_code						" +
                   "  			 	 FROM Z_CODE_DEPT a,									" +
                   "					      (SELECT proj_unq_key,step 					" +
                   "						      FROM r_proj_view_business_form) b,	" +
                   "							R_PROJ c											" +
                   "	  		      WHERE a.proj_unq_key = b.proj_unq_key        " +
                   "				     AND b.proj_unq_key = c.proj_unq_key        " +
                   "				     AND b.step = c.step ) c							" +                    
                   
     					 "	 WHERE a.dept_code = b.dept_code(+)                                        " +
     					 "    and a.dept_code = c.dept_code(+) " +
                   "    and a.invoice_num = d.invoice_group_id (+) 									   " +
     					 "	   and a.comp_code = '"+arg_comp_code+"'                                   " +
						 "	   and a.work_yymm = '"+arg_work_yymm+"'                                   " +
						 "	   and a.div_tag = '1'                                                     " +
						 "	group by b.dept_proj_tag,                     										" +
						 "          decode(b.dept_proj_tag, 'P', b.dept_code, b.level_code),          " +
						 "	   		decode(b.dept_proj_tag, 'P', b.short_name, b.title_name),         " +
						 "	         a.invoice_num,                                                    " +
						 "          d.approval_num, 																	" +
                   "          decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) , " + 
     					 "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N'))),  " + 
     					 "        c.proj_code  " +                    
     					 "	order by b.dept_proj_tag, decode(b.dept_proj_tag, 'P', b.dept_code, b.level_code) ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>