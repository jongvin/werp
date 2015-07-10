<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_code_membership_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_membership_no = dSet.indexOfColumn("membership_no");
   	int idx_key_membership_no = dSet.indexOfColumn("key_membership_no");
   	int idx_company_tag = dSet.indexOfColumn("company_tag");
   	int idx_membership_name = dSet.indexOfColumn("membership_name");
   	int idx_cont_limit_amt = dSet.indexOfColumn("cont_limit_amt");
   	int idx_customer_tag = dSet.indexOfColumn("customer_tag");
   	int idx_customer_no = dSet.indexOfColumn("customer_no");
   	int idx_corp_no = dSet.indexOfColumn("corp_no");
   	int idx_membership_name_long = dSet.indexOfColumn("membership_name_long");
   	int idx_membership_name_eng = dSet.indexOfColumn("membership_name_eng");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_category = dSet.indexOfColumn("category");
   	int idx_condition = dSet.indexOfColumn("condition");
   	int idx_tel = dSet.indexOfColumn("tel");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr = dSet.indexOfColumn("addr");
   	int idx_limitamt_all = dSet.indexOfColumn("limitamt_all");
   	int idx_limitamt_const = dSet.indexOfColumn("limitamt_const");
   	int idx_limitamt_arch = dSet.indexOfColumn("limitamt_arch");
   	int idx_position = dSet.indexOfColumn("position");
   	int idx_comp_guarantee = dSet.indexOfColumn("comp_guarantee");
   	int idx_emp_status = dSet.indexOfColumn("emp_status");
   	int idx_l_tel = dSet.indexOfColumn("l_tel");
   	int idx_l_fax = dSet.indexOfColumn("l_fax");
   	int idx_l_zipcode = dSet.indexOfColumn("l_zipcode");
   	int idx_l_addr = dSet.indexOfColumn("l_addr");
   	int idx_licence_status = dSet.indexOfColumn("licence_status");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CODE_MEMBERSHIP ( membership_no," + 
                    "company_tag," + 
                    "membership_name," + 
                    "cont_limit_amt," + 
                    "customer_tag," + 
                    "customer_no," + 
                    "corp_no," + 
                    "membership_name_long," + 
                    "membership_name_eng," + 
                    "owner," + 
                    "category," + 
                    "condition," + 
                    "tel," + 
                    "fax," + 
                    "zip_code," + 
                    "addr," + 
                    "limitamt_all," + 
                    "limitamt_const," + 
                    "limitamt_arch," + 
                    "position," + 
                    "comp_guarantee," + 
                    "emp_status," + 
                    "l_tel," + 
                    "l_fax," + 
                    "l_zipcode," + 
                    "l_addr," + 
                    "licence_status," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_membership_no);
      gpstatement.bindColumn(2, idx_company_tag);
      gpstatement.bindColumn(3, idx_membership_name);
      gpstatement.bindColumn(4, idx_cont_limit_amt);
      gpstatement.bindColumn(5, idx_customer_tag);
      gpstatement.bindColumn(6, idx_customer_no);
      gpstatement.bindColumn(7, idx_corp_no);
      gpstatement.bindColumn(8, idx_membership_name_long);
      gpstatement.bindColumn(9, idx_membership_name_eng);
      gpstatement.bindColumn(10, idx_owner);
      gpstatement.bindColumn(11, idx_category);
      gpstatement.bindColumn(12, idx_condition);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_fax);
      gpstatement.bindColumn(15, idx_zip_code);
      gpstatement.bindColumn(16, idx_addr);
      gpstatement.bindColumn(17, idx_limitamt_all);
      gpstatement.bindColumn(18, idx_limitamt_const);
      gpstatement.bindColumn(19, idx_limitamt_arch);
      gpstatement.bindColumn(20, idx_position);
      gpstatement.bindColumn(21, idx_comp_guarantee);
      gpstatement.bindColumn(22, idx_emp_status);
      gpstatement.bindColumn(23, idx_l_tel);
      gpstatement.bindColumn(24, idx_l_fax);
      gpstatement.bindColumn(25, idx_l_zipcode);
      gpstatement.bindColumn(26, idx_l_addr);
      gpstatement.bindColumn(27, idx_licence_status);
      gpstatement.bindColumn(28, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_code_membership set " + 
                            "membership_no=?,  " + 
                            "company_tag=?,  " + 
                            "membership_name=?,  " + 
                            "cont_limit_amt=?,  " + 
                            "customer_tag=?,  " + 
                            "customer_no=?,  " + 
                            "corp_no=?,  " + 
                            "membership_name_long=?,  " + 
                            "membership_name_eng=?,  " + 
                            "owner=?,  " + 
                            "category=?,  " + 
                            "condition=?,  " + 
                            "tel=?,  " + 
                            "fax=?,  " + 
                            "zip_code=?,  " + 
                            "addr=?,  " + 
                            "limitamt_all=?,  " + 
                            "limitamt_const=?,  " + 
                            "limitamt_arch=?,  " + 
                            "position=?,  " + 
                            "comp_guarantee=?,  " + 
                            "emp_status=?,  " + 
                            "l_tel=?,  " + 
                            "l_fax=?,  " + 
                            "l_zipcode=?,  " + 
                            "l_addr=?,  " + 
                            "licence_status=?,  " + 
                            "remark=?  where membership_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_membership_no);
      gpstatement.bindColumn(2, idx_company_tag);
      gpstatement.bindColumn(3, idx_membership_name);
      gpstatement.bindColumn(4, idx_cont_limit_amt);
      gpstatement.bindColumn(5, idx_customer_tag);
      gpstatement.bindColumn(6, idx_customer_no);
      gpstatement.bindColumn(7, idx_corp_no);
      gpstatement.bindColumn(8, idx_membership_name_long);
      gpstatement.bindColumn(9, idx_membership_name_eng);
      gpstatement.bindColumn(10, idx_owner);
      gpstatement.bindColumn(11, idx_category);
      gpstatement.bindColumn(12, idx_condition);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_fax);
      gpstatement.bindColumn(15, idx_zip_code);
      gpstatement.bindColumn(16, idx_addr);
      gpstatement.bindColumn(17, idx_limitamt_all);
      gpstatement.bindColumn(18, idx_limitamt_const);
      gpstatement.bindColumn(19, idx_limitamt_arch);
      gpstatement.bindColumn(20, idx_position);
      gpstatement.bindColumn(21, idx_comp_guarantee);
      gpstatement.bindColumn(22, idx_emp_status);
      gpstatement.bindColumn(23, idx_l_tel);
      gpstatement.bindColumn(24, idx_l_fax);
      gpstatement.bindColumn(25, idx_l_zipcode);
      gpstatement.bindColumn(26, idx_l_addr);
      gpstatement.bindColumn(27, idx_licence_status);
      gpstatement.bindColumn(28, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(29, idx_key_membership_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_code_membership where membership_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_membership_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>