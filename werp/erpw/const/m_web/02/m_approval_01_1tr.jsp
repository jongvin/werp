<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_01_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_deliverylimitdate = dSet.indexOfColumn("deliverylimitdate");
   	int idx_deliverymethod = dSet.indexOfColumn("deliverymethod");
   	int idx_paymentmethod = dSet.indexOfColumn("paymentmethod");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_sbcr_name1 = dSet.indexOfColumn("sbcr_name1");
   	int idx_sbcr_name2 = dSet.indexOfColumn("sbcr_name2");
   	int idx_sbcr_name3 = dSet.indexOfColumn("sbcr_name3");
   	int idx_bud_amt = dSet.indexOfColumn("bud_amt");
   	int idx_amt1 = dSet.indexOfColumn("amt1");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
   	int idx_rate_1 = dSet.indexOfColumn("rate_1");
   	int idx_rate_2 = dSet.indexOfColumn("rate_2");
   	int idx_rate_3 = dSet.indexOfColumn("rate_3");
   	int idx_remark1 = dSet.indexOfColumn("remark1");
   	int idx_title = dSet.indexOfColumn("title");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL_01 ( unq_num," + 
                    "long_name," + 
                    "deliverylimitdate," + 
                    "deliverymethod," + 
                    "paymentmethod," + 
                    "name," + 
                    "sbcr_name1," + 
                    "sbcr_name2," + 
                    "sbcr_name3," + 
                    "bud_amt," + 
                    "amt1," + 
                    "amt," + 
                    "vat," + 
                    "tot_amt," + 
                    "rate_1," + 
                    "rate_2," + 
                    "rate_3," + 
                    "remark1," + 
                    "title )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_deliverylimitdate);
      gpstatement.bindColumn(4, idx_deliverymethod);
      gpstatement.bindColumn(5, idx_paymentmethod);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_sbcr_name1);
      gpstatement.bindColumn(8, idx_sbcr_name2);
      gpstatement.bindColumn(9, idx_sbcr_name3);
      gpstatement.bindColumn(10, idx_bud_amt);
      gpstatement.bindColumn(11, idx_amt1);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_vat);
      gpstatement.bindColumn(14, idx_tot_amt);
      gpstatement.bindColumn(15, idx_rate_1);
      gpstatement.bindColumn(16, idx_rate_2);
      gpstatement.bindColumn(17, idx_rate_3);
      gpstatement.bindColumn(18, idx_remark1);
      gpstatement.bindColumn(19, idx_title);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval_01 set " + 
                            "unq_num=?,  " + 
                            "long_name=?,  " + 
                            "deliverylimitdate=?,  " + 
                            "deliverymethod=?,  " + 
                            "paymentmethod=?,  " + 
                            "name=?,  " + 
                            "sbcr_name1=?,  " + 
                            "sbcr_name2=?,  " + 
                            "sbcr_name3=?,  " + 
                            "bud_amt=?,  " + 
                            "amt1=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "tot_amt=?,  " + 
                            "rate_1=?,  " + 
                            "rate_2=?,  " + 
                            "rate_3=?,  " + 
                            "remark1=?,  " + 
                            "title=?  where unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_deliverylimitdate);
      gpstatement.bindColumn(4, idx_deliverymethod);
      gpstatement.bindColumn(5, idx_paymentmethod);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_sbcr_name1);
      gpstatement.bindColumn(8, idx_sbcr_name2);
      gpstatement.bindColumn(9, idx_sbcr_name3);
      gpstatement.bindColumn(10, idx_bud_amt);
      gpstatement.bindColumn(11, idx_amt1);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_vat);
      gpstatement.bindColumn(14, idx_tot_amt);
      gpstatement.bindColumn(15, idx_rate_1);
      gpstatement.bindColumn(16, idx_rate_2);
      gpstatement.bindColumn(17, idx_rate_3);
      gpstatement.bindColumn(18, idx_remark1);
      gpstatement.bindColumn(19, idx_title);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(20, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_approval_01 where unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>