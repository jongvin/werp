<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_guarantee_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_guarantee_div = dSet.indexOfColumn("guarantee_div");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_guarantor_name1 = dSet.indexOfColumn("guarantor_name1");
   	int idx_rrn1 = dSet.indexOfColumn("rrn1");
   	int idx_property_tax1 = dSet.indexOfColumn("property_tax1");
   	int idx_zip_code1 = dSet.indexOfColumn("zip_code1");
   	int idx_addr1_1 = dSet.indexOfColumn("addr1_1");
   	int idx_addr2_1 = dSet.indexOfColumn("addr2_1");
   	int idx_relation1 = dSet.indexOfColumn("relation1");
   	int idx_guarantor_name2 = dSet.indexOfColumn("guarantor_name2");
   	int idx_rrn2 = dSet.indexOfColumn("rrn2");
   	int idx_property_tax2 = dSet.indexOfColumn("property_tax2");
   	int idx_zip_code2 = dSet.indexOfColumn("zip_code2");
   	int idx_addr1_2 = dSet.indexOfColumn("addr1_2");
   	int idx_addr2_2 = dSet.indexOfColumn("addr2_2");
   	int idx_relation2 = dSet.indexOfColumn("relation2");
   	int idx_insu_s_date = dSet.indexOfColumn("insu_s_date");
   	int idx_insu_e_date = dSet.indexOfColumn("insu_e_date");
   	int idx_insu_comp_code = dSet.indexOfColumn("insu_comp_code");
   	int idx_insurence_amt = dSet.indexOfColumn("insurence_amt");
   	int idx_compensation_amt = dSet.indexOfColumn("compensation_amt");
   	int idx_securities_no1 = dSet.indexOfColumn("securities_no1");
   	int idx_securities_no2 = dSet.indexOfColumn("securities_no2");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_guarantee ( resident_no," + 
                    "guarantee_div," + 
                    "s_date," + 
                    "e_date," + 
                    "guarantor_name1," + 
                    "rrn1," + 
                    "property_tax1," + 
                    "zip_code1," + 
                    "addr1_1," + 
                    "addr2_1," + 
                    "relation1," + 
                    "guarantor_name2," + 
                    "rrn2," + 
                    "property_tax2," + 
                    "zip_code2," + 
                    "addr1_2," + 
                    "addr2_2," + 
                    "relation2," + 
                    "insu_s_date," + 
                    "insu_e_date," + 
                    "insu_comp_code," + 
                    "insurence_amt," + 
                    "compensation_amt," + 
                    "securities_no1," + 
                    "securities_no2," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_guarantee_div);
      gpstatement.bindColumn(3, idx_s_date);
      gpstatement.bindColumn(4, idx_e_date);
      gpstatement.bindColumn(5, idx_guarantor_name1);
      gpstatement.bindColumn(6, idx_rrn1);
      gpstatement.bindColumn(7, idx_property_tax1);
      gpstatement.bindColumn(8, idx_zip_code1);
      gpstatement.bindColumn(9, idx_addr1_1);
      gpstatement.bindColumn(10, idx_addr2_1);
      gpstatement.bindColumn(11, idx_relation1);
      gpstatement.bindColumn(12, idx_guarantor_name2);
      gpstatement.bindColumn(13, idx_rrn2);
      gpstatement.bindColumn(14, idx_property_tax2);
      gpstatement.bindColumn(15, idx_zip_code2);
      gpstatement.bindColumn(16, idx_addr1_2);
      gpstatement.bindColumn(17, idx_addr2_2);
      gpstatement.bindColumn(18, idx_relation2);
      gpstatement.bindColumn(19, idx_insu_s_date);
      gpstatement.bindColumn(20, idx_insu_e_date);
      gpstatement.bindColumn(21, idx_insu_comp_code);
      gpstatement.bindColumn(22, idx_insurence_amt);
      gpstatement.bindColumn(23, idx_compensation_amt);
      gpstatement.bindColumn(24, idx_securities_no1);
      gpstatement.bindColumn(25, idx_securities_no2);
      gpstatement.bindColumn(26, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_guarantee set " + 
                            "resident_no=?,  " + 
                            "guarantee_div=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "guarantor_name1=?,  " + 
                            "rrn1=?,  " + 
                            "property_tax1=?,  " + 
                            "zip_code1=?,  " + 
                            "addr1_1=?,  " + 
                            "addr2_1=?,  " + 
                            "relation1=?,  " + 
                            "guarantor_name2=?,  " + 
                            "rrn2=?,  " + 
                            "property_tax2=?,  " + 
                            "zip_code2=?,  " + 
                            "addr1_2=?,  " + 
                            "addr2_2=?,  " + 
                            "relation2=?,  " + 
                            "insu_s_date=?,  " + 
                            "insu_e_date=?,  " + 
                            "insu_comp_code=?,  " + 
                            "insurence_amt=?,  " + 
                            "compensation_amt=?,  " + 
                            "securities_no1=?,  " + 
                            "securities_no2=?,  " + 
                            "remark=?  where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_guarantee_div);
      gpstatement.bindColumn(3, idx_s_date);
      gpstatement.bindColumn(4, idx_e_date);
      gpstatement.bindColumn(5, idx_guarantor_name1);
      gpstatement.bindColumn(6, idx_rrn1);
      gpstatement.bindColumn(7, idx_property_tax1);
      gpstatement.bindColumn(8, idx_zip_code1);
      gpstatement.bindColumn(9, idx_addr1_1);
      gpstatement.bindColumn(10, idx_addr2_1);
      gpstatement.bindColumn(11, idx_relation1);
      gpstatement.bindColumn(12, idx_guarantor_name2);
      gpstatement.bindColumn(13, idx_rrn2);
      gpstatement.bindColumn(14, idx_property_tax2);
      gpstatement.bindColumn(15, idx_zip_code2);
      gpstatement.bindColumn(16, idx_addr1_2);
      gpstatement.bindColumn(17, idx_addr2_2);
      gpstatement.bindColumn(18, idx_relation2);
      gpstatement.bindColumn(19, idx_insu_s_date);
      gpstatement.bindColumn(20, idx_insu_e_date);
      gpstatement.bindColumn(21, idx_insu_comp_code);
      gpstatement.bindColumn(22, idx_insurence_amt);
      gpstatement.bindColumn(23, idx_compensation_amt);
      gpstatement.bindColumn(24, idx_securities_no1);
      gpstatement.bindColumn(25, idx_securities_no2);
      gpstatement.bindColumn(26, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(27, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_guarantee where resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>