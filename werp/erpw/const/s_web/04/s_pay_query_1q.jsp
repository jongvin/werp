<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymmdd = req.getParameter("arg_yymmdd");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prgs_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("checker",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("check_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_cond",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_sbc_deduction",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_advance_deduction",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_employ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_etc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_deduction_detail",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pre_purchase_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_misctax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_misctax_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_netpay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_pay",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_bill",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_sbc_deduction",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_advance_deduction",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_employ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_etc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_deduction_detail",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("tm_purchase_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_misctax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_misctax_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_netpay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_pay",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_bill",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price_pay_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mediation_reason",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("mediation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mediation_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mediation_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1024));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("supply_amt_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misctax_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misctax_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("purchase_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("insurance1_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("close_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("slipcomp",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("slipseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("email",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("tax_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_notax_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("purchase_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("notax_sup_pur_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("notax_pre_sup_pur_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("notax_tm_sup_pur_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("notax_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_pre_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_tm_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_pre_tm_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_advance_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_vat_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("netpay_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_cash_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_bill_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_employ_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_etc_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_sbc_vat_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_tm_netpay_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_netpay_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_sbc_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_sbc_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_sbc_bill",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("web_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("kind_bussinesstype",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("kinditem",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pre_pre_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_pre_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_pre_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_pre_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_pre_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_pre_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("safety_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("safety_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_pre_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_pre_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_pre_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_vat1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_vat2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_vat3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_vat4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_cash_rt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("t_slip_no",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("t_slip_chk",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("guarantee_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,10,0));
    String query = "  SELECT a.dept_code,   " + 
     "         to_char(a.yymm,'yyyy.mm.dd') yymm,   " + 
     "         a.seq,   " + 
     "         a.order_number,   " + 
     "         a.prgs_degree,   " + 
     "         to_char(a.prgs_start_dt,'yyyy.mm.dd') prgs_start_dt,   " + 
     "         to_char(a.prgs_end_dt,'yyyy.mm.dd') prgs_end_dt,   " + 
     "         a.checker,   " + 
     "         to_char(a.check_dt,'yyyy.mm.dd') check_dt,   " + 
     "         to_char(a.pay_dt,'yyyy.mm.dd') pay_dt,   " + 
     "         a.pay_cond,   " + 
     "         a.pre_prgs,   " + 
     "         a.pre_prgs_notax,   " + 
     "         a.pre_sbc_deduction,   " + 
     "         a.pre_advance_deduction,   " + 
     "         a.pre_employ_amt,   " + 
     "         a.pre_etc_amt,   " + 
     "         a.pre_deduction_detail,   " + 
     "         a.pre_purchase_vat,   " + 
     "         a.pre_misctax,   " + 
     "         a.pre_misctax_notax,   " + 
     "         a.pre_vat,   " + 
     "         a.pre_netpay_amt,   " + 
     "         a.pre_pay,   " + 
     "         a.pre_cash,   " + 
     "         a.pre_bill,   " + 
     "         a.tm_prgs,   " + 
     "         a.tm_prgs_notax,   " + 
     "         a.tm_sbc_deduction,   " + 
     "         a.tm_advance_deduction,   " + 
     "         a.tm_employ_amt,   " + 
     "         a.tm_etc_amt,   " + 
     "         a.tm_deduction_detail,   " + 
     "         a.tm_purchase_vat,   " + 
     "         a.tm_misctax,   " + 
     "         a.tm_misctax_notax,   " + 
     "         a.tm_vat,   " + 
     "         a.tm_netpay_amt,   " + 
     "         a.tm_pay,   " + 
     "         a.tm_cash,   " + 
     "         a.tm_bill,   " + 
     "         to_char(a.price_pay_dt,'yyyy.mm.dd') price_pay_dt,   " + 
     "         a.mediation_reason,   " + 
     "         a.mediation_amt,   " + 
     "         to_char(a.mediation_dt,'yyyy.mm.dd') mediation_dt,   " + 
     "         a.mediation_vat," + 
     "         a.remark,   " + 
     "         b.sbc_name," + 
     "         b.supply_amt_tax," + 
     "         b.supply_amt_notax," + 
     "         b.misctax_tax," + 
     "         b.misctax_notax," + 
     "         b.purchase_vat," + 
     "         b.sbc_amt sbc_amt," + 
     "         b.previous_amt," + 
     "         b.insurance1_amt1," + 
     "         b.vat," + 
     "         b.close_tag," + 
     "         b.pay_guarantee_amt," + 
//     "         b.previous_amt - b.previous_vat comp_amt," + 
     "         b.safety_amt1 + b.safety_amt2 comp_amt," + 
     "         a.slipcomp," + 
     "         a.slipseq, " +
     "         d.sbcr_code," + 
     "         d.sbcr_name," + 
     "         d.rep_email  email," + 
     "         (a.pre_prgs + a.tm_prgs)  tax_tot," + 
     "         (a.pre_prgs_notax + a.tm_prgs_notax)  supply_notax_tot," + 
     "         (a.pre_purchase_vat + a.tm_purchase_vat)  purchase_tot," + 
     "         (b.supply_amt_notax + b.misctax_notax + b.purchase_vat)  notax_sup_pur_tot," + 
     "         (a.pre_prgs_notax + a.pre_misctax_notax + a.pre_purchase_vat)  notax_pre_sup_pur_tot," + 
     "         (a.tm_prgs_notax + a.tm_purchase_vat)  notax_tm_sup_pur_tot," + 
     "         (a.pre_prgs_notax + a.pre_misctax_notax + a.pre_purchase_vat + a.tm_prgs_notax + a.tm_purchase_vat)  notax_tot," + 
     "         (a.pre_prgs + a.pre_prgs_notax + a.pre_misctax_notax + a.pre_purchase_vat)  comp_pre_tot," + 

     "         (a.tm_prgs + a.tm_prgs_notax + a.tm_purchase_vat)  comp_tm_tot," + 
     "         (a.pre_prgs + a.pre_prgs_notax + a.pre_misctax_notax + a.pre_purchase_vat + a.tm_prgs + a.tm_prgs_notax + a.tm_purchase_vat)  comp_pre_tm_tot," + 
     "         (a.pre_advance_deduction + a.tm_advance_deduction)  comp_advance_amt," + 
     "         (a.pre_pay + a.tm_pay)  comp_pay_amt," + 
     "         (a.pre_vat + a.tm_vat)  comp_vat_tot," + 
     "         (a.pre_netpay_amt + a.tm_netpay_amt)  netpay_tot," + 
     "         (a.pre_cash + a.tm_cash)  comp_cash_tot," + 
     "         (a.pre_bill + a.tm_bill)  comp_bill_tot," + 
     "         (a.pre_employ_amt + a.tm_employ_amt)  comp_employ_tot," + 
     "         (a.pre_etc_amt + a.tm_etc_amt)  comp_etc_tot," + 
//     "         (b.sbc_amt  - b.vat - ( b.previous_amt - b.previous_vat) )  comp_sbc_vat_tot," + 
     "         (b.sbc_amt  - b.vat - ( b.safety_amt1 + b.safety_amt2 ) )  comp_sbc_vat_tot," + 
     "         (a.tm_pay  + a.tm_vat )  pre_tm_netpay_tot," + 
     "         (a.pre_netpay_amt + tm_netpay_amt)  comp_netpay_tot," + 
     "         (b.supply_amt_tax + b.supply_amt_notax + b.misctax_notax + b.purchase_vat)  comp_sbc_tot," + 
//     "         (b.sbc_amt  - b.previous_amt ) * NVL(b.prgs_cash_rt,0) / 100  comp_sbc_cash," + 
//     "         (b.sbc_amt  - b.previous_amt ) - ((b.sbc_amt - b.previous_amt  ) * NVL(b.prgs_cash_rt,0) / 100)  comp_sbc_bill," + 
     "         (b.sbc_amt  - ( b.safety_amt1 + b.safety_amt2 + b.previous_vat) ) * NVL(b.prgs_cash_rt,0) / 100  comp_sbc_cash," + 
     "         (b.sbc_amt  - ( b.safety_amt1 + b.safety_amt2 + b.previous_vat) ) - ((b.sbc_amt - ( b.safety_amt1 + b.safety_amt2 + b.previous_vat)) * NVL(b.prgs_cash_rt,0) / 100)  comp_sbc_bill," + 
     "         a.web_yn ,a.invoice_num ," + 
     "         decode(length(d.businessman_number),10,substrb(d.businessman_number,1,3) || '-' || substrb(d.businessman_number,4,2) || '-' || substrb(d.businessman_number,6,5),substrb(d.businessman_number,1,6) || '-' || substrb(d.businessman_number,7,7)) cust_code, " +
     "         d.rep_name1, " +
     "         d.address1," +
     "         d.kind_bussinesstype, " +
     "         d.kinditem, " +
     "         a.pre_pre_tax, " +
     "         a.pre_pre_notax," +
     "         a.pre_pre_vat, " +
     "         a.tm_pre_tax, " +
     "         a.tm_pre_notax," +
     "         a.tm_pre_vat, " +
     "         b.previous_vat, " +
     "         b.safety_amt1, " +
     "         b.safety_amt2, " +
     "         a.pre_pre_tax + a.tm_pre_tax     tot_pre_tax, " +
     "         a.pre_pre_notax + a.tm_pre_notax tot_pre_notax, " +
     "         a.pre_pre_vat + a.tm_pre_vat     tot_pre_vat, " +
     "         b.vat - b.previous_vat   tot_vat1, " +
     "         a.pre_vat - a.pre_pre_vat tot_vat2, " +
     "         a.tm_vat  - a.tm_pre_vat  tot_vat3, " +
     "         (a.pre_vat - a.pre_pre_vat) + (a.tm_vat  - a.tm_pre_vat) tot_vat4, " +
     "         b.prgs_cash_rt ," +
     "         decode(a.invoice_num ,null,null,f_slip_no(a.invoice_num)) t_slip_no," +
     "         decode(a.invoice_num,null,'0',f_slip_status(a.invoice_num)) t_slip_chk ," +
     "         b.guarantee_yn ," +
     "         b.sbc_guarantee_rt, " +
     "         a.chg_degree " +
     "    FROM  (select a.* , b.chg_degree " + 
     "              from s_pay a, " + 
     "                   s_pay_degree b   " + 
     "              where a.dept_code = b.dept_code (+) " + 
     "                and a.yymm = b.yymm (+) " + 
     "                and a.seq = b.seq (+)" + 
     "                and a.order_number = b.order_number (+) ) a, " + 
     "         s_cn_list  b," + 
     "         s_sbcr d," + 
     "         ( select dept_code,order_number,nvl(sum(guarantee_amt),0) comp_amt" + 
     "             from s_guarantee_accept" + 
     "            where guarantee_class = '2'" + 
     "         group by dept_code,order_number) c" + 
     "   WHERE ( b.sbcr_code = d.sbcr_code ) and" + 
     "         ( a.dept_code = c.dept_code(+))  and" + 
     "         ( a.order_number = c.order_number(+)) and" + 
     "         ( b.dept_code = a.dept_code ) and  " + 
     "         ( b.order_number = a.order_number ) and" + 
     "         ( ( a.dept_code = '" + arg_dept_code + "' ) AND  " + 
     "           ( a.yymm = '" + arg_yymmdd + "') AND  " + 
     "           ( a.seq = " + arg_seq + " ) )   " + 
     "ORDER BY a.dept_code ASC," + 
     "         a.yymm ASC,   " + 
     "         a.seq ASC,  " + 
     "			a.order_number DESC,      " + 
     "         a.prgs_degree ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>