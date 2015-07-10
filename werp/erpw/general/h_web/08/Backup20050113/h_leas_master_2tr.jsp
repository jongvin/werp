<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_leas_master_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_key_contract_date = dSet.indexOfColumn("key_contract_date");
   	int idx_contract_div = dSet.indexOfColumn("contract_div");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_house_type = dSet.indexOfColumn("house_type");
   	int idx_vat_yn = dSet.indexOfColumn("vat_yn");
   	int idx_guarantee_amt = dSet.indexOfColumn("guarantee_amt");
   	int idx_lease_supply = dSet.indexOfColumn("lease_supply");
   	int idx_lease_vat = dSet.indexOfColumn("lease_vat");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_moveinto_date = dSet.indexOfColumn("moveinto_date");
   	int idx_real_name = dSet.indexOfColumn("real_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_LEAS_MASTER ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "contract_date," + 
                    "contract_div," + 
                    "cust_code," + 
                    "house_type," + 
                    "vat_yn," +
                    "guarantee_amt," + 
                    "lease_supply," + 
                    "lease_vat," + 
                    "s_date," + 
                    "e_date," + 
                    "moveinto_date,"+
                    "real_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_contract_date);
      gpstatement.bindColumn(6, idx_contract_div);
      gpstatement.bindColumn(7, idx_cust_code);
      gpstatement.bindColumn(8, idx_house_type);
      gpstatement.bindColumn(9, idx_vat_yn);
      gpstatement.bindColumn(10, idx_guarantee_amt);
      gpstatement.bindColumn(11, idx_lease_supply);
      gpstatement.bindColumn(12, idx_lease_vat);
      gpstatement.bindColumn(13, idx_s_date);
      gpstatement.bindColumn(14, idx_e_date);
      gpstatement.bindColumn(15, idx_moveinto_date);
      gpstatement.bindColumn(16, idx_real_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_leas_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "contract_date=?,  " + 
                            "contract_div=?,  " + 
                            "cust_code=?,  " + 
                            "house_type=?,  " + 
                            "vat_yn=?,  " + 
                            "guarantee_amt=?,  " + 
                            "lease_supply=?,  " + 
                            "lease_vat=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "real_name=?, " +
                            "moveinto_date=?  where dept_code=? " +
      					       "                   and sell_code=? " +
      					       "                   and dongho=? " +
      					       "                   and seq=? " +
      					       "                   and contract_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_contract_date);
      gpstatement.bindColumn(6, idx_contract_div);
      gpstatement.bindColumn(7, idx_cust_code);
      gpstatement.bindColumn(8, idx_house_type);
      gpstatement.bindColumn(9, idx_vat_yn);
      gpstatement.bindColumn(10, idx_guarantee_amt);
      gpstatement.bindColumn(11, idx_lease_supply);
      gpstatement.bindColumn(12, idx_lease_vat);
      gpstatement.bindColumn(13, idx_s_date);
      gpstatement.bindColumn(14, idx_e_date);
      gpstatement.bindColumn(15, idx_real_name);
      gpstatement.bindColumn(16, idx_moveinto_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_dept_code);
      gpstatement.bindColumn(18, idx_sell_code);
      gpstatement.bindColumn(19, idx_dongho);
      gpstatement.bindColumn(20, idx_seq);
      gpstatement.bindColumn(21, idx_key_contract_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_leas_master where dept_code=? " +
      					"                           and sell_code=? " +
      					"                           and dongho=? " +
      					"                           and seq=? " +
      					"                           and contract_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_key_contract_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>