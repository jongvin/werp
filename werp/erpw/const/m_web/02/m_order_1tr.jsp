<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_order_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_deliverylimitdate = dSet.indexOfColumn("deliverylimitdate");
   	int idx_paymentmethod = dSet.indexOfColumn("paymentmethod");
   	int idx_eye = dSet.indexOfColumn("eye");
   	int idx_main_charge = dSet.indexOfColumn("main_charge");
   	int idx_main_pos = dSet.indexOfColumn("main_pos");
   	int idx_proj_charge = dSet.indexOfColumn("proj_charge");
   	int idx_proj_pos = dSet.indexOfColumn("proj_pos");
   	int idx_chrg_name1 = dSet.indexOfColumn("chrg_name1");
   	int idx_chrg_hp = dSet.indexOfColumn("chrg_hp");
   	int idx_chrg_tel_number2 = dSet.indexOfColumn("chrg_tel_number2");
   	int idx_fax_number = dSet.indexOfColumn("fax_number");
   	int idx_deliverymethod = dSet.indexOfColumn("deliverymethod");
   	int idx_place = dSet.indexOfColumn("place");
   	int idx_jukyo = dSet.indexOfColumn("jukyo");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_totamt = dSet.indexOfColumn("totamt");
   	int idx_remark1 = dSet.indexOfColumn("remark1");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_mat_amt = dSet.indexOfColumn("mat_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_ORDER ( unq_num," + 
                    "no_seq," + 
                    "approseq," + 
                    "long_name," + 
                    "sbcr_name," + 
                    "deliverylimitdate," + 
                    "paymentmethod," + 
                    "eye," + 
                    "main_charge," + 
                    "main_pos," + 
                    "proj_charge," + 
                    "proj_pos," + 
                    "chrg_name1," + 
                    "chrg_hp," + 
                    "chrg_tel_number2," + 
                    "fax_number," + 
                    "deliverymethod," + 
                    "place," + 
                    "jukyo," + 
                    "amt," + 
                    "vatamt," + 
                    "totamt," + 
                    "remark1," + 
                    "approym," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "unitprice," + 
                    "mat_amt )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_long_name);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_deliverylimitdate);
      gpstatement.bindColumn(7, idx_paymentmethod);
      gpstatement.bindColumn(8, idx_eye);
      gpstatement.bindColumn(9, idx_main_charge);
      gpstatement.bindColumn(10, idx_main_pos);
      gpstatement.bindColumn(11, idx_proj_charge);
      gpstatement.bindColumn(12, idx_proj_pos);
      gpstatement.bindColumn(13, idx_chrg_name1);
      gpstatement.bindColumn(14, idx_chrg_hp);
      gpstatement.bindColumn(15, idx_chrg_tel_number2);
      gpstatement.bindColumn(16, idx_fax_number);
      gpstatement.bindColumn(17, idx_deliverymethod);
      gpstatement.bindColumn(18, idx_place);
      gpstatement.bindColumn(19, idx_jukyo);
      gpstatement.bindColumn(20, idx_amt);
      gpstatement.bindColumn(21, idx_vatamt);
      gpstatement.bindColumn(22, idx_totamt);
      gpstatement.bindColumn(23, idx_remark1);
      gpstatement.bindColumn(24, idx_approym);
      gpstatement.bindColumn(25, idx_name);
      gpstatement.bindColumn(26, idx_ssize);
      gpstatement.bindColumn(27, idx_unitcode);
      gpstatement.bindColumn(28, idx_qty);
      gpstatement.bindColumn(29, idx_unitprice);
      gpstatement.bindColumn(30, idx_mat_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_order set " + 
                            "unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "approseq=?,  " + 
                            "long_name=?,  " + 
                            "sbcr_name=?,  " + 
                            "deliverylimitdate=?,  " + 
                            "paymentmethod=?,  " + 
                            "eye=?,  " + 
                            "main_charge=?,  " + 
                            "main_pos=?,  " + 
                            "proj_charge=?,  " + 
                            "proj_pos=?,  " + 
                            "chrg_name1=?,  " + 
                            "chrg_hp=?,  " + 
                            "chrg_tel_number2=?,  " + 
                            "fax_number=?,  " + 
                            "deliverymethod=?,  " + 
                            "place=?,  " + 
                            "jukyo=?,  " + 
                            "amt=?,  " + 
                            "vatamt=?,  " + 
                            "totamt=?,  " + 
                            "remark1=?,  " + 
                            "approym=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "mat_amt=?  where unq_num=? and no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_long_name);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_deliverylimitdate);
      gpstatement.bindColumn(7, idx_paymentmethod);
      gpstatement.bindColumn(8, idx_eye);
      gpstatement.bindColumn(9, idx_main_charge);
      gpstatement.bindColumn(10, idx_main_pos);
      gpstatement.bindColumn(11, idx_proj_charge);
      gpstatement.bindColumn(12, idx_proj_pos);
      gpstatement.bindColumn(13, idx_chrg_name1);
      gpstatement.bindColumn(14, idx_chrg_hp);
      gpstatement.bindColumn(15, idx_chrg_tel_number2);
      gpstatement.bindColumn(16, idx_fax_number);
      gpstatement.bindColumn(17, idx_deliverymethod);
      gpstatement.bindColumn(18, idx_place);
      gpstatement.bindColumn(19, idx_jukyo);
      gpstatement.bindColumn(20, idx_amt);
      gpstatement.bindColumn(21, idx_vatamt);
      gpstatement.bindColumn(22, idx_totamt);
      gpstatement.bindColumn(23, idx_remark1);
      gpstatement.bindColumn(24, idx_approym);
      gpstatement.bindColumn(25, idx_name);
      gpstatement.bindColumn(26, idx_ssize);
      gpstatement.bindColumn(27, idx_unitcode);
      gpstatement.bindColumn(28, idx_qty);
      gpstatement.bindColumn(29, idx_unitprice);
      gpstatement.bindColumn(30, idx_mat_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(31, idx_unq_num);
      gpstatement.bindColumn(32, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_order where unq_num=? and no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>