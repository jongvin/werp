<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp = '%' + req.getParameter("arg_comp") + '%';
     String arg_date = req.getParameter("arg_date");
     String arg_dept = '%' + req.getParameter("arg_dept") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("s1_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m1_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m2_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m3_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f1_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f2_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f3_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f4_tag",GauceDataColumn.TB_STRING,1));
    String query = " select a.dept_code,a.long_name, " + 
     "       decode(sign(a.s1_no),1,'1',decode(sign(a.s1_pro),1,'2',decode(sign(a.s1_ok),1,'3','4'))) s1_tag," + 
     "       decode(sign(a.m1_no),1,'1',decode(sign(a.m1_pro),1,'2',decode(sign(a.m1_ok),1,'3','4'))) m1_tag," + 
     "       decode(sign(a.m2_no),1,'1',decode(sign(a.m2_pro),1,'2',decode(sign(a.m2_ok),1,'3','4'))) m2_tag," + 
     "       decode(sign(a.m3_no),1,'1',decode(sign(a.m3_pro),1,'2',decode(sign(a.m3_ok),1,'3','4'))) m3_tag," + 
     "       decode(sign(a.f1_no),1,'1',decode(sign(a.f1_pro),1,'2',decode(sign(a.f1_ok),1,'3','4'))) f1_tag," + 
     "       decode(sign(a.f2_no),1,'1',decode(sign(a.f2_pro),1,'2',decode(sign(a.f2_ok),1,'3','4'))) f2_tag," + 
     "       decode(sign(a.f3_no),1,'1',decode(sign(a.f3_pro),1,'2',decode(sign(a.f3_ok),1,'3','4'))) f3_tag," + 
     "       decode(sign(a.f4_no),1,'1',decode(sign(a.f4_pro),1,'2',decode(sign(a.f4_ok),1,'3','4'))) f4_tag" + 
     " from (select max(dept_code) dept_code,max(long_name) long_name,nvl(sum(s1_no),0) s1_no,nvl(sum(s1_pro),0) s1_pro,nvl(sum(s1_ok),0) s1_ok,	" + 
     "				 nvl(sum(m1_no),0) m1_no,nvl(sum(m1_pro),0) m1_pro,nvl(sum(m1_ok),0) m1_ok,nvl(sum(m2_no),0) m2_no,nvl(sum(m2_pro),0) m2_pro," + 
     "				 nvl(sum(m2_ok),0) m2_ok,nvl(sum(m3_no),0) m3_no,nvl(sum(m3_pro),0) m3_pro,nvl(sum(m3_ok),0) m3_ok," + 
     "				 nvl(sum(f1_no),0) f1_no,nvl(sum(f1_pro),0) f1_pro,nvl(sum(f1_ok),0) f1_ok,nvl(sum(f2_no),0) f2_no,nvl(sum(f2_pro),0) f2_pro," + 
     "				 nvl(sum(f2_ok),0) f2_ok,nvl(sum(f3_no),0) f3_no,nvl(sum(f3_pro),0) f3_pro,nvl(sum(f3_ok),0) f3_ok,nvl(sum(f4_no),0) f4_no," + 
     "				 nvl(sum(f4_pro),0) f4_pro,nvl(sum(f4_ok),0) f4_ok" + 
     "		from ( select a.dept_code,a.long_name,b.tmp_no s1_no,c.tmp_pro s1_pro,c.tmp_ok s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from s_pay " + 
     "									  where trunc(yymm,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code,order_number)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from s_pay " + 
     "									  where trunc(yymm,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 b.tmp_no m1_no,c.tmp_pro m1_pro,c.tmp_ok m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from m_vat " + 
     "									  where trunc(work_dt,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code,vat_unq_num)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from m_vat " + 
     "									  where trunc(work_dt,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,b.tmp_no m2_no,c.tmp_pro m2_pro,c.tmp_ok m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from m_output_slip " + 
     "									  where trunc(work_dt,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from m_output_slip " + 
     "									  where trunc(work_dt,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,b.tmp_no m3_no,c.tmp_pro m3_pro,c.tmp_ok m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from m_tmat_proj_rent " + 
     "									  where trunc(month,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from m_tmat_proj_rent " + 
     "									  where trunc(month,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 b.tmp_no f1_no,c.tmp_pro f1_pro,c.tmp_ok f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from f_preamt_request " + 
     "									  where trunc(request_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code,request_date,class)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from f_preamt_request " + 
     "									  where trunc(request_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,b.tmp_no f2_no,c.tmp_pro f2_pro,c.tmp_ok f2_ok,0 f3_no,0 f3_pro,0 f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from f_nopay_request " + 
     "									  where trunc(request_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from f_nopay_request " + 
     "									  where trunc(request_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,b.tmp_no f3_no,c.tmp_pro f3_pro,c.tmp_ok f3_ok,0 f4_no,0 f4_pro,0 f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from f_request " + 
     "									  where trunc(rqst_date,'MM') = '" + arg_date + "'" + 
     "										 and amt <> 0 " + 
     "										 and invoice_num is null" + 
     "								  group by dept_code,rqst_date,slip_seq )" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from f_request " + 
     "									  where trunc(rqst_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null " + 
     "										 and amt <> 0 " + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c" + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+)" + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "'" + 
     "				union all" + 
     "				select a.dept_code,a.long_name,0 s1_no,0 s1_pro,0 s1_ok," + 
     "						 0 m1_no,0 m1_pro,0 m1_ok,0 m2_no,0 m2_pro,0 m2_ok,0 m3_no,0 m3_pro,0 m3_ok," + 
     "						 0 f1_no,0 f1_pro,0 f1_ok,0 f2_no,0 f2_pro,0 f2_ok,0 f3_no,0 f3_pro,0 f3_ok,b.tmp_no f4_no,c.tmp_pro f4_pro,c.tmp_ok f4_ok" + 
     "				from z_code_dept a," + 
     "						( select max(dept_code) dept_code,count(*) tmp_no" + 
     "							from ( select max(dept_code) dept_code" + 
     "										from f_profit_detail " + 
     "									  where trunc(rqst_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is null" + 
     "								  group by dept_code)" + 
     "							group by dept_code ) b," + 
     "					  ( select max(dept_code) dept_code,count(*) - sum(nvl(decode(f_slip_status(invoice_num),9,1,0),0)) tmp_pro,sum(decode(f_slip_status(invoice_num),9,1,0)) tmp_ok" + 
     "							from ( select max(dept_code) dept_code,max(invoice_num) invoice_num" + 
     "										from f_profit_detail " + 
     "									  where trunc(rqst_date,'MM') = '" + arg_date + "'" + 
     "										 and invoice_num is not null" + 
     "									  group by dept_code ,invoice_num) " + 
     "							group by dept_code ) c  "  + 
     "				where a.dept_code = b.dept_code (+)" + 
     "				and a.dept_code = c.dept_code (+) " + 
     "				and a.dept_proj_tag = 'P'" + 
     "				and a.process_code = '01'" + 
     "				and a.comp_code like '" + arg_comp + "')" + 
     "		group by dept_code order by long_name ) a, " +
     "     (  select dept_code from c_spec_const_closing " + 
     "         where trunc(yymm,'MM') = '" + arg_date + "' ) b" + 
     " where a.long_name like '" + arg_dept + "'"  + 
     "   and a.dept_code = b.dept_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>