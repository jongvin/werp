<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_proj_sbcr_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_businessman_number = dSet.indexOfColumn("businessman_number");
   	int idx_corp_no = dSet.indexOfColumn("corp_no");
   	int idx_establish_date = dSet.indexOfColumn("establish_date");
   	int idx_kind_bussinesstype = dSet.indexOfColumn("kind_bussinesstype");
   	int idx_kinditem = dSet.indexOfColumn("kinditem");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_zip_number1 = dSet.indexOfColumn("zip_number1");
   	int idx_address1 = dSet.indexOfColumn("address1");
   	int idx_tel_number1 = dSet.indexOfColumn("tel_number1");
   	int idx_zip_number2 = dSet.indexOfColumn("zip_number2");
   	int idx_address2 = dSet.indexOfColumn("address2");
   	int idx_tel_number2 = dSet.indexOfColumn("tel_number2");
   	int idx_rep_name1 = dSet.indexOfColumn("rep_name1");
   	int idx_rep_name2 = dSet.indexOfColumn("rep_name2");
   	int idx_rep_email = dSet.indexOfColumn("rep_email");
   	int idx_rep_jumin = dSet.indexOfColumn("rep_jumin");
   	int idx_rep_zip_number1 = dSet.indexOfColumn("rep_zip_number1");
   	int idx_rep_address1 = dSet.indexOfColumn("rep_address1");
   	int idx_rep_zip_number2 = dSet.indexOfColumn("rep_zip_number2");
   	int idx_rep_address2 = dSet.indexOfColumn("rep_address2");
   	int idx_rep_tel_number1 = dSet.indexOfColumn("rep_tel_number1");
   	int idx_rep_tel_number2 = dSet.indexOfColumn("rep_tel_number2");
   	int idx_rep_taste = dSet.indexOfColumn("rep_taste");
   	int idx_rep_religious = dSet.indexOfColumn("rep_religious");
   	int idx_rep_born_area = dSet.indexOfColumn("rep_born_area");
   	int idx_chrg_department = dSet.indexOfColumn("chrg_department");
   	int idx_chrg_grade = dSet.indexOfColumn("chrg_grade");
   	int idx_chrg_name1 = dSet.indexOfColumn("chrg_name1");
   	int idx_chrg_name2 = dSet.indexOfColumn("chrg_name2");
   	int idx_chrg_hp = dSet.indexOfColumn("chrg_hp");
   	int idx_chrg_email = dSet.indexOfColumn("chrg_email");
   	int idx_chrg_jumin = dSet.indexOfColumn("chrg_jumin");
   	int idx_chrg_zip_number1 = dSet.indexOfColumn("chrg_zip_number1");
   	int idx_chrg_address1 = dSet.indexOfColumn("chrg_address1");
   	int idx_chrg_zip_number2 = dSet.indexOfColumn("chrg_zip_number2");
   	int idx_chrg_address2 = dSet.indexOfColumn("chrg_address2");
   	int idx_chrg_tel_number2 = dSet.indexOfColumn("chrg_tel_number2");
   	int idx_chrg_born_area = dSet.indexOfColumn("chrg_born_area");
   	int idx_fax_number = dSet.indexOfColumn("fax_number");
   	int idx_iso_status = dSet.indexOfColumn("iso_status");
   	int idx_main_bank = dSet.indexOfColumn("main_bank");
   	int idx_depositor = dSet.indexOfColumn("depositor");
   	int idx_acc_number = dSet.indexOfColumn("acc_number");
   	int idx_speciality = dSet.indexOfColumn("speciality");
   	int idx_capital1 = dSet.indexOfColumn("capital1");
   	int idx_property1 = dSet.indexOfColumn("property1");
   	int idx_debt1 = dSet.indexOfColumn("debt1");
   	int idx_capital_tot1 = dSet.indexOfColumn("capital_tot1");
   	int idx_sale_amt1 = dSet.indexOfColumn("sale_amt1");
   	int idx_profit1 = dSet.indexOfColumn("profit1");
   	int idx_c_grade1 = dSet.indexOfColumn("c_grade1");
   	int idx_capital2 = dSet.indexOfColumn("capital2");
   	int idx_property2 = dSet.indexOfColumn("property2");
   	int idx_debt2 = dSet.indexOfColumn("debt2");
   	int idx_capital_tot2 = dSet.indexOfColumn("capital_tot2");
   	int idx_sale_amt2 = dSet.indexOfColumn("sale_amt2");
   	int idx_profit2 = dSet.indexOfColumn("profit2");
   	int idx_c_grade2 = dSet.indexOfColumn("c_grade2");
   	int idx_capital3 = dSet.indexOfColumn("capital3");
   	int idx_property3 = dSet.indexOfColumn("property3");
   	int idx_debt3 = dSet.indexOfColumn("debt3");
   	int idx_capital_tot3 = dSet.indexOfColumn("capital_tot3");
   	int idx_sale_amt3 = dSet.indexOfColumn("sale_amt3");
   	int idx_profit3 = dSet.indexOfColumn("profit3");
   	int idx_c_grade3 = dSet.indexOfColumn("c_grade3");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_mat_sbcr_class = dSet.indexOfColumn("mat_sbcr_class");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_inout_name = dSet.indexOfColumn("inout_name");
   	int idx_inout_tel = dSet.indexOfColumn("inout_tel");
   	int idx_bill_dis_pay = dSet.indexOfColumn("bill_dis_pay");
   	int idx_sbcr_class = dSet.indexOfColumn("sbcr_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_SBCR ( sbcr_code," + 
                    "sbcr_name," + 
                    "businessman_number," + 
                    "corp_no," + 
                    "establish_date," + 
                    "kind_bussinesstype," + 
                    "kinditem," + 
                    "region_code," + 
                    "zip_number1," +
                    "address1," + 
                    "tel_number1," + 
                    "zip_number2," + 
                    "address2," + 
                    "tel_number2," + 
                    "rep_name1," + 
                    "rep_name2," + 
                    "rep_email," + 
                    "rep_jumin," + 
                    "rep_zip_number1," + 
                    "rep_address1," + 
                    "rep_zip_number2," + 
                    "rep_address2," + 
                    "rep_tel_number1," + 
                    "rep_tel_number2," + 
                    "rep_taste," + 
                    "rep_religious," + 
                    "rep_born_area," + 
                    "chrg_department," + 
                    "chrg_grade," + 
                    "chrg_name1," + 
                    "chrg_name2," + 
                    "chrg_hp," + 
                    "chrg_email," + 
                    "chrg_jumin," + 
                    "chrg_zip_number1," + 
                    "chrg_address1," + 
                    "chrg_zip_number2," + 
                    "chrg_address2," + 
                    "chrg_tel_number2," + 
                    "chrg_born_area," + 
                    "fax_number," + 
                    "iso_status," + 
                    "main_bank," + 
                    "depositor," + 
                    "acc_number," + 
                    "speciality," + 
                    "capital1," + 
                    "property1," + 
                    "debt1," + 
                    "capital_tot1," + 
                    "sale_amt1," + 
                    "profit1," + 
                    "c_grade1," + 
                    "capital2," + 
                    "property2," + 
                    "debt2," + 
                    "capital_tot2," + 
                    "sale_amt2," + 
                    "profit2," + 
                    "c_grade2," + 
                    "capital3," + 
                    "property3," + 
                    "debt3," + 
                    "capital_tot3," + 
                    "sale_amt3," + 
                    "profit3," + 
                    "c_grade3," + 
                    "input_dt," + 
                    "input_name,mat_sbcr_class,chg_degree,bill_dis_pay,sbcr_class )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61, :62, :63, :64, :65, :66, :67, :68, :69, :70, :71,:72,:73 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_businessman_number);
      gpstatement.bindColumn(4, idx_corp_no);
      gpstatement.bindColumn(5, idx_establish_date);
      gpstatement.bindColumn(6, idx_kind_bussinesstype);
      gpstatement.bindColumn(7, idx_kinditem);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_zip_number1);
      gpstatement.bindColumn(10, idx_address1);
      gpstatement.bindColumn(11, idx_tel_number1);
      gpstatement.bindColumn(12, idx_zip_number2);
      gpstatement.bindColumn(13, idx_address2);
      gpstatement.bindColumn(14, idx_tel_number2);
      gpstatement.bindColumn(15, idx_rep_name1);
      gpstatement.bindColumn(16, idx_rep_name2);
      gpstatement.bindColumn(17, idx_rep_email);
      gpstatement.bindColumn(18, idx_rep_jumin);
      gpstatement.bindColumn(19, idx_rep_zip_number1);
      gpstatement.bindColumn(20, idx_rep_address1);
      gpstatement.bindColumn(21, idx_rep_zip_number2);
      gpstatement.bindColumn(22, idx_rep_address2);
      gpstatement.bindColumn(23, idx_rep_tel_number1);
      gpstatement.bindColumn(24, idx_rep_tel_number2);
      gpstatement.bindColumn(25, idx_rep_taste);
      gpstatement.bindColumn(26, idx_rep_religious);
      gpstatement.bindColumn(27, idx_rep_born_area);
      gpstatement.bindColumn(28, idx_chrg_department);
      gpstatement.bindColumn(29, idx_chrg_grade);
      gpstatement.bindColumn(30, idx_chrg_name1);
      gpstatement.bindColumn(31, idx_chrg_name2);
      gpstatement.bindColumn(32, idx_chrg_hp);
      gpstatement.bindColumn(33, idx_chrg_email);
      gpstatement.bindColumn(34, idx_chrg_jumin);
      gpstatement.bindColumn(35, idx_chrg_zip_number1);
      gpstatement.bindColumn(36, idx_chrg_address1);
      gpstatement.bindColumn(37, idx_chrg_zip_number2);
      gpstatement.bindColumn(38, idx_chrg_address2);
      gpstatement.bindColumn(39, idx_chrg_tel_number2);
      gpstatement.bindColumn(40, idx_chrg_born_area);
      gpstatement.bindColumn(41, idx_fax_number);
      gpstatement.bindColumn(42, idx_iso_status);
      gpstatement.bindColumn(43, idx_main_bank);
      gpstatement.bindColumn(44, idx_depositor);
      gpstatement.bindColumn(45, idx_acc_number);
      gpstatement.bindColumn(46, idx_speciality);
      gpstatement.bindColumn(47, idx_capital1);
      gpstatement.bindColumn(48, idx_property1);
      gpstatement.bindColumn(49, idx_debt1);
      gpstatement.bindColumn(50, idx_capital_tot1);
      gpstatement.bindColumn(51, idx_sale_amt1);
      gpstatement.bindColumn(52, idx_profit1);
      gpstatement.bindColumn(53, idx_c_grade1);
      gpstatement.bindColumn(54, idx_capital2);
      gpstatement.bindColumn(55, idx_property2);
      gpstatement.bindColumn(56, idx_debt2);
      gpstatement.bindColumn(57, idx_capital_tot2);
      gpstatement.bindColumn(58, idx_sale_amt2);
      gpstatement.bindColumn(59, idx_profit2);
      gpstatement.bindColumn(60, idx_c_grade2);
      gpstatement.bindColumn(61, idx_capital3);
      gpstatement.bindColumn(62, idx_property3);
      gpstatement.bindColumn(63, idx_debt3);
      gpstatement.bindColumn(64, idx_capital_tot3);
      gpstatement.bindColumn(65, idx_sale_amt3);
      gpstatement.bindColumn(66, idx_profit3);
      gpstatement.bindColumn(67, idx_c_grade3);
      gpstatement.bindColumn(68, idx_input_dt);
      gpstatement.bindColumn(69, idx_input_name);
      gpstatement.bindColumn(70, idx_mat_sbcr_class);
      gpstatement.bindColumn(71, idx_chg_degree);
      gpstatement.bindColumn(72, idx_bill_dis_pay);
      gpstatement.bindColumn(73, idx_sbcr_class);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_sbcr set " + 
                            "sbcr_code=?,  " + 
                            "sbcr_name=?,  " + 
                            "businessman_number=?,  " + 
                            "corp_no=?,  " + 
                            "establish_date=?,  " + 
                            "kind_bussinesstype=?,  " + 
                            "kinditem=?,  " + 
                            "region_code=?,  " + 
                            "zip_number1=?,  " + 
                            "address1=?,  " + 
                            "tel_number1=?,  " + 
                            "zip_number2=?,  " + 
                            "address2=?,  " + 
                            "tel_number2=?,  " + 
                            "rep_name1=?,  " + 
                            "rep_name2=?,  " + 
                            "rep_email=?,  " + 
                            "rep_jumin=?,  " + 
                            "rep_zip_number1=?,  " + 
                            "rep_address1=?,  " + 
                            "rep_zip_number2=?,  " + 
                            "rep_address2=?,  " + 
                            "rep_tel_number1=?,  " + 
                            "rep_tel_number2=?,  " + 
                            "rep_taste=?,  " + 
                            "rep_religious=?,  " + 
                            "rep_born_area=?,  " + 
                            "chrg_department=?,  " + 
                            "chrg_grade=?,  " + 
                            "chrg_name1=?,  " + 
                            "chrg_name2=?,  " + 
                            "chrg_hp=?,  " + 
                            "chrg_email=?,  " + 
                            "chrg_jumin=?,  " + 
                            "chrg_zip_number1=?,  " + 
                            "chrg_address1=?,  " + 
                            "chrg_zip_number2=?,  " + 
                            "chrg_address2=?,  " + 
                            "chrg_tel_number2=?,  " + 
                            "chrg_born_area=?,  " + 
                            "fax_number=?,  " + 
                            "iso_status=?,  " + 
                            "main_bank=?,  " + 
                            "depositor=?,  " + 
                            "acc_number=?,  " + 
                            "speciality=?,  " + 
                            "capital1=?,  " + 
                            "property1=?,  " + 
                            "debt1=?,  " + 
                            "capital_tot1=?,  " + 
                            "sale_amt1=?,  " + 
                            "profit1=?,  " + 
                            "c_grade1=?,  " + 
                            "capital2=?,  " + 
                            "property2=?,  " + 
                            "debt2=?,  " + 
                            "capital_tot2=?,  " + 
                            "sale_amt2=?,  " + 
                            "profit2=?,  " + 
                            "c_grade2=?,  " + 
                            "capital3=?,  " + 
                            "property3=?,  " + 
                            "debt3=?,  " + 
                            "capital_tot3=?,  " + 
                            "sale_amt3=?,  " + 
                            "profit3=?,  " + 
                            "c_grade3=?,  " + 
                            "input_dt=?,  " + 
                            "input_name=?,mat_sbcr_class=?,chg_degree=?,bill_dis_pay=?,sbcr_class=?  where sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_businessman_number);
      gpstatement.bindColumn(4, idx_corp_no);
      gpstatement.bindColumn(5, idx_establish_date);
      gpstatement.bindColumn(6, idx_kind_bussinesstype);
      gpstatement.bindColumn(7, idx_kinditem);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_zip_number1);
      gpstatement.bindColumn(10, idx_address1);
      gpstatement.bindColumn(11, idx_tel_number1);
      gpstatement.bindColumn(12, idx_zip_number2);
      gpstatement.bindColumn(13, idx_address2);
      gpstatement.bindColumn(14, idx_tel_number2);
      gpstatement.bindColumn(15, idx_rep_name1);
      gpstatement.bindColumn(16, idx_rep_name2);
      gpstatement.bindColumn(17, idx_rep_email);
      gpstatement.bindColumn(18, idx_rep_jumin);
      gpstatement.bindColumn(19, idx_rep_zip_number1);
      gpstatement.bindColumn(20, idx_rep_address1);
      gpstatement.bindColumn(21, idx_rep_zip_number2);
      gpstatement.bindColumn(22, idx_rep_address2);
      gpstatement.bindColumn(23, idx_rep_tel_number1);
      gpstatement.bindColumn(24, idx_rep_tel_number2);
      gpstatement.bindColumn(25, idx_rep_taste);
      gpstatement.bindColumn(26, idx_rep_religious);
      gpstatement.bindColumn(27, idx_rep_born_area);
      gpstatement.bindColumn(28, idx_chrg_department);
      gpstatement.bindColumn(29, idx_chrg_grade);
      gpstatement.bindColumn(30, idx_chrg_name1);
      gpstatement.bindColumn(31, idx_chrg_name2);
      gpstatement.bindColumn(32, idx_chrg_hp);
      gpstatement.bindColumn(33, idx_chrg_email);
      gpstatement.bindColumn(34, idx_chrg_jumin);
      gpstatement.bindColumn(35, idx_chrg_zip_number1);
      gpstatement.bindColumn(36, idx_chrg_address1);
      gpstatement.bindColumn(37, idx_chrg_zip_number2);
      gpstatement.bindColumn(38, idx_chrg_address2);
      gpstatement.bindColumn(39, idx_chrg_tel_number2);
      gpstatement.bindColumn(40, idx_chrg_born_area);
      gpstatement.bindColumn(41, idx_fax_number);
      gpstatement.bindColumn(42, idx_iso_status);
      gpstatement.bindColumn(43, idx_main_bank);
      gpstatement.bindColumn(44, idx_depositor);
      gpstatement.bindColumn(45, idx_acc_number);
      gpstatement.bindColumn(46, idx_speciality);
      gpstatement.bindColumn(47, idx_capital1);
      gpstatement.bindColumn(48, idx_property1);
      gpstatement.bindColumn(49, idx_debt1);
      gpstatement.bindColumn(50, idx_capital_tot1);
      gpstatement.bindColumn(51, idx_sale_amt1);
      gpstatement.bindColumn(52, idx_profit1);
      gpstatement.bindColumn(53, idx_c_grade1);
      gpstatement.bindColumn(54, idx_capital2);
      gpstatement.bindColumn(55, idx_property2);
      gpstatement.bindColumn(56, idx_debt2);
      gpstatement.bindColumn(57, idx_capital_tot2);
      gpstatement.bindColumn(58, idx_sale_amt2);
      gpstatement.bindColumn(59, idx_profit2);
      gpstatement.bindColumn(60, idx_c_grade2);
      gpstatement.bindColumn(61, idx_capital3);
      gpstatement.bindColumn(62, idx_property3);
      gpstatement.bindColumn(63, idx_debt3);
      gpstatement.bindColumn(64, idx_capital_tot3);
      gpstatement.bindColumn(65, idx_sale_amt3);
      gpstatement.bindColumn(66, idx_profit3);
      gpstatement.bindColumn(67, idx_c_grade3);
      gpstatement.bindColumn(68, idx_input_dt);
      gpstatement.bindColumn(69, idx_input_name);
      gpstatement.bindColumn(70, idx_mat_sbcr_class);
      gpstatement.bindColumn(71, idx_chg_degree);
      gpstatement.bindColumn(72, idx_bill_dis_pay);
      gpstatement.bindColumn(73, idx_sbcr_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(74, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_sbcr where sbcr_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>