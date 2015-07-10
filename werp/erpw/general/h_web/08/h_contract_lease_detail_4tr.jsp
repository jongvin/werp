<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_lease_detail_4tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_cont_seq = dSet.indexOfColumn("cont_seq");
   	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
   	int idx_apply_date = dSet.indexOfColumn("apply_date");
		int idx_apply_date_edit = dSet.indexOfColumn("apply_date_edit");
   	int idx_rent_amt = dSet.indexOfColumn("rent_amt");
   	int idx_rent_vat = dSet.indexOfColumn("rent_vat");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;

	  String str_apply_date = rows.getString(idx_apply_date_edit);
	  str_apply_date = str_apply_date + ".01";
	  rows.setString( idx_apply_date,  str_apply_date);
	  /*사용자가 입력한 년월(yyyy.mm) 에다가 .01 을 붙여서 데이트형식 으로 저장한다*/  

	
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_lease_rent_detail ( dept_code," + 
                    "sell_code," + 
                    "cont_date," + 
                    "cont_seq," + 
                    "chg_seq," + 
                    "apply_date," + 
                    "rent_amt," + 
                    "rent_vat )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_chg_seq);
		gpstatement.bindColumn(6, idx_apply_date);
      gpstatement.bindColumn(7, idx_rent_amt);
      gpstatement.bindColumn(8, idx_rent_vat);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_lease_rent_detail set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cont_date=?,  " + 
                            "cont_seq=?,  " + 
                            "chg_seq=?,  " + 
                            "apply_date=?,  " + 
                            "rent_amt=?,  " + 
                            "rent_vat=?  where dept_code=? and sell_code=? and cont_date=? and cont_seq=? and chg_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_chg_seq);
      gpstatement.bindColumn(6, idx_apply_date);
      gpstatement.bindColumn(7, idx_rent_amt);
      gpstatement.bindColumn(8, idx_rent_vat);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
	   gpstatement.bindColumn(10, idx_sell_code);
      gpstatement.bindColumn(11, idx_cont_date);
      gpstatement.bindColumn(12, idx_cont_seq);
      gpstatement.bindColumn(13, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_lease_rent_detail where dept_code=? and sell_code=? and cont_date=? and cont_seq=? and chg_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
		gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>