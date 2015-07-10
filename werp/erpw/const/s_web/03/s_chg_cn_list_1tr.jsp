<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_chg_cn_list_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_chg_resign = dSet.indexOfColumn("chg_resign");
   	int idx_close_tag = dSet.indexOfColumn("close_tag");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_check_dt = dSet.indexOfColumn("check_dt");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_sbc_name = dSet.indexOfColumn("sbc_name");
   	int idx_sbc_dt = dSet.indexOfColumn("sbc_dt");
   	int idx_sbc_section = dSet.indexOfColumn("sbc_section");
   	int idx_choice_rival = dSet.indexOfColumn("choice_rival");
   	int idx_choice_kind = dSet.indexOfColumn("choice_kind");
   	int idx_proj_scale = dSet.indexOfColumn("proj_scale");
   	int idx_const_place = dSet.indexOfColumn("const_place");
   	int idx_plan_start_dt = dSet.indexOfColumn("plan_start_dt");
   	int idx_plan_end_dt = dSet.indexOfColumn("plan_end_dt");
   	int idx_start_dt = dSet.indexOfColumn("start_dt");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
   	int idx_page_count = dSet.indexOfColumn("page_count");
   	int idx_book_count = dSet.indexOfColumn("book_count");
   	int idx_pay_mat = dSet.indexOfColumn("pay_mat");
   	int idx_mat_etc = dSet.indexOfColumn("mat_etc");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_supply_amt_tax = dSet.indexOfColumn("supply_amt_tax");
   	int idx_supply_amt_notax = dSet.indexOfColumn("supply_amt_notax");
   	int idx_misctax_tax = dSet.indexOfColumn("misctax_tax");
   	int idx_misctax_notax = dSet.indexOfColumn("misctax_notax");
   	int idx_purchase_vat = dSet.indexOfColumn("purchase_vat");
   	int idx_sbc_amt = dSet.indexOfColumn("sbc_amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_stamp = dSet.indexOfColumn("stamp");
   	int idx_prgs_ctrl_dt = dSet.indexOfColumn("prgs_ctrl_dt");
   	int idx_prgs_pay_count = dSet.indexOfColumn("prgs_pay_count");
   	int idx_prgs_cash_rt = dSet.indexOfColumn("prgs_cash_rt");
   	int idx_prgs_bill_rt = dSet.indexOfColumn("prgs_bill_rt");
   	int idx_bill_cond = dSet.indexOfColumn("bill_cond");
   	int idx_delay_rt = dSet.indexOfColumn("delay_rt");
   	int idx_previous_pay_dt = dSet.indexOfColumn("previous_pay_dt");
   	int idx_previous_amt_rt = dSet.indexOfColumn("previous_amt_rt");
   	int idx_previous_amt = dSet.indexOfColumn("previous_amt");
   	int idx_previous_vat = dSet.indexOfColumn("previous_vat");
   	int idx_previous_pay_tag = dSet.indexOfColumn("previous_pay_tag");
   	int idx_previous_checker = dSet.indexOfColumn("previous_checker");
   	int idx_previous_check_dt = dSet.indexOfColumn("previous_check_dt");
   	int idx_previous_deduction_rt = dSet.indexOfColumn("previous_deduction_rt");
   	int idx_delay_amt = dSet.indexOfColumn("delay_amt");
   	int idx_delay_dt = dSet.indexOfColumn("delay_dt");
   	int idx_delay_pay_dt = dSet.indexOfColumn("delay_pay_dt");
   	int idx_insurance1_amt1 = dSet.indexOfColumn("insurance1_amt1");
   	int idx_insurance1_amt2 = dSet.indexOfColumn("insurance1_amt2");
   	int idx_insurance2_name = dSet.indexOfColumn("insurance2_name");
   	int idx_insurance2_amt1 = dSet.indexOfColumn("insurance2_amt1");
   	int idx_safety_amt1 = dSet.indexOfColumn("safety_amt1");
   	int idx_safety_amt2 = dSet.indexOfColumn("safety_amt2");
   	int idx_sbc_guarantee_issueday = dSet.indexOfColumn("sbc_guarantee_issueday");
   	int idx_sbc_guarantee_rt = dSet.indexOfColumn("sbc_guarantee_rt");
   	int idx_sbc_guarantee_amt = dSet.indexOfColumn("sbc_guarantee_amt");
   	int idx_sbc_guarantee_start_dt = dSet.indexOfColumn("sbc_guarantee_start_dt");
   	int idx_sbc_guarantee_end_dt = dSet.indexOfColumn("sbc_guarantee_end_dt");
   	int idx_sbc_guarantee_number = dSet.indexOfColumn("sbc_guarantee_number");
   	int idx_sbc_guarantee_kind = dSet.indexOfColumn("sbc_guarantee_kind");
   	int idx_warrant_guarantee_issueday = dSet.indexOfColumn("warrant_guarantee_issueday");
   	int idx_warrant_guarantee_rt = dSet.indexOfColumn("warrant_guarantee_rt");
   	int idx_warrant_guarantee_amt = dSet.indexOfColumn("warrant_guarantee_amt");
   	int idx_warrant_guarantee_start_dt = dSet.indexOfColumn("warrant_guarantee_start_dt");
   	int idx_warrant_guarantee_end_dt = dSet.indexOfColumn("warrant_guarantee_end_dt");
   	int idx_warrant_guarantee_number = dSet.indexOfColumn("warrant_guarantee_number");
   	int idx_warrant_guarantee_kind = dSet.indexOfColumn("warrant_guarantee_kind");
   	int idx_warrant_term = dSet.indexOfColumn("warrant_term");
   	int idx_pay_guarantee_issueday = dSet.indexOfColumn("pay_guarantee_issueday");
   	int idx_pay_guarantee_amt = dSet.indexOfColumn("pay_guarantee_amt");
   	int idx_pay_guarantee_start_dt = dSet.indexOfColumn("pay_guarantee_start_dt");
   	int idx_pay_guarantee_end_dt = dSet.indexOfColumn("pay_guarantee_end_dt");
   	int idx_pay_guarantee_number = dSet.indexOfColumn("pay_guarantee_number");
   	int idx_pay_guarantee_kind = dSet.indexOfColumn("pay_guarantee_kind");
   	int idx_guarantee_name = dSet.indexOfColumn("guarantee_name");
   	int idx_guarantee_rep_name = dSet.indexOfColumn("guarantee_rep_name");
   	int idx_guarantee_address = dSet.indexOfColumn("guarantee_address");
   	int idx_sbc_guarantee_name = dSet.indexOfColumn("sbc_guarantee_name");
   	int idx_sbc_guarantee_rep_name = dSet.indexOfColumn("sbc_guarantee_rep_name");
   	int idx_sbc_guarantee_address = dSet.indexOfColumn("sbc_guarantee_address");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_insurance_yn = dSet.indexOfColumn("insurance_yn");
   	int idx_ta_tag = dSet.indexOfColumn("ta_tag");
   	int idx_previous_pay1 = dSet.indexOfColumn("previous_pay1");
   	int idx_cnt_previous_amt = dSet.indexOfColumn("cnt_previous_amt");
   	int idx_guarantee_yn = dSet.indexOfColumn("guarantee_yn");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_ebid_yn = dSet.indexOfColumn("ebid_yn");
   	int idx_const_no = dSet.indexOfColumn("const_no");
   	int idx_req_dt = dSet.indexOfColumn("req_dt");
   	int idx_bonsa_dt = dSet.indexOfColumn("bonsa_dt");
   	int idx_sbcr_dt = dSet.indexOfColumn("sbcr_dt");
   	int idx_charge = dSet.indexOfColumn("charge");
   	int idx_vatcode = dSet.indexOfColumn("vatcode");
   	int idx_guarantee_tag1 = dSet.indexOfColumn("guarantee_tag1");
   	int idx_guarantee_tag2 = dSet.indexOfColumn("guarantee_tag2");
   	int idx_guarantee_tag3 = dSet.indexOfColumn("guarantee_tag3");
   	int idx_guarantee_tag4 = dSet.indexOfColumn("guarantee_tag4");
   	int idx_guarantee_tag5 = dSet.indexOfColumn("guarantee_tag5");
   	int idx_bill_day = dSet.indexOfColumn("bill_day");
   	int idx_comm_tag = dSet.indexOfColumn("comm_tag");
   	int idx_acc_tag = dSet.indexOfColumn("acc_tag");
   	int idx_emp_class = dSet.indexOfColumn("emp_class");
   	int idx_nosend1 = dSet.indexOfColumn("nosend1");
   	int idx_nosend2 = dSet.indexOfColumn("nosend2");
   	int idx_nosend3 = dSet.indexOfColumn("nosend3");
   	int idx_nosend4 = dSet.indexOfColumn("nosend4");
   	int idx_nosend5 = dSet.indexOfColumn("nosend5");
   	int idx_nosend6 = dSet.indexOfColumn("nosend6");
   	int idx_nosend7 = dSet.indexOfColumn("nosend7");
   	int idx_nosend8 = dSet.indexOfColumn("nosend8");
   	int idx_nosend9 = dSet.indexOfColumn("nosend9");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_chg_cn_list ( dept_code," + 
                    "order_number," + 
                    "chg_degree," + 
                    "sbcr_code," + 
                    "chg_resign," + 
                    "close_tag," + 
                    "approve_class," + 
                    "check_dt," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "order_name," + 
                    "sbc_name," + 
                    "sbc_dt," + 
                    "sbc_section," + 
                    "choice_rival," + 
                    "choice_kind," + 
                    "proj_scale," + 
                    "const_place," + 
                    "plan_start_dt," + 
                    "plan_end_dt," + 
                    "start_dt," + 
                    "end_dt," + 
                    "page_count," + 
                    "book_count," + 
                    "pay_mat," + 
                    "mat_etc," + 
                    "cnt_amt," + 
                    "exe_amt," + 
                    "supply_amt_tax," + 
                    "supply_amt_notax," + 
                    "misctax_tax," + 
                    "misctax_notax," + 
                    "purchase_vat," + 
                    "sbc_amt," + 
                    "vat," + 
                    "stamp," + 
                    "prgs_ctrl_dt," + 
                    "prgs_pay_count," + 
                    "prgs_cash_rt," + 
                    "prgs_bill_rt," + 
                    "bill_cond," + 
                    "delay_rt," + 
                    "previous_pay_dt," + 
                    "previous_amt_rt," + 
                    "previous_amt," + 
                    "previous_vat," + 
                    "previous_pay_tag," + 
                    "previous_checker," + 
                    "previous_check_dt," + 
                    "previous_deduction_rt," + 
                    "delay_amt," + 
                    "delay_dt," + 
                    "delay_pay_dt," + 
                    "insurance1_amt1," + 
                    "insurance1_amt2," + 
                    "insurance2_name," + 
                    "insurance2_amt1," + 
                    "safety_amt1," + 
                    "safety_amt2," + 
                    "sbc_guarantee_issueday," + 
                    "sbc_guarantee_rt," + 
                    "sbc_guarantee_amt," + 
                    "sbc_guarantee_start_dt," + 
                    "sbc_guarantee_end_dt," + 
                    "sbc_guarantee_number," + 
                    "sbc_guarantee_kind," + 
                    "warrant_guarantee_issueday," + 
                    "warrant_guarantee_rt," + 
                    "warrant_guarantee_amt," + 
                    "warrant_guarantee_start_dt," + 
                    "warrant_guarantee_end_dt," + 
                    "warrant_guarantee_number," + 
                    "warrant_guarantee_kind," + 
                    "warrant_term," + 
                    "pay_guarantee_issueday," + 
                    "pay_guarantee_amt," + 
                    "pay_guarantee_start_dt," + 
                    "pay_guarantee_end_dt," + 
                    "pay_guarantee_number," + 
                    "pay_guarantee_kind," + 
                    "guarantee_name," + 
                    "guarantee_rep_name," + 
                    "guarantee_address," + 
                    "sbc_guarantee_name," + 
                    "sbc_guarantee_rep_name," + 
                    "sbc_guarantee_address," + 
                    "remark," + 
                    "insurance_yn," + 
                    "ta_tag,previous_pay1,cnt_previous_amt,guarantee_yn,order_class,ebid_yn, " +
                    "const_no,req_dt,bonsa_dt,sbcr_dt,charge,vatcode,guarantee_tag1,guarantee_tag2,guarantee_tag3,guarantee_tag4,guarantee_tag5,bill_day,comm_tag,acc_tag,emp_class, " +
                    "nosend1,nosend2,nosend3,nosend4,nosend5,nosend6,nosend7,nosend8,nosend9 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61, :62, :63, :64, :65, :66, :67, :68, :69, :70, :71, :72, :73, :74, :75, :76, :77, :78, :79, :80, :81, :82, :83, :84, :85, :86, :87, :88, :89,:90,:91,:92,:93,:94,:95,:96,:97,:98,:99,:100,:101,:102,:103,:104,:105,:106, :107, :108, :109, :110, :111, :112, :113, :114, :115, :116, :117, :118 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_sbcr_code);
      gpstatement.bindColumn(5, idx_chg_resign);
      gpstatement.bindColumn(6, idx_close_tag);
      gpstatement.bindColumn(7, idx_approve_class);
      gpstatement.bindColumn(8, idx_check_dt);
      gpstatement.bindColumn(9, idx_request_dt);
      gpstatement.bindColumn(10, idx_approve_dt);
      gpstatement.bindColumn(11, idx_order_name);
      gpstatement.bindColumn(12, idx_sbc_name);
      gpstatement.bindColumn(13, idx_sbc_dt);
      gpstatement.bindColumn(14, idx_sbc_section);
      gpstatement.bindColumn(15, idx_choice_rival);
      gpstatement.bindColumn(16, idx_choice_kind);
      gpstatement.bindColumn(17, idx_proj_scale);
      gpstatement.bindColumn(18, idx_const_place);
      gpstatement.bindColumn(19, idx_plan_start_dt);
      gpstatement.bindColumn(20, idx_plan_end_dt);
      gpstatement.bindColumn(21, idx_start_dt);
      gpstatement.bindColumn(22, idx_end_dt);
      gpstatement.bindColumn(23, idx_page_count);
      gpstatement.bindColumn(24, idx_book_count);
      gpstatement.bindColumn(25, idx_pay_mat);
      gpstatement.bindColumn(26, idx_mat_etc);
      gpstatement.bindColumn(27, idx_cnt_amt);
      gpstatement.bindColumn(28, idx_exe_amt);
      gpstatement.bindColumn(29, idx_supply_amt_tax);
      gpstatement.bindColumn(30, idx_supply_amt_notax);
      gpstatement.bindColumn(31, idx_misctax_tax);
      gpstatement.bindColumn(32, idx_misctax_notax);
      gpstatement.bindColumn(33, idx_purchase_vat);
      gpstatement.bindColumn(34, idx_sbc_amt);
      gpstatement.bindColumn(35, idx_vat);
      gpstatement.bindColumn(36, idx_stamp);
      gpstatement.bindColumn(37, idx_prgs_ctrl_dt);
      gpstatement.bindColumn(38, idx_prgs_pay_count);
      gpstatement.bindColumn(39, idx_prgs_cash_rt);
      gpstatement.bindColumn(40, idx_prgs_bill_rt);
      gpstatement.bindColumn(41, idx_bill_cond);
      gpstatement.bindColumn(42, idx_delay_rt);
      gpstatement.bindColumn(43, idx_previous_pay_dt);
      gpstatement.bindColumn(44, idx_previous_amt_rt);
      gpstatement.bindColumn(45, idx_previous_amt);
      gpstatement.bindColumn(46, idx_previous_vat);
      gpstatement.bindColumn(47, idx_previous_pay_tag);
      gpstatement.bindColumn(48, idx_previous_checker);
      gpstatement.bindColumn(49, idx_previous_check_dt);
      gpstatement.bindColumn(50, idx_previous_deduction_rt);
      gpstatement.bindColumn(51, idx_delay_amt);
      gpstatement.bindColumn(52, idx_delay_dt);
      gpstatement.bindColumn(53, idx_delay_pay_dt);
      gpstatement.bindColumn(54, idx_insurance1_amt1);
      gpstatement.bindColumn(55, idx_insurance1_amt2);
      gpstatement.bindColumn(56, idx_insurance2_name);
      gpstatement.bindColumn(57, idx_insurance2_amt1);
      gpstatement.bindColumn(58, idx_safety_amt1);
      gpstatement.bindColumn(59, idx_safety_amt2);
      gpstatement.bindColumn(60, idx_sbc_guarantee_issueday);
      gpstatement.bindColumn(61, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(62, idx_sbc_guarantee_amt);
      gpstatement.bindColumn(63, idx_sbc_guarantee_start_dt);
      gpstatement.bindColumn(64, idx_sbc_guarantee_end_dt);
      gpstatement.bindColumn(65, idx_sbc_guarantee_number);
      gpstatement.bindColumn(66, idx_sbc_guarantee_kind);
      gpstatement.bindColumn(67, idx_warrant_guarantee_issueday);
      gpstatement.bindColumn(68, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(69, idx_warrant_guarantee_amt);
      gpstatement.bindColumn(70, idx_warrant_guarantee_start_dt);
      gpstatement.bindColumn(71, idx_warrant_guarantee_end_dt);
      gpstatement.bindColumn(72, idx_warrant_guarantee_number);
      gpstatement.bindColumn(73, idx_warrant_guarantee_kind);
      gpstatement.bindColumn(74, idx_warrant_term);
      gpstatement.bindColumn(75, idx_pay_guarantee_issueday);
      gpstatement.bindColumn(76, idx_pay_guarantee_amt);
      gpstatement.bindColumn(77, idx_pay_guarantee_start_dt);
      gpstatement.bindColumn(78, idx_pay_guarantee_end_dt);
      gpstatement.bindColumn(79, idx_pay_guarantee_number);
      gpstatement.bindColumn(80, idx_pay_guarantee_kind);
      gpstatement.bindColumn(81, idx_guarantee_name);
      gpstatement.bindColumn(82, idx_guarantee_rep_name);
      gpstatement.bindColumn(83, idx_guarantee_address);
      gpstatement.bindColumn(84, idx_sbc_guarantee_name);
      gpstatement.bindColumn(85, idx_sbc_guarantee_rep_name);
      gpstatement.bindColumn(86, idx_sbc_guarantee_address);
      gpstatement.bindColumn(87, idx_remark);
      gpstatement.bindColumn(88, idx_insurance_yn);
      gpstatement.bindColumn(89, idx_ta_tag);
      gpstatement.bindColumn(90, idx_previous_pay1);
      gpstatement.bindColumn(91, idx_cnt_previous_amt);
      gpstatement.bindColumn(92, idx_guarantee_yn);
      gpstatement.bindColumn(93, idx_order_class);
      gpstatement.bindColumn(94, idx_ebid_yn);
      gpstatement.bindColumn(95, idx_const_no);
      gpstatement.bindColumn(96, idx_req_dt);
      gpstatement.bindColumn(97, idx_bonsa_dt);
      gpstatement.bindColumn(98, idx_sbcr_dt);
      gpstatement.bindColumn(99, idx_charge);
      gpstatement.bindColumn(100,idx_vatcode);
      gpstatement.bindColumn(101,idx_guarantee_tag1);
      gpstatement.bindColumn(102,idx_guarantee_tag2);
      gpstatement.bindColumn(103,idx_guarantee_tag3);
      gpstatement.bindColumn(104,idx_guarantee_tag4);
      gpstatement.bindColumn(105,idx_guarantee_tag5);
      gpstatement.bindColumn(106,idx_bill_day);
      gpstatement.bindColumn(107,idx_comm_tag);
      gpstatement.bindColumn(108,idx_acc_tag);
      gpstatement.bindColumn(109,idx_emp_class);
      gpstatement.bindColumn(110,idx_nosend1);
      gpstatement.bindColumn(111,idx_nosend2);
      gpstatement.bindColumn(112,idx_nosend3);
      gpstatement.bindColumn(113,idx_nosend4);
      gpstatement.bindColumn(114,idx_nosend5);
      gpstatement.bindColumn(115,idx_nosend6);
      gpstatement.bindColumn(116,idx_nosend7);
      gpstatement.bindColumn(117,idx_nosend8);
      gpstatement.bindColumn(118,idx_nosend9);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_chg_cn_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "chg_degree=?,  " + 
                            "sbcr_code=?,  " + 
                            "chg_resign=?,  " + 
                            "close_tag=?,  " + 
                            "approve_class=?,  " + 
                            "check_dt=?,  " + 
                            "request_dt=?,  " + 
                            "approve_dt=?,  " + 
                            "order_name=?,  " + 
                            "sbc_name=?,  " + 
                            "sbc_dt=?,  " + 
                            "sbc_section=?,  " + 
                            "choice_rival=?,  " + 
                            "choice_kind=?,  " + 
                            "proj_scale=?,  " + 
                            "const_place=?,  " + 
                            "plan_start_dt=?,  " + 
                            "plan_end_dt=?,  " + 
                            "start_dt=?,  " + 
                            "end_dt=?,  " + 
                            "page_count=?,  " + 
                            "book_count=?,  " + 
                            "pay_mat=?,  " + 
                            "mat_etc=?,  " + 
                            "cnt_amt=?,  " + 
                            "exe_amt=?,  " + 
                            "supply_amt_tax=?,  " + 
                            "supply_amt_notax=?,  " + 
                            "misctax_tax=?,  " + 
                            "misctax_notax=?,  " + 
                            "purchase_vat=?,  " + 
                            "sbc_amt=?,  " + 
                            "vat=?,  " + 
                            "stamp=?,  " + 
                            "prgs_ctrl_dt=?,  " + 
                            "prgs_pay_count=?,  " + 
                            "prgs_cash_rt=?,  " + 
                            "prgs_bill_rt=?,  " + 
                            "bill_cond=?,  " + 
                            "delay_rt=?,  " + 
                            "previous_pay_dt=?,  " + 
                            "previous_amt_rt=?,  " + 
                            "previous_amt=?,  " + 
                            "previous_vat=?,  " + 
                            "previous_pay_tag=?,  " + 
                            "previous_checker=?,  " + 
                            "previous_check_dt=?,  " + 
                            "previous_deduction_rt=?,  " + 
                            "delay_amt=?,  " + 
                            "delay_dt=?,  " + 
                            "delay_pay_dt=?,  " + 
                            "insurance1_amt1=?,  " + 
                            "insurance1_amt2=?,  " + 
                            "insurance2_name=?,  " + 
                            "insurance2_amt1=?,  " + 
                            "safety_amt1=?,  " + 
                            "safety_amt2=?,  " + 
                            "sbc_guarantee_issueday=?,  " + 
                            "sbc_guarantee_rt=?,  " + 
                            "sbc_guarantee_amt=?,  " + 
                            "sbc_guarantee_start_dt=?,  " + 
                            "sbc_guarantee_end_dt=?,  " + 
                            "sbc_guarantee_number=?,  " + 
                            "sbc_guarantee_kind=?,  " + 
                            "warrant_guarantee_issueday=?,  " + 
                            "warrant_guarantee_rt=?,  " + 
                            "warrant_guarantee_amt=?,  " + 
                            "warrant_guarantee_start_dt=?,  " + 
                            "warrant_guarantee_end_dt=?,  " + 
                            "warrant_guarantee_number=?,  " + 
                            "warrant_guarantee_kind=?,  " + 
                            "warrant_term=?,  " + 
                            "pay_guarantee_issueday=?,  " + 
                            "pay_guarantee_amt=?,  " + 
                            "pay_guarantee_start_dt=?,  " + 
                            "pay_guarantee_end_dt=?,  " + 
                            "pay_guarantee_number=?,  " + 
                            "pay_guarantee_kind=?,  " + 
                            "guarantee_name=?,  " + 
                            "guarantee_rep_name=?,  " + 
                            "guarantee_address=?,  " + 
                            "sbc_guarantee_name=?,  " + 
                            "sbc_guarantee_rep_name=?,  " + 
                            "sbc_guarantee_address=?,  " + 
                            "remark=?,  " + 
                            "insurance_yn=?,  " + 
                            "ta_tag=?,previous_pay1=?,cnt_previous_amt=?,guarantee_yn=?,order_class=?,ebid_yn=?, " +
                            "const_no=?,req_dt=?,bonsa_dt=?,sbcr_dt=?,charge=?,vatcode=?, " +
                            "guarantee_tag1=?,guarantee_tag2=?,guarantee_tag3=?,guarantee_tag4=?,guarantee_tag5=? ,bill_day=?, comm_tag=?,acc_tag=?,emp_class=?, " +
                            "nosend1=?,nosend2=?,nosend3=?,nosend4=?,nosend5=?,nosend6=?,nosend7=?,nosend8=?,nosend9=? " +
                            " where (dept_code=? and order_number=? and chg_degree=?) ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_sbcr_code);
      gpstatement.bindColumn(5, idx_chg_resign);
      gpstatement.bindColumn(6, idx_close_tag);
      gpstatement.bindColumn(7, idx_approve_class);
      gpstatement.bindColumn(8, idx_check_dt);
      gpstatement.bindColumn(9, idx_request_dt);
      gpstatement.bindColumn(10, idx_approve_dt);
      gpstatement.bindColumn(11, idx_order_name);
      gpstatement.bindColumn(12, idx_sbc_name);
      gpstatement.bindColumn(13, idx_sbc_dt);
      gpstatement.bindColumn(14, idx_sbc_section);
      gpstatement.bindColumn(15, idx_choice_rival);
      gpstatement.bindColumn(16, idx_choice_kind);
      gpstatement.bindColumn(17, idx_proj_scale);
      gpstatement.bindColumn(18, idx_const_place);
      gpstatement.bindColumn(19, idx_plan_start_dt);
      gpstatement.bindColumn(20, idx_plan_end_dt);
      gpstatement.bindColumn(21, idx_start_dt);
      gpstatement.bindColumn(22, idx_end_dt);
      gpstatement.bindColumn(23, idx_page_count);
      gpstatement.bindColumn(24, idx_book_count);
      gpstatement.bindColumn(25, idx_pay_mat);
      gpstatement.bindColumn(26, idx_mat_etc);
      gpstatement.bindColumn(27, idx_cnt_amt);
      gpstatement.bindColumn(28, idx_exe_amt);
      gpstatement.bindColumn(29, idx_supply_amt_tax);
      gpstatement.bindColumn(30, idx_supply_amt_notax);
      gpstatement.bindColumn(31, idx_misctax_tax);
      gpstatement.bindColumn(32, idx_misctax_notax);
      gpstatement.bindColumn(33, idx_purchase_vat);
      gpstatement.bindColumn(34, idx_sbc_amt);
      gpstatement.bindColumn(35, idx_vat);
      gpstatement.bindColumn(36, idx_stamp);
      gpstatement.bindColumn(37, idx_prgs_ctrl_dt);
      gpstatement.bindColumn(38, idx_prgs_pay_count);
      gpstatement.bindColumn(39, idx_prgs_cash_rt);
      gpstatement.bindColumn(40, idx_prgs_bill_rt);
      gpstatement.bindColumn(41, idx_bill_cond);
      gpstatement.bindColumn(42, idx_delay_rt);
      gpstatement.bindColumn(43, idx_previous_pay_dt);
      gpstatement.bindColumn(44, idx_previous_amt_rt);
      gpstatement.bindColumn(45, idx_previous_amt);
      gpstatement.bindColumn(46, idx_previous_vat);
      gpstatement.bindColumn(47, idx_previous_pay_tag);
      gpstatement.bindColumn(48, idx_previous_checker);
      gpstatement.bindColumn(49, idx_previous_check_dt);
      gpstatement.bindColumn(50, idx_previous_deduction_rt);
      gpstatement.bindColumn(51, idx_delay_amt);
      gpstatement.bindColumn(52, idx_delay_dt);
      gpstatement.bindColumn(53, idx_delay_pay_dt);
      gpstatement.bindColumn(54, idx_insurance1_amt1);
      gpstatement.bindColumn(55, idx_insurance1_amt2);
      gpstatement.bindColumn(56, idx_insurance2_name);
      gpstatement.bindColumn(57, idx_insurance2_amt1);
      gpstatement.bindColumn(58, idx_safety_amt1);
      gpstatement.bindColumn(59, idx_safety_amt2);
      gpstatement.bindColumn(60, idx_sbc_guarantee_issueday);
      gpstatement.bindColumn(61, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(62, idx_sbc_guarantee_amt);
      gpstatement.bindColumn(63, idx_sbc_guarantee_start_dt);
      gpstatement.bindColumn(64, idx_sbc_guarantee_end_dt);
      gpstatement.bindColumn(65, idx_sbc_guarantee_number);
      gpstatement.bindColumn(66, idx_sbc_guarantee_kind);
      gpstatement.bindColumn(67, idx_warrant_guarantee_issueday);
      gpstatement.bindColumn(68, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(69, idx_warrant_guarantee_amt);
      gpstatement.bindColumn(70, idx_warrant_guarantee_start_dt);
      gpstatement.bindColumn(71, idx_warrant_guarantee_end_dt);
      gpstatement.bindColumn(72, idx_warrant_guarantee_number);
      gpstatement.bindColumn(73, idx_warrant_guarantee_kind);
      gpstatement.bindColumn(74, idx_warrant_term);
      gpstatement.bindColumn(75, idx_pay_guarantee_issueday);
      gpstatement.bindColumn(76, idx_pay_guarantee_amt);
      gpstatement.bindColumn(77, idx_pay_guarantee_start_dt);
      gpstatement.bindColumn(78, idx_pay_guarantee_end_dt);
      gpstatement.bindColumn(79, idx_pay_guarantee_number);
      gpstatement.bindColumn(80, idx_pay_guarantee_kind);
      gpstatement.bindColumn(81, idx_guarantee_name);
      gpstatement.bindColumn(82, idx_guarantee_rep_name);
      gpstatement.bindColumn(83, idx_guarantee_address);
      gpstatement.bindColumn(84, idx_sbc_guarantee_name);
      gpstatement.bindColumn(85, idx_sbc_guarantee_rep_name);
      gpstatement.bindColumn(86, idx_sbc_guarantee_address);
      gpstatement.bindColumn(87, idx_remark);
      gpstatement.bindColumn(88, idx_insurance_yn);
      gpstatement.bindColumn(89, idx_ta_tag);
      gpstatement.bindColumn(90, idx_previous_pay1);
      gpstatement.bindColumn(91, idx_cnt_previous_amt);
      gpstatement.bindColumn(92, idx_guarantee_yn);
      gpstatement.bindColumn(93, idx_order_class);
      gpstatement.bindColumn(94, idx_ebid_yn);
      gpstatement.bindColumn(95, idx_const_no);
      gpstatement.bindColumn(96, idx_req_dt);
      gpstatement.bindColumn(97, idx_bonsa_dt);
      gpstatement.bindColumn(98, idx_sbcr_dt);
      gpstatement.bindColumn(99, idx_charge);
      gpstatement.bindColumn(100, idx_vatcode);
      gpstatement.bindColumn(101,idx_guarantee_tag1);
      gpstatement.bindColumn(102,idx_guarantee_tag2);
      gpstatement.bindColumn(103,idx_guarantee_tag3);
      gpstatement.bindColumn(104,idx_guarantee_tag4);
      gpstatement.bindColumn(105,idx_guarantee_tag5);
      gpstatement.bindColumn(106,idx_bill_day);
      gpstatement.bindColumn(107,idx_comm_tag);
      gpstatement.bindColumn(108,idx_acc_tag);
      gpstatement.bindColumn(109,idx_emp_class);
      gpstatement.bindColumn(110,idx_nosend1);
      gpstatement.bindColumn(111,idx_nosend2);
      gpstatement.bindColumn(112,idx_nosend3);
      gpstatement.bindColumn(113,idx_nosend4);
      gpstatement.bindColumn(114,idx_nosend5);
      gpstatement.bindColumn(115,idx_nosend6);
      gpstatement.bindColumn(116,idx_nosend7);
      gpstatement.bindColumn(117,idx_nosend8);
      gpstatement.bindColumn(118,idx_nosend9);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(119, idx_dept_code);
      gpstatement.bindColumn(120, idx_order_number);
      gpstatement.bindColumn(121, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_chg_cn_list where (dept_code=? and order_number=? and chg_degree=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>