<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_cust_code_1tr"); 
     gpstatement.gp_dataset = dSet;
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_key_cust_code = dSet.indexOfColumn("key_cust_code");
   	int idx_tmp_cust_code = dSet.indexOfColumn("tmp_cust_code");
   	int idx_cust_type = dSet.indexOfColumn("cust_type");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_representative_name = dSet.indexOfColumn("representative_name");
   	int idx_kind_businesstype = dSet.indexOfColumn("kind_businesstype");
   	int idx_business_condition = dSet.indexOfColumn("business_condition");
   	int idx_tel_number = dSet.indexOfColumn("tel_number");
   	int idx_fax_number = dSet.indexOfColumn("fax_number");
   	int idx_zip_number = dSet.indexOfColumn("zip_number");
   	int idx_addr = dSet.indexOfColumn("addr");
   	int idx_cust_class = dSet.indexOfColumn("cust_class");
   	int idx_main_bank = dSet.indexOfColumn("main_bank");
   	int idx_acc_number = dSet.indexOfColumn("acc_number");
   	int idx_depositor = dSet.indexOfColumn("depositor");
   	int idx_trouble_tag = dSet.indexOfColumn("trouble_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Z_CODE_CUST_CODE ( cust_code," + 
                    "cust_type," + 
                    "cust_name," + 
                    "representative_name," + 
                    "kind_businesstype," + 
                    "business_condition," + 
                    "tel_number," + 
                    "fax_number," + 
                    "zip_number," + 
                    "addr," + 
                    "cust_class," + 
                    "main_bank," + 
                    "acc_number," + 
                    "depositor," + 
                    "trouble_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_tmp_cust_code);
      gpstatement.bindColumn(2, idx_cust_type);
      gpstatement.bindColumn(3, idx_cust_name);
      gpstatement.bindColumn(4, idx_representative_name);
      gpstatement.bindColumn(5, idx_kind_businesstype);
      gpstatement.bindColumn(6, idx_business_condition);
      gpstatement.bindColumn(7, idx_tel_number);
      gpstatement.bindColumn(8, idx_fax_number);
      gpstatement.bindColumn(9, idx_zip_number);
      gpstatement.bindColumn(10, idx_addr);
      gpstatement.bindColumn(11, idx_cust_class);
      gpstatement.bindColumn(12, idx_main_bank);
      gpstatement.bindColumn(13, idx_acc_number);
      gpstatement.bindColumn(14, idx_depositor);
      gpstatement.bindColumn(15, idx_trouble_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_cust_code set " + 
                            "cust_code=?,  " + 
                            "cust_type=?,  " + 
                            "cust_name=?,  " + 
                            "representative_name=?,  " + 
                            "kind_businesstype=?,  " + 
                            "business_condition=?,  " + 
                            "tel_number=?,  " + 
                            "fax_number=?,  " + 
                            "zip_number=?,  " + 
                            "addr=?,  " + 
                            "cust_class=?,  " + 
                            "main_bank=?,  " + 
                            "acc_number=?,  " + 
                            "depositor=?,  " + 
                            "trouble_tag=?  where cust_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_tmp_cust_code);
      gpstatement.bindColumn(2, idx_cust_type);
      gpstatement.bindColumn(3, idx_cust_name);
      gpstatement.bindColumn(4, idx_representative_name);
      gpstatement.bindColumn(5, idx_kind_businesstype);
      gpstatement.bindColumn(6, idx_business_condition);
      gpstatement.bindColumn(7, idx_tel_number);
      gpstatement.bindColumn(8, idx_fax_number);
      gpstatement.bindColumn(9, idx_zip_number);
      gpstatement.bindColumn(10, idx_addr);
      gpstatement.bindColumn(11, idx_cust_class);
      gpstatement.bindColumn(12, idx_main_bank);
      gpstatement.bindColumn(13, idx_acc_number);
      gpstatement.bindColumn(14, idx_depositor);
      gpstatement.bindColumn(15, idx_trouble_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_key_cust_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_cust_code where cust_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_cust_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>