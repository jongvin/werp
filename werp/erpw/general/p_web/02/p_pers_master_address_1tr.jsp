<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_address_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_born_code = dSet.indexOfColumn("born_code");
   	int idx_hobby_code = dSet.indexOfColumn("hobby_code");
   	int idx_religion_code = dSet.indexOfColumn("religion_code");
   	int idx_birthday = dSet.indexOfColumn("birthday");
   	int idx_lunar_solar = dSet.indexOfColumn("lunar_solar");
   	int idx_talent = dSet.indexOfColumn("talent");
   	int idx_married_yn = dSet.indexOfColumn("married_yn");
   	int idx_married_ann_date = dSet.indexOfColumn("married_ann_date");
   	int idx_householder_relation = dSet.indexOfColumn("householder_relation");
   	int idx_born_area = dSet.indexOfColumn("born_area");
   	int idx_householder = dSet.indexOfColumn("householder");
   	int idx_householder_job = dSet.indexOfColumn("householder_job");
   	int idx_born_zip_code = dSet.indexOfColumn("born_zip_code");
   	int idx_born_addr1 = dSet.indexOfColumn("born_addr1");
   	int idx_born_addr2 = dSet.indexOfColumn("born_addr2");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_resi_zip_code = dSet.indexOfColumn("resi_zip_code");
   	int idx_resi_addr1 = dSet.indexOfColumn("resi_addr1");
   	int idx_resi_addr2 = dSet.indexOfColumn("resi_addr2");
   	int idx_house_phone = dSet.indexOfColumn("house_phone");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_cell_phone = dSet.indexOfColumn("cell_phone");
   	int idx_e_mail = dSet.indexOfColumn("e_mail");
   	int idx_homepage = dSet.indexOfColumn("homepage");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_sex_div = dSet.indexOfColumn("sex_div");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_address ( resident_no," + 
                    "born_code," + 
                    "hobby_code," + 
                    "religion_code," + 
                    "birthday," + 
                    "lunar_solar," + 
                    "talent," + 
                    "married_yn," + 
                    "married_ann_date," + 
                    "householder_relation," + 
                    "born_area," + 
                    "householder," + 
                    "householder_job," + 
                    "born_zip_code," + 
                    "born_addr1," + 
                    "born_addr2," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "resi_zip_code," + 
                    "resi_addr1," + 
                    "resi_addr2," + 
                    "house_phone," + 
                    "fax," + 
                    "cell_phone," + 
                    "e_mail," + 
                    "homepage," + 
                    "remark," + 
                    "sex_div )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_born_code);
      gpstatement.bindColumn(3, idx_hobby_code);
      gpstatement.bindColumn(4, idx_religion_code);
      gpstatement.bindColumn(5, idx_birthday);
      gpstatement.bindColumn(6, idx_lunar_solar);
      gpstatement.bindColumn(7, idx_talent);
      gpstatement.bindColumn(8, idx_married_yn);
      gpstatement.bindColumn(9, idx_married_ann_date);
      gpstatement.bindColumn(10, idx_householder_relation);
      gpstatement.bindColumn(11, idx_born_area);
      gpstatement.bindColumn(12, idx_householder);
      gpstatement.bindColumn(13, idx_householder_job);
      gpstatement.bindColumn(14, idx_born_zip_code);
      gpstatement.bindColumn(15, idx_born_addr1);
      gpstatement.bindColumn(16, idx_born_addr2);
      gpstatement.bindColumn(17, idx_zip_code);
      gpstatement.bindColumn(18, idx_addr1);
      gpstatement.bindColumn(19, idx_addr2);
      gpstatement.bindColumn(20, idx_resi_zip_code);
      gpstatement.bindColumn(21, idx_resi_addr1);
      gpstatement.bindColumn(22, idx_resi_addr2);
      gpstatement.bindColumn(23, idx_house_phone);
      gpstatement.bindColumn(24, idx_fax);
      gpstatement.bindColumn(25, idx_cell_phone);
      gpstatement.bindColumn(26, idx_e_mail);
      gpstatement.bindColumn(27, idx_homepage);
      gpstatement.bindColumn(28, idx_remark);
      gpstatement.bindColumn(29, idx_sex_div);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_address set " + 
                            "resident_no=?,  " + 
                            "born_code=?,  " + 
                            "hobby_code=?,  " + 
                            "religion_code=?,  " + 
                            "birthday=?,  " + 
                            "lunar_solar=?,  " + 
                            "talent=?,  " + 
                            "married_yn=?,  " + 
                            "married_ann_date=?,  " + 
                            "householder_relation=?,  " + 
                            "born_area=?,  " + 
                            "householder=?,  " + 
                            "householder_job=?,  " + 
                            "born_zip_code=?,  " + 
                            "born_addr1=?,  " + 
                            "born_addr2=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "resi_zip_code=?,  " + 
                            "resi_addr1=?,  " + 
                            "resi_addr2=?,  " + 
                            "house_phone=?,  " + 
                            "fax=?,  " + 
                            "cell_phone=?,  " + 
                            "e_mail=?,  " + 
                            "homepage=?,  " + 
                            "remark=?,  " + 
                            "sex_div=?  where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_born_code);
      gpstatement.bindColumn(3, idx_hobby_code);
      gpstatement.bindColumn(4, idx_religion_code);
      gpstatement.bindColumn(5, idx_birthday);
      gpstatement.bindColumn(6, idx_lunar_solar);
      gpstatement.bindColumn(7, idx_talent);
      gpstatement.bindColumn(8, idx_married_yn);
      gpstatement.bindColumn(9, idx_married_ann_date);
      gpstatement.bindColumn(10, idx_householder_relation);
      gpstatement.bindColumn(11, idx_born_area);
      gpstatement.bindColumn(12, idx_householder);
      gpstatement.bindColumn(13, idx_householder_job);
      gpstatement.bindColumn(14, idx_born_zip_code);
      gpstatement.bindColumn(15, idx_born_addr1);
      gpstatement.bindColumn(16, idx_born_addr2);
      gpstatement.bindColumn(17, idx_zip_code);
      gpstatement.bindColumn(18, idx_addr1);
      gpstatement.bindColumn(19, idx_addr2);
      gpstatement.bindColumn(20, idx_resi_zip_code);
      gpstatement.bindColumn(21, idx_resi_addr1);
      gpstatement.bindColumn(22, idx_resi_addr2);
      gpstatement.bindColumn(23, idx_house_phone);
      gpstatement.bindColumn(24, idx_fax);
      gpstatement.bindColumn(25, idx_cell_phone);
      gpstatement.bindColumn(26, idx_e_mail);
      gpstatement.bindColumn(27, idx_homepage);
      gpstatement.bindColumn(28, idx_remark);
      gpstatement.bindColumn(29, idx_sex_div);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(30, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_address where resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>