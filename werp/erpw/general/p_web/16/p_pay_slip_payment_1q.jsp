<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_pay_kind = req.getParameter("arg_pay_kind");
     String arg_comp_code = req.getParameter("arg_comp_code");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("paydate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("paykind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("total_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inco_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("resi_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pens_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("medi_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("empl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etcx_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("last_user",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("last_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  to_char(a.paydate,'yyyy.mm.dd') paydate," + 
                   "          a.paykind ," + 
                   "          a.comp_code ," + 
                   "          b.comp_name ," + 
                   "          sum(a.total_amt) total_amt ," + 
                   "          sum(a.total_cnt) total_cnt ," + 
                   "          sum(a.real_amt) real_amt ," + 
                   "          sum(a.inco_tax) inco_tax ," + 
                   "          sum(a.resi_tax) resi_tax ," + 
                   "          sum(a.pens_amt) pens_amt ," + 
                   "          sum(a.medi_amt) medi_amt ," + 
                   "          sum(a.empl_amt) empl_amt ," + 
                   "          sum(a.etcx_amt) etcx_amt ," + 
                   "          a.last_user ," + 
                   "          to_char(a.last_date,'yyyy.mm.dd') last_date ," + 
                   "          a.invoice_num,  " +
                   "          d.approval_num, " +
                   "          decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) chk_1, " + 
     					 "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N'))) chk_2 " + 
     					 "     FROM p_pay_payment  a,  " +
                   "				z_code_comp    b,   " +
                   "          efin_invoice_header_itf  d " +
     					 "    where a.comp_code = b.comp_code(+) " +
                   "      and a.invoice_num = d.invoice_group_id (+) " ;
     					 
     					 if(! arg_comp_code.equals("")) {   //검색조건으로 찾기 
							   query += " and a.comp_code = '" + arg_comp_code + "' ";
						 }
                   
     					 query += "      and to_char(a.paydate,'yyyy.mm') = to_char(to_date('"+ arg_work_yymm +"'),'yyyy.mm') " ;
     					 query += "      and a.paykind = '"+ arg_pay_kind +"' " ;
                   
                   query += " group by a.paydate ," ;
                   query += "          a.paykind ," ; 
                   query += "          a.comp_code ," ;
                   query += "          b.comp_name ," ; 
                   query += "          a.last_user ," ; 
                   query += "          a.last_date ," ; 
                   query += "          a.invoice_num,  " ;
                   query += "          d.approval_num, " ;
                   query += "          decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) , " ;
     					 query += "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N')))  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>