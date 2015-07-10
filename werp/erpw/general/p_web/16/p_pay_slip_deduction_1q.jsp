<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)-- 
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_ded_kind = req.getParameter("arg_ded_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("paydate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ded_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chk_2",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  to_char(a.paydate,'yyyy.mm.dd') paydate," + 
                   "          a.ded_kind ," + 
                   "          a.comp_code ," + 
                   "          b.comp_name ," + 
                   "          sum(a.self_amt) self_amt ," + 
                   "          sum(a.comp_amt) comp_amt ," + 
                   "          sum(a.real_amt) real_amt ," + 
                   "          a.invoice_num,  " +
                   "          d.approval_num, " +
                   "          decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) chk_1, " + 
     					 "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N'))) chk_2 " + 
     					 "     FROM p_pay_deduction  a,  " +
                   "				z_code_comp    b,   " +
                   "          efin_invoice_header_itf  d " +
     					 "    where a.comp_code = b.comp_code (+) " +
                   "      and a.invoice_num = d.invoice_group_id (+) " +
     					 "      and to_char(a.paydate,'yyyy.mm') = to_char(to_date('"+ arg_work_yymm +"'),'yyyy.mm') " +
                   "      and a.ded_kind = '"+ arg_ded_kind +"' " +
                   " group by a.paydate ," + 
                   "          a.ded_kind ," + 
                   "          a.comp_code ," + 
                   "          b.comp_name ," + 
                   "          a.invoice_num,  " +
                   "          d.approval_num, " +
                   "          decode(d.complete_flag,'1','결재중',decode(d.complete_flag,'3','반송',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'결재완료','취소전표')))) , " + 
     					 "          decode(d.complete_flag,null,'Y',decode(d.complete_flag,'3','Y',decode(d.complete_flag,'9',decode(d.relation_invoice_group_id,null,'N','Y'),'N')))  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>