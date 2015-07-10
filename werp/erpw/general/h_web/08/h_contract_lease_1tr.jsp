<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_lease_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_cont_seq = dSet.indexOfColumn("cont_seq");
   	int idx_cont_num = dSet.indexOfColumn("cont_num");
   	int idx_cont_type = dSet.indexOfColumn("cont_type");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_vat_yn = dSet.indexOfColumn("vat_yn");
   	int idx_guarantee_amt = dSet.indexOfColumn("guarantee_amt");
   	int idx_lease_supply = dSet.indexOfColumn("lease_supply");
   	int idx_lease_vat = dSet.indexOfColumn("lease_vat");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_moveinto_date = dSet.indexOfColumn("moveinto_date");
   	int idx_real_name = dSet.indexOfColumn("real_name");
   	int idx_lease_chg_seq = dSet.indexOfColumn("lease_chg_seq");
   	int idx_rent_chg_seq = dSet.indexOfColumn("rent_chg_seq");
   	int idx_cont_zip_code = dSet.indexOfColumn("cont_zip_code");
   	int idx_cont_addr1 = dSet.indexOfColumn("cont_addr1");
   	int idx_cont_addr2 = dSet.indexOfColumn("cont_addr2");
   	int idx_moveinto_plan_date = dSet.indexOfColumn("moveinto_plan_date");
   	int idx_moveinto_code = dSet.indexOfColumn("moveinto_code");
   	int idx_passwd = dSet.indexOfColumn("passwd");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_input_id = dSet.indexOfColumn("input_id");
   	int idx_remark = dSet.indexOfColumn("remark");
		int idx_exp_tag = dSet.indexOfColumn("exp_tag");
		int idx_exp_date = dSet.indexOfColumn("exp_date");
   	int idx_extra_1 = dSet.indexOfColumn("extra_1");
   	int idx_extra_2 = dSet.indexOfColumn("extra_2");
   	int idx_extra_3 = dSet.indexOfColumn("extra_3");
   	int idx_extra_4 = dSet.indexOfColumn("extra_4");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_LEASE_MASTER ( dept_code," + 
                    "sell_code," + 
                    "cont_date," + 
                    "cont_seq," + 
                    "cont_num," + 
                    "cont_type," + 
                    "cust_code," + 
                    "vat_yn," + 
                    "guarantee_amt," + 
                    "lease_supply," + 
                    "lease_vat," + 
                    "s_date," + 
                    "e_date," + 
                    "moveinto_date," + 
                    "real_name," + 
                    "lease_chg_seq," + 
                    "rent_chg_seq," + 
                    "cont_zip_code," + 
                    "cont_addr1," + 
                    "cont_addr2," + 
                    "moveinto_plan_date," + 
                    "moveinto_code," + 
                    "passwd," + 
                    "input_date," + 
                    "input_id," + 
                    "remark," + 
			           "exp_tag," +
			           "exp_date," +
                    "extra_1," + 
                    "extra_2," + 
                    "extra_3," + 
                    "extra_4 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_cont_num);
      gpstatement.bindColumn(6, idx_cont_type);
      gpstatement.bindColumn(7, idx_cust_code);
      gpstatement.bindColumn(8, idx_vat_yn);
      gpstatement.bindColumn(9, idx_guarantee_amt);
      gpstatement.bindColumn(10, idx_lease_supply);
      gpstatement.bindColumn(11, idx_lease_vat);
      gpstatement.bindColumn(12, idx_s_date);
      gpstatement.bindColumn(13, idx_e_date);
      gpstatement.bindColumn(14, idx_moveinto_date);
      gpstatement.bindColumn(15, idx_real_name);
      gpstatement.bindColumn(16, idx_lease_chg_seq);
      gpstatement.bindColumn(17, idx_rent_chg_seq);
      gpstatement.bindColumn(18, idx_cont_zip_code);
      gpstatement.bindColumn(19, idx_cont_addr1);
      gpstatement.bindColumn(20, idx_cont_addr2);
      gpstatement.bindColumn(21, idx_moveinto_plan_date);
      gpstatement.bindColumn(22, idx_moveinto_code);
      gpstatement.bindColumn(23, idx_passwd);
      gpstatement.bindColumn(24, idx_input_date);
      gpstatement.bindColumn(25, idx_input_id);
      gpstatement.bindColumn(26, idx_remark);
		gpstatement.bindColumn(27, idx_exp_tag);
		gpstatement.bindColumn(28, idx_exp_date);
      gpstatement.bindColumn(29, idx_extra_1);
      gpstatement.bindColumn(30, idx_extra_2);
      gpstatement.bindColumn(31, idx_extra_3);
      gpstatement.bindColumn(32, idx_extra_4);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_lease_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cont_date=?,  " + 
                            "cont_seq=?,  " + 
                            "cont_num=?,  " + 
                            "cont_type=?,  " + 
                            "cust_code=?,  " + 
                            "vat_yn=?,  " + 
                            "guarantee_amt=?,  " + 
                            "lease_supply=?,  " + 
                            "lease_vat=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "moveinto_date=?,  " + 
                            "real_name=?,  " + 
                            "lease_chg_seq=?,  " + 
                            "rent_chg_seq=?,  " + 
                            "cont_zip_code=?,  " + 
                            "cont_addr1=?,  " + 
                            "cont_addr2=?,  " + 
                            "moveinto_plan_date=?,  " + 
                            "moveinto_code=?,  " + 
                            "passwd=?,  " + 
                            "input_date=?,  " + 
                            "input_id=?,  " + 
                            "remark=?,  " + 
	                         "exp_tag=?,  " +
	                         "exp_date=?,  " +
                            "extra_1=?,  " + 
                            "extra_2=?,  " + 
                            "extra_3=?,  " + 
                            "extra_4=?  where dept_code=?  and sell_code=? and cont_date=? and cont_seq=?" ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_cont_num);
      gpstatement.bindColumn(6, idx_cont_type);
      gpstatement.bindColumn(7, idx_cust_code);
      gpstatement.bindColumn(8, idx_vat_yn);
      gpstatement.bindColumn(9, idx_guarantee_amt);
      gpstatement.bindColumn(10, idx_lease_supply);
      gpstatement.bindColumn(11, idx_lease_vat);
      gpstatement.bindColumn(12, idx_s_date);
      gpstatement.bindColumn(13, idx_e_date);
      gpstatement.bindColumn(14, idx_moveinto_date);
      gpstatement.bindColumn(15, idx_real_name);
      gpstatement.bindColumn(16, idx_lease_chg_seq);
      gpstatement.bindColumn(17, idx_rent_chg_seq);
      gpstatement.bindColumn(18, idx_cont_zip_code);
      gpstatement.bindColumn(19, idx_cont_addr1);
      gpstatement.bindColumn(20, idx_cont_addr2);
      gpstatement.bindColumn(21, idx_moveinto_plan_date);
      gpstatement.bindColumn(22, idx_moveinto_code);
      gpstatement.bindColumn(23, idx_passwd);
      gpstatement.bindColumn(24, idx_input_date);
      gpstatement.bindColumn(25, idx_input_id);
      gpstatement.bindColumn(26, idx_remark);
		gpstatement.bindColumn(27, idx_exp_tag);
		gpstatement.bindColumn(28, idx_exp_date);
      gpstatement.bindColumn(29, idx_extra_1);
      gpstatement.bindColumn(30, idx_extra_2);
      gpstatement.bindColumn(31, idx_extra_3);
      gpstatement.bindColumn(32, idx_extra_4);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(33, idx_dept_code);
	   gpstatement.bindColumn(34, idx_sell_code);
		gpstatement.bindColumn(35, idx_cont_date);
		gpstatement.bindColumn(36, idx_cont_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_lease_master where dept_code=? and sell_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
		gpstatement.bindColumn(2, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>