<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("s_order_wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("check_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbc_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("br_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("br_place",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("br_jik",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("br_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("opt_jik",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("opt_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("br_remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("choice_kind",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pr_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pr_place",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("previous_pay1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_pay2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("prgs_pay1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("prgs_pay2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("warrant_rt1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_rt2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("delay_rt1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("delay_rt2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("directamt_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bill_pay",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_range",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("pay_mat",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("mat_etc",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tmp_note",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("warrant_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("warrant_term",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("adjust_note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("estimate_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cnt_previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("buy_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("buy_mat_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("chg_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bill_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("open_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("open_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vat_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bef_order_number",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("re_est_cnt",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("elec_remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("wat_remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("deliverymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.dept_code dept_code,   " + 
     "         a.order_number order_number,   " + 
     "         a.profession_wbs_code profession_wbs_code,   " + 
     "         b.profession_wbs_name s_order_wbs_name," + 
     "         a.approve_class approve_class,   " + 
     "         to_char(a.check_date,'yyyy.mm.dd') check_date,   " + 
     "         to_char(a.request_dt,'yyyy.mm.dd') request_dt,   " + 
     "         to_char(a.approve_dt,'yyyy.mm.dd') approve_dt,   " + 
     "         a.order_name order_name,   " + 
     "         a.sbcr_code sbcr_code,   " + 
     "         a.sbc_degree sbc_degree,   " + 
     "         to_char(a.br_date,'yyyy.mm.dd hh24:mi') br_date,   " + 
     "         a.br_place br_place,    " + 
     "         a.br_jik br_jik,   " + 
     "         a.br_name br_name,   " + 
     "         a.opt_jik opt_jik,   " + 
     "         a.opt_name opt_name,   " + 
     "         a.br_remark br_remark,   " + 
     "         to_char(a.start_dt,'yyyy.mm.dd') start_dt,   " + 
     "         to_char(a.end_dt,'yyyy.mm.dd') end_dt,   " + 
     "         a.cnt_amt cnt_amt,   " + 
     "         a.exe_amt exe_amt,   " + 
     "         a.choice_kind choice_kind,   " + 
     "         to_char(a.pr_dt,'yyyy.mm.dd hh24:mi') pr_dt,   " + 
     "         a.pr_place pr_place,   " + 
     "         a.previous_pay1 previous_pay1,   " + 
     "         a.previous_pay2 previous_pay2,   " + 
     "         a.prgs_pay1 prgs_pay1,   " + 
     "         a.prgs_pay2 prgs_pay2,   " + 
     "         a.warrant_rt1 warrant_rt1,   " + 
     "         a.warrant_rt2 warrant_rt2,   " + 
     "         a.delay_rt1 delay_rt1,   " + 
     "         a.delay_rt2 delay_rt2,   " + 
     "         a.directamt_rt directamt_rt,   " + 
     "         a.bill_pay bill_pay," + 
     "         a.const_range const_range,   " + 
     "         a.pay_mat pay_mat,   " + 
     "         a.mat_etc mat_etc,   " + 
     "         a.tmp_note tmp_note,   " + 
     "         a.sbc_guarantee_rt sbc_guarantee_rt,   " + 
     "         a.warrant_guarantee_rt warrant_guarantee_rt,   " + 
     "         to_char(a.warrant_start_dt,'yyyy.mm.dd') warrant_start_dt,   " + 
     "         to_char(a.warrant_end_dt,'yyyy.mm.dd') warrant_end_dt,   " + 
     "         a.warrant_term warrant_term,   " + 
     "         a.adjust_note adjust_note,   " + 
     "         to_char(a.estimate_dt,'yyyy.mm.dd hh24:mi') estimate_dt,   " + 
     "         a.note  note," + 
     "         a.order_class, a.ebid_yn,a.cnt_previous_amt,vat_rt,buy_rt,buy_mat_rt, " +
     "         to_char(c.chg_const_start_date,'yyyy.mm.dd') chg_start_dt, " +
     "         to_char(c.chg_const_end_date,'YYYY.MM.DD') chg_end_dt , 100 - a.directamt_rt bill_rt," +
     "         a.open_yn, " +
     "         to_char(a.open_dt,'YYYY.MM.DD') open_dt," +
     "         a.open_per ," +
     "         a.vat_class ," +
     "         a.bef_order_number," +
     "         a.re_est_cnt," +
     "         a.cancel_yn ,a.elec_remark,a.wat_remark,a.dept_proj_tag,a.deliverymethod,a.paymentmethod" +
     "    FROM s_order_list a," + 
     "         s_profession_wbs b," + 
     "         z_code_dept c " +
     "   WHERE (a.profession_wbs_code = b.profession_wbs_code (+) " + 
     "     and a.dept_code = c.dept_code " +
     "     and a.approve_class = '3' " +
     "     and a.dept_code = '" + arg_dept_code +"')   " + 
     "   ORDER BY a.order_number DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>
