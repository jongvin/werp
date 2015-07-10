<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("A_AS_SBCR_INPUT_1tr");
     gpstatement.gp_dataset = dSet;
 		int idx_sbcr_useq = dSet.indexOfColumn("sbcr_useq");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_sbcr_kind_tag = dSet.indexOfColumn("sbcr_kind_tag");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_contract_name = dSet.indexOfColumn("contract_name");
   	int idx_chrg_name = dSet.indexOfColumn("chrg_name");
		int idx_chrg_phone = dSet.indexOfColumn("chrg_phone");
   	int idx_chrg_cell = dSet.indexOfColumn("chrg_cell");
		int idx_chrg_fax = dSet.indexOfColumn("chrg_fax");
		int idx_remark = dSet.indexOfColumn("remark");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " insert into A_AS_SBCR								" +
					  "	  ( sbcr_useq ,										" +
					  "	   dept_code ,											" +
					  "		sbcr_kind_tag ,									" +
					  "		sbcr_code ,											" +
					  "		sbcr_name ,											" +
					  "		contract_name ,									" +
					  "		chrg_name ,											" +
					  "		chrg_phone ,										" +
					  "		chrg_cell ,											" +
					  "		chrg_fax ,											" +
					  "		remark 												" +
					  "	  )														" ;
      sSql = sSql + " VALUES ( sq_a_as_sbcr_useq.nextval  ,			" +
					  "   :1, :2, :3, :4, :5, :6, :7, :8 ,:9 ,:10)		" ;
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
		gpstatement.bindColumn(2, idx_sbcr_kind_tag);
		gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_contract_name);
      gpstatement.bindColumn(6, idx_chrg_name);
      gpstatement.bindColumn(7, idx_chrg_phone);
      gpstatement.bindColumn(8, idx_chrg_cell);
      gpstatement.bindColumn(9, idx_chrg_fax);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update A_AS_SBCR set					" + 
					  "	   dept_code =? ,						" +
					  "		sbcr_kind_tag=? ,					" +
					  "		sbcr_code =?,						" +
					  "		sbcr_name =?,						" +
					  "		contract_name =?,					" +
					  "		chrg_name =?,						" +
					  "		chrg_phone =?,						" +
					  "		chrg_cell =?,						" +
					  "		chrg_fax =?,						" +
					  "		remark =?							" +
					  "  where sbcr_useq=?						" ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_kind_tag);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_contract_name);
      gpstatement.bindColumn(6, idx_chrg_name);
      gpstatement.bindColumn(7, idx_chrg_phone);
      gpstatement.bindColumn(8, idx_chrg_cell);
      gpstatement.bindColumn(9, idx_chrg_fax);
      gpstatement.bindColumn(10, idx_remark);
  /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_sbcr_useq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from A_AS_SBCR where sbcr_useq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_useq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>