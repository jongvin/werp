<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_order_list_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_check_date = dSet.indexOfColumn("check_date");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbc_degree = dSet.indexOfColumn("sbc_degree");
   	int idx_br_date = dSet.indexOfColumn("br_date");
   	int idx_br_place = dSet.indexOfColumn("br_place");
   	int idx_br_jik = dSet.indexOfColumn("br_jik");
   	int idx_br_name = dSet.indexOfColumn("br_name");
   	int idx_opt_jik = dSet.indexOfColumn("opt_jik");
   	int idx_opt_name = dSet.indexOfColumn("opt_name");
   	int idx_br_remark = dSet.indexOfColumn("br_remark");
   	int idx_start_dt = dSet.indexOfColumn("start_dt");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_choice_kind = dSet.indexOfColumn("choice_kind");
   	int idx_pr_dt = dSet.indexOfColumn("pr_dt");
   	int idx_pr_place = dSet.indexOfColumn("pr_place");
   	int idx_previous_pay1 = dSet.indexOfColumn("previous_pay1");
   	int idx_previous_pay2 = dSet.indexOfColumn("previous_pay2");
   	int idx_prgs_pay1 = dSet.indexOfColumn("prgs_pay1");
   	int idx_prgs_pay2 = dSet.indexOfColumn("prgs_pay2");
   	int idx_warrant_rt1 = dSet.indexOfColumn("warrant_rt1");
   	int idx_warrant_rt2 = dSet.indexOfColumn("warrant_rt2");
   	int idx_delay_rt1 = dSet.indexOfColumn("delay_rt1");
   	int idx_delay_rt2 = dSet.indexOfColumn("delay_rt2");
   	int idx_directamt_rt = dSet.indexOfColumn("directamt_rt");
   	int idx_bill_pay = dSet.indexOfColumn("bill_pay");
   	int idx_const_range = dSet.indexOfColumn("const_range");
   	int idx_pay_mat = dSet.indexOfColumn("pay_mat");
   	int idx_mat_etc = dSet.indexOfColumn("mat_etc");
   	int idx_tmp_note = dSet.indexOfColumn("tmp_note");
   	int idx_sbc_guarantee_rt = dSet.indexOfColumn("sbc_guarantee_rt");
   	int idx_warrant_guarantee_rt = dSet.indexOfColumn("warrant_guarantee_rt");
   	int idx_warrant_start_dt = dSet.indexOfColumn("warrant_start_dt");
   	int idx_warrant_end_dt = dSet.indexOfColumn("warrant_end_dt");
   	int idx_warrant_term = dSet.indexOfColumn("warrant_term");
   	int idx_adjust_note = dSet.indexOfColumn("adjust_note");
   	int idx_estimate_dt = dSet.indexOfColumn("estimate_dt");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_ebid_yn = dSet.indexOfColumn("ebid_yn");
   	int idx_cnt_previous_amt = dSet.indexOfColumn("cnt_previous_amt");
   	int idx_vat_rt = dSet.indexOfColumn("vat_rt");
   	int idx_buy_rt = dSet.indexOfColumn("buy_rt");
   	int idx_buy_mat_rt = dSet.indexOfColumn("buy_mat_rt");
   	int idx_open_yn = dSet.indexOfColumn("open_yn");
   	int idx_open_dt = dSet.indexOfColumn("open_dt");
   	int idx_open_per = dSet.indexOfColumn("open_per");
   	int idx_vat_class = dSet.indexOfColumn("vat_class");
   	int idx_bef_order_number = dSet.indexOfColumn("bef_order_number");
   	int idx_re_est_cnt = dSet.indexOfColumn("re_est_cnt");
   	int idx_cancel_yn = dSet.indexOfColumn("cancel_yn");
   	int idx_elec_remark = dSet.indexOfColumn("elec_remark");
   	int idx_wat_remark = dSet.indexOfColumn("wat_remark");
   	int idx_dept_proj_tag = dSet.indexOfColumn("dept_proj_tag");
   	int idx_deliverymethod = dSet.indexOfColumn("deliverymethod");
   	int idx_paymentmethod = dSet.indexOfColumn("paymentmethod");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_order_list ( dept_code," + 
                    "order_number," + 
                    "profession_wbs_code," + 
                    "approve_class," + 
                    "check_date," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "order_name," + 
                    "sbcr_code," + 
                    "sbc_degree," + 
                    "br_date," + 
                    "br_place," + 
                    "br_jik," + 
                    "br_name," + 
                    "opt_jik," + 
                    "opt_name," + 
                    "br_remark," + 
                    "start_dt," + 
                    "end_dt," + 
                    "cnt_amt," + 
                    "exe_amt," + 
                    "choice_kind," + 
                    "pr_dt," + 
                    "pr_place," + 
                    "previous_pay1," + 
                    "previous_pay2," + 
                    "prgs_pay1," + 
                    "prgs_pay2," + 
                    "warrant_rt1," + 
                    "warrant_rt2," + 
                    "delay_rt1," + 
                    "delay_rt2," + 
                    "directamt_rt," + 
                    "bill_pay," + 
                    "const_range," + 
                    "pay_mat," + 
                    "mat_etc," + 
                    "tmp_note," + 
                    "sbc_guarantee_rt," + 
                    "warrant_guarantee_rt," + 
                    "warrant_start_dt," + 
                    "warrant_end_dt," + 
                    "warrant_term," + 
                    "adjust_note," + 
                    "estimate_dt," + 
                    "note ,order_class,ebid_yn,cnt_previous_amt,vat_rt,buy_rt,buy_mat_rt,open_yn,open_dt,open_per,vat_class, " + 
                    "bef_order_number,re_est_cnt,cancel_yn ,elec_remark,wat_remark,dept_proj_tag,deliverymethod,paymentmethod)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, TO_DATE(:11,'yyyy.mm.dd hh24:mi'), :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, TO_DATE(:23,'yyyy.mm.dd hh24:mi'), :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, TO_DATE(:45,'yyyy.mm.dd hh24:mi'), :46 ,:47, :48,:49,:50,:51,:52,:53,:54,:55,:56,:57,:58,:59,:60,:61,:62,:63,:64) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_profession_wbs_code);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_check_date);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_order_name);
      gpstatement.bindColumn(9, idx_sbcr_code);
      gpstatement.bindColumn(10, idx_sbc_degree);
      gpstatement.bindColumn(11, idx_br_date);
      gpstatement.bindColumn(12, idx_br_place);
      gpstatement.bindColumn(13, idx_br_jik);
      gpstatement.bindColumn(14, idx_br_name);
      gpstatement.bindColumn(15, idx_opt_jik);
      gpstatement.bindColumn(16, idx_opt_name);
      gpstatement.bindColumn(17, idx_br_remark);
      gpstatement.bindColumn(18, idx_start_dt);
      gpstatement.bindColumn(19, idx_end_dt);
      gpstatement.bindColumn(20, idx_cnt_amt);
      gpstatement.bindColumn(21, idx_exe_amt);
      gpstatement.bindColumn(22, idx_choice_kind);
      gpstatement.bindColumn(23, idx_pr_dt);
      gpstatement.bindColumn(24, idx_pr_place);
      gpstatement.bindColumn(25, idx_previous_pay1);
      gpstatement.bindColumn(26, idx_previous_pay2);
      gpstatement.bindColumn(27, idx_prgs_pay1);
      gpstatement.bindColumn(28, idx_prgs_pay2);
      gpstatement.bindColumn(29, idx_warrant_rt1);
      gpstatement.bindColumn(30, idx_warrant_rt2);
      gpstatement.bindColumn(31, idx_delay_rt1);
      gpstatement.bindColumn(32, idx_delay_rt2);
      gpstatement.bindColumn(33, idx_directamt_rt);
      gpstatement.bindColumn(34, idx_bill_pay);
      gpstatement.bindColumn(35, idx_const_range);
      gpstatement.bindColumn(36, idx_pay_mat);
      gpstatement.bindColumn(37, idx_mat_etc);
      gpstatement.bindColumn(38, idx_tmp_note);
      gpstatement.bindColumn(39, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(40, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(41, idx_warrant_start_dt);
      gpstatement.bindColumn(42, idx_warrant_end_dt);
      gpstatement.bindColumn(43, idx_warrant_term);
      gpstatement.bindColumn(44, idx_adjust_note);
      gpstatement.bindColumn(45, idx_estimate_dt);
      gpstatement.bindColumn(46, idx_note);
      gpstatement.bindColumn(47, idx_order_class);
      gpstatement.bindColumn(48, idx_ebid_yn);
      gpstatement.bindColumn(49, idx_cnt_previous_amt);
      gpstatement.bindColumn(50, idx_vat_rt);
      gpstatement.bindColumn(51, idx_buy_rt);
      gpstatement.bindColumn(52, idx_buy_mat_rt);
      gpstatement.bindColumn(53, idx_open_yn);
      gpstatement.bindColumn(54, idx_open_dt);
      gpstatement.bindColumn(55, idx_open_per);
      gpstatement.bindColumn(56, idx_vat_class);
      gpstatement.bindColumn(57, idx_bef_order_number);
      gpstatement.bindColumn(58, idx_re_est_cnt);
      gpstatement.bindColumn(59, idx_cancel_yn);
      gpstatement.bindColumn(60, idx_elec_remark);
      gpstatement.bindColumn(61, idx_wat_remark);
      gpstatement.bindColumn(62, idx_dept_proj_tag);
      gpstatement.bindColumn(63, idx_deliverymethod);
      gpstatement.bindColumn(64, idx_paymentmethod);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_order_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "approve_class=?,  " + 
                            "check_date=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "order_name=?,  " + 
                            "sbcr_code=?,  " + 
                            "sbc_degree=?,  " + 
                            "br_date=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "br_place=?,  " + 
                            "br_jik=?,  " + 
                            "br_name=?,  " + 
                            "opt_jik=?,  " + 
                            "opt_name=?,  " + 
                            "br_remark=?,  " + 
                            "start_dt=?,  " + 
                            "end_dt=?,  " + 
                            "cnt_amt=?,  " + 
                            "exe_amt=?,  " + 
                            "choice_kind=?,  " + 
                            "pr_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "pr_place=?,  " + 
                            "previous_pay1=?,  " + 
                            "previous_pay2=?,  " + 
                            "prgs_pay1=?,  " + 
                            "prgs_pay2=?,  " + 
                            "warrant_rt1=?,  " + 
                            "warrant_rt2=?,  " + 
                            "delay_rt1=?,  " + 
                            "delay_rt2=?,  " + 
                            "directamt_rt=?,  " + 
                            "bill_pay=?,  " + 
                            "const_range=?,  " + 
                            "pay_mat=?,  " + 
                            "mat_etc=?,  " + 
                            "tmp_note=?,  " + 
                            "sbc_guarantee_rt=?,  " + 
                            "warrant_guarantee_rt=?,  " + 
                            "warrant_start_dt=?,  " + 
                            "warrant_end_dt=?,  " + 
                            "warrant_term=?,  " + 
                            "adjust_note=?,  " + 
                            "estimate_dt=TO_DATE(?,'yyyy.mm.dd hh24:mi'),   " + 
                            "note=?,order_class=?,ebid_yn=?,cnt_previous_amt=?,vat_rt=?,buy_rt=?,buy_mat_rt=?, " +
                            "open_yn=?,open_dt=?,open_per=?,vat_class=?, bef_order_number=?,re_est_cnt=?,cancel_yn=?," +
                            "elec_remark=?,wat_remark=?,dept_proj_tag=?,deliverymethod=?,paymentmethod=? " +
                            "  where (dept_code=? and order_number=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_profession_wbs_code);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_check_date);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_order_name);
      gpstatement.bindColumn(9, idx_sbcr_code);
      gpstatement.bindColumn(10, idx_sbc_degree);
      gpstatement.bindColumn(11, idx_br_date);
      gpstatement.bindColumn(12, idx_br_place);
      gpstatement.bindColumn(13, idx_br_jik);
      gpstatement.bindColumn(14, idx_br_name);
      gpstatement.bindColumn(15, idx_opt_jik);
      gpstatement.bindColumn(16, idx_opt_name);
      gpstatement.bindColumn(17, idx_br_remark);
      gpstatement.bindColumn(18, idx_start_dt);
      gpstatement.bindColumn(19, idx_end_dt);
      gpstatement.bindColumn(20, idx_cnt_amt);
      gpstatement.bindColumn(21, idx_exe_amt);
      gpstatement.bindColumn(22, idx_choice_kind);
      gpstatement.bindColumn(23, idx_pr_dt);
      gpstatement.bindColumn(24, idx_pr_place);
      gpstatement.bindColumn(25, idx_previous_pay1);
      gpstatement.bindColumn(26, idx_previous_pay2);
      gpstatement.bindColumn(27, idx_prgs_pay1);
      gpstatement.bindColumn(28, idx_prgs_pay2);
      gpstatement.bindColumn(29, idx_warrant_rt1);
      gpstatement.bindColumn(30, idx_warrant_rt2);
      gpstatement.bindColumn(31, idx_delay_rt1);
      gpstatement.bindColumn(32, idx_delay_rt2);
      gpstatement.bindColumn(33, idx_directamt_rt);
      gpstatement.bindColumn(34, idx_bill_pay);
      gpstatement.bindColumn(35, idx_const_range);
      gpstatement.bindColumn(36, idx_pay_mat);
      gpstatement.bindColumn(37, idx_mat_etc);
      gpstatement.bindColumn(38, idx_tmp_note);
      gpstatement.bindColumn(39, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(40, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(41, idx_warrant_start_dt);
      gpstatement.bindColumn(42, idx_warrant_end_dt);
      gpstatement.bindColumn(43, idx_warrant_term);
      gpstatement.bindColumn(44, idx_adjust_note);
      gpstatement.bindColumn(45, idx_estimate_dt);
      gpstatement.bindColumn(46, idx_note);
      gpstatement.bindColumn(47, idx_order_class);
      gpstatement.bindColumn(48, idx_ebid_yn);
      gpstatement.bindColumn(49, idx_cnt_previous_amt);
      gpstatement.bindColumn(50, idx_vat_rt);
      gpstatement.bindColumn(51, idx_buy_rt);
      gpstatement.bindColumn(52, idx_buy_mat_rt);
      gpstatement.bindColumn(53, idx_open_yn);
      gpstatement.bindColumn(54, idx_open_dt);
      gpstatement.bindColumn(55, idx_open_per);
      gpstatement.bindColumn(56, idx_vat_class);
      gpstatement.bindColumn(57, idx_bef_order_number);
      gpstatement.bindColumn(58, idx_re_est_cnt);
      gpstatement.bindColumn(59, idx_cancel_yn);
      gpstatement.bindColumn(60, idx_elec_remark);
      gpstatement.bindColumn(61, idx_wat_remark);
      gpstatement.bindColumn(62, idx_dept_proj_tag);
      gpstatement.bindColumn(63, idx_deliverymethod);
      gpstatement.bindColumn(64, idx_paymentmethod);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(65, idx_dept_code);
      gpstatement.bindColumn(66, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_order_list where (dept_code=? and order_number=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>