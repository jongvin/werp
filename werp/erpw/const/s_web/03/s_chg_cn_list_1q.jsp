<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("chg_resign",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("close_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("check_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("choice_rival",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("choice_kind",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("proj_scale",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("const_place",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("plan_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("page_count",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("book_count",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_mat",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("mat_etc",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misctax_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("misctax_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("purchase_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("stamp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_ctrl_dt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_pay_count",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_cash_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("prgs_bill_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bill_cond",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("delay_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_pay_dt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_amt_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_pay_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("previous_checker",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("previous_check_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("previous_deduction_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("delay_pay_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("insurance1_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("insurance1_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("insurance2_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("insurance2_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("safety_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("safety_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_issueday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_number",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_kind",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_issueday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_number",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_kind",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("warrant_term",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_issueday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_number",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("pay_guarantee_kind",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("guarantee_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("guarantee_rep_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("guarantee_address",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rep_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_address",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1024));
     dSet.addDataColumn(new GauceDataColumn("insurance_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ta_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("previous_pay1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("req_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("charge",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("pre_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_notax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_noamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_tag5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bill_day",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("comm_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("acc_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("emp_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("nosend1",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend2",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend3",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend4",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend5",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend6",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend7",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend8",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("nosend9",GauceDataColumn.TB_STRING,200));
     
    String query = "  SELECT a.dept_code,   " + 
     "         a.order_number,   " + 
     "         a.chg_degree,   " + 
     "         a.sbcr_code,   " + 
     "         a.chg_resign," + 
     "         a.close_tag,   " + 
     "         a.approve_class,   " + 
     "         to_char(a.check_dt,'yyyy.mm.dd') check_dt,   " + 
     "         to_char(a.request_dt,'yyyy.mm.dd') request_dt,   " + 
     "         to_char(a.approve_dt,'yyyy.mm.dd')  approve_dt,  " + 
     "         a.order_name,   " + 
     "         a.sbc_name,   " + 
     "         to_char(a.sbc_dt,'yyyy.mm.dd') sbc_dt,   " + 
     "         a.sbc_section,   " + 
     "         NVL(a.choice_rival,0) choice_rival,   " + 
     "         a.choice_kind,   " + 
     "         a.proj_scale,   " + 
     "         a.const_place,   " + 
     "         to_char(a.plan_start_dt,'yyyy.mm.dd') plan_start_dt,   " + 
     "         to_char(a.plan_end_dt,'yyyy.mm.dd') plan_end_dt,   " + 
     "         to_char(a.start_dt,'yyyy.mm.dd') start_dt,   " + 
     "         to_char(a.end_dt,'yyyy.mm.dd') end_dt,   " + 
     "         NVL(a.page_count,0) page_count,   " + 
     "         NVL(a.book_count,0) book_count,   " + 
     "         a.pay_mat,   " + 
     "         a.mat_etc,   " + 
     "         NVL(a.cnt_amt,0) cnt_amt,   " + 
     "         NVL(a.exe_amt,0) exe_amt,   " + 
     "         NVL(a.supply_amt_tax,0) supply_amt_tax,    " + 
     "         NVL(a.supply_amt_notax,0) supply_amt_notax,   " + 
     "         NVL(a.misctax_tax,0)  misctax_tax,  " + 
     "         NVL(a.misctax_notax,0) misctax_notax,   " + 
     "         NVL(a.purchase_vat,0) purchase_vat,   " + 
     "         NVL(a.sbc_amt,0) sbc_amt,   " + 
     "         NVL(a.vat,0) vat,   " + 
     "         nvl(a.stamp,0) stamp,   " + 
     "         NVL(a.prgs_ctrl_dt,0) prgs_ctrl_dt,   " + 
     "         NVL(a.prgs_pay_count,0) prgs_pay_count,   " + 
     "         NVL(a.prgs_cash_rt,0) prgs_cash_rt,   " + 
     "         NVL(a.prgs_bill_rt,0)  prgs_bill_rt,  " + 
     "         a.bill_cond,   " + 
     "         NVL(a.delay_rt,0) delay_rt,   " + 
     "         NVL(a.previous_pay_dt,0) previous_pay_dt,   " + 
     "         NVL(a.previous_amt_rt,0) previous_amt_rt,   " + 
     "         NVL(a.previous_amt,0) previous_amt,   " + 
     "         NVL(a.previous_vat,0) previous_vat,  " + 
     "         a.previous_pay_tag,   " + 
     "         a.previous_checker,   " + 
     "         to_char(a.previous_check_dt,'yyyy.mm.dd') previous_check_dt,   " + 
     "         NVL(a.previous_deduction_rt,0) previous_deduction_rt,   " + 
     "         NVL(a.delay_amt,0) delay_amt,   " + 
     "         to_char(a.delay_dt,'yyyy.mm.dd') delay_dt,   " + 
     "         to_char(a.delay_pay_dt,'yyyy.mm.dd') delay_pay_dt,   " + 
     "         NVL(a.insurance1_amt1,0) insurance1_amt1,   " + 
     "         NVL(a.insurance1_amt2,0) insurance1_amt2,   " + 
     "         a.insurance2_name,   " + 
     "         NVL(a.insurance2_amt1,0)  insurance2_amt1,  " + 
     "         NVL(a.safety_amt1,0) safety_amt1,   " + 
     "         NVL(a.safety_amt2,0) safety_amt2,   " + 
     "         to_char(a.sbc_guarantee_issueday,'yyyy.mm.dd') sbc_guarantee_issueday,   " + 
     "         NVL(a.sbc_guarantee_rt,0) sbc_guarantee_rt,   " + 
     "         NVL(a.sbc_guarantee_amt,0) sbc_guarantee_amt,   " + 
     "         to_char(a.sbc_guarantee_start_dt,'yyyy.mm.dd') sbc_guarantee_start_dt,   " + 
     "         to_char(a.sbc_guarantee_end_dt,'yyyy.mm.dd') sbc_guarantee_end_dt,   " + 
     "         a.sbc_guarantee_number,   " + 
     "         a.sbc_guarantee_kind,   " + 
     "         to_char(a.warrant_guarantee_issueday,'yyyy.mm.dd') warrant_guarantee_issueday,   " + 
     "         NVL(a.warrant_guarantee_rt,0) warrant_guarantee_rt,   " + 
     "         NVL(a.warrant_guarantee_amt,0)  warrant_guarantee_amt,  " + 
     "         to_char(a.warrant_guarantee_start_dt,'yyyy.mm.dd') warrant_guarantee_start_dt,   " + 
     "         to_char(a.warrant_guarantee_end_dt,'yyyy.mm.dd') warrant_guarantee_end_dt,   " + 
     "         a.warrant_guarantee_number,   " + 
     "         a.warrant_guarantee_kind,   " + 
     "         a.warrant_term,   " + 
     "         to_char(a.pay_guarantee_issueday,'yyyy.mm.dd') pay_guarantee_issueday,   " + 
     "         NVL(a.pay_guarantee_amt,0)  pay_guarantee_amt,  " + 
     "         to_char(a.pay_guarantee_start_dt,'yyyy.mm.dd') pay_guarantee_start_dt,   " + 
     "         to_char(a.pay_guarantee_end_dt,'yyyy.mm.dd') pay_guarantee_end_dt,   " + 
     "         a.pay_guarantee_number,   " + 
     "         a.pay_guarantee_kind,   " + 
     "         a.guarantee_name,   " + 
     "         a.guarantee_rep_name,   " + 
     "         a.guarantee_address,   " + 
     "         a.sbc_guarantee_name,   " + 
     "         a.sbc_guarantee_rep_name,   " + 
     "         a.sbc_guarantee_address,   " + 
     "         a.remark,   " + 
     "         a.insurance_yn insurance_yn, " + 
     "         a.ta_tag," + 
     "         b.sbcr_name sbcr_name, " + 
     "         a.previous_pay1, a.cnt_previous_amt,a.guarantee_yn,a.order_class,a.ebid_yn, " +
     "         a.const_no,to_char(a.req_dt,'yyyy.mm.dd') req_dt,to_char(a.bonsa_dt,'yyyy.mm.dd') bonsa_dt, " +
     "         to_char(a.sbcr_dt,'yyyy.mm.dd') sbcr_dt,a.charge ,a.vatcode," +
	  "         trunc(a.previous_amt_rt * a.supply_amt_tax / 100,0) pre_tax," +
	  "         trunc(a.previous_amt_rt * a.supply_amt_notax / 100,0) pre_notax," +
	  "         nvl(a.supply_amt_notax,0) + nvl(a.purchase_vat,0) tot_noamt ," +
	  "         a.guarantee_tag1,a.guarantee_tag2,a.guarantee_tag3,a.guarantee_tag4,a.guarantee_tag5,a.bill_day, " +
	  "			a.comm_tag,a.acc_tag, a.emp_class, " +
	  "			a.nosend1,a.nosend2,a.nosend3,a.nosend4,a.nosend5,a.nosend6,a.nosend7,a.nosend8,a.nosend9 " +
     "    FROM s_sbcr b,   " + 
     "         s_chg_cn_list a " + 
     "   WHERE ( b.sbcr_code = a.sbcr_code ) and  " + 
     "         (  a.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( a.order_number = " + arg_order_number + ")   " + 
     "            " + 
     " ORDER BY    " + 
     "         a.chg_degree DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>