<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("A_AS_SBCR_INPUT_POP_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_chk = dSet.indexOfColumn("chk");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_contract_name = dSet.indexOfColumn("contract_name");
   	int idx_chrg_name = dSet.indexOfColumn("chrg_name");
		int idx_chrg_phone = dSet.indexOfColumn("chrg_phone");
   	int idx_chrg_cell = dSet.indexOfColumn("chrg_cell");
		int idx_chrg_fax = dSet.indexOfColumn("chrg_fax");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
/*		String sSql = " insert into A_AS_SBCR								" +
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
					  "   :1, '1', :2, :3,	:4, :5, :6, :7, :8	)		" ;

      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_contract_name);
      gpstatement.bindColumn(5, idx_chrg_name);
      gpstatement.bindColumn(6, idx_chrg_phone);
      gpstatement.bindColumn(7, idx_chrg_cell);
      gpstatement.bindColumn(8, idx_chrg_fax);
      stmt.executeUpdate();
      stmt.close();
*/
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
		String sSql = " insert into A_AS_SBCR								" +
					  "	  ( sbcr_useq ,										" +
					  "	   dept_code ,											" +
					  "		sbcr_kind_tag ,									" +
					  "		sbcr_code ,											" +
					  "		sbcr_name ,											" +
					  "		chrg_name ,											" +
					  "		chrg_phone ,										" +
					  "		chrg_cell ,											" +
					  "		chrg_fax 											" +
					  "	  )														" ;
      sSql = sSql + " VALUES ( sq_a_as_sbcr_useq.nextval  ,			" +
					  "   :1, '1', :2, :3,	:4, :5, :6, :7	)		" ;
	 try
		{
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_chrg_name);
      gpstatement.bindColumn(5, idx_chrg_phone);
      gpstatement.bindColumn(6, idx_chrg_cell);
      gpstatement.bindColumn(7, idx_chrg_fax);
      stmt.executeUpdate();
      stmt.close();
 		}
		catch (Exception ex)
		{
			res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n����:" + sSql);
		}
/*     String sSql = "update A_AS_SBCR set					" + 
					  "	   dept_code =? ,						" +
					  "		sbcr_code =?,						" +
					  "		sbcr_name =?,						" +
					  "		contract_name =?,					" +
					  "		chrg_name =?,						" +
					  "		chrg_phone =?,						" +
					  "		chrg_cell =?,						" +
					  "		chrg_fax =?,						" +
					  "		remark =?,							" +
					  "  where sbcr_useq=?						" ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_contract_name);
      gpstatement.bindColumn(4, idx_chrg_name);
      gpstatement.bindColumn(5, idx_chrg_phone);
      gpstatement.bindColumn(6, idx_chrg_cell);
      gpstatement.bindColumn(7, idx_chrg_fax);
 */
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
 //     gpstatement.bindColumn(8, idx_sbcr_useq);
 //     stmt.executeUpdate();
 //     stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
//      String sSql = "delete from A_AS_SBCR where sbcr_useq=? "; 
//      stmt = conn.prepareStatement(sSql); 
//      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
//    gpstatement.bindColumn(1, idx_sbcr_useq);
//    stmt.executeUpdate();
//      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>