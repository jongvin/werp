<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_chg_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_detail_unq_num = dSet.indexOfColumn("detail_unq_num");
   	int idx_chg_dt = dSet.indexOfColumn("chg_dt");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_businessman_number = dSet.indexOfColumn("businessman_number");
   	int idx_corp_no = dSet.indexOfColumn("corp_no");
   	int idx_zip_number1 = dSet.indexOfColumn("zip_number1");
   	int idx_address1 = dSet.indexOfColumn("address1");
   	int idx_tel_number1 = dSet.indexOfColumn("tel_number1");
   	int idx_rep_name1 = dSet.indexOfColumn("rep_name1");
   	int idx_rep_name2 = dSet.indexOfColumn("rep_name2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_SBCR_CHG ( sbcr_code," + 
                    "detail_unq_num," + 
                    "chg_dt," + 
                    "sbcr_name," + 
                    "businessman_number," + 
                    "corp_no," + 
                    "zip_number1," + 
                    "address1," + 
                    "tel_number1," + 
                    "rep_name1," + 
                    "rep_name2 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_detail_unq_num);
      gpstatement.bindColumn(3, idx_chg_dt);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_businessman_number);
      gpstatement.bindColumn(6, idx_corp_no);
      gpstatement.bindColumn(7, idx_zip_number1);
      gpstatement.bindColumn(8, idx_address1);
      gpstatement.bindColumn(9, idx_tel_number1);
      gpstatement.bindColumn(10, idx_rep_name1);
      gpstatement.bindColumn(11, idx_rep_name2);
      stmt.executeUpdate();
      stmt.close();
 	     sSql = "update s_sbcr set " + 
	                            "sbcr_name=?," + 
	                            "businessman_number=?," + 
	                            "corp_no=?," + 
	                            "zip_number1=?," + 
	                            "address1=?," + 
	                            "tel_number1=?," + 
	                            "rep_name1=?," + 
	                            "rep_name2=?" + 
	                            " where sbcr_code=? ";
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_sbcr_name);
	      gpstatement.bindColumn(2, idx_businessman_number);
	      gpstatement.bindColumn(3, idx_corp_no);
	      gpstatement.bindColumn(4, idx_zip_number1);
	      gpstatement.bindColumn(5, idx_address1);
	      gpstatement.bindColumn(6, idx_tel_number1);
	      gpstatement.bindColumn(7, idx_rep_name1);
	      gpstatement.bindColumn(8, idx_rep_name2);
	      gpstatement.bindColumn(9, idx_sbcr_code);
	      stmt.executeUpdate();
	      stmt.close();

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_sbcr_chg set " + 
                            "sbcr_code=?,  " + 
                            "detail_unq_num=?,  " + 
                            "chg_dt=?,  " + 
                            "sbcr_name=?,  " + 
                            "businessman_number=?,  " + 
                            "corp_no=?,  " + 
                            "zip_number1=?,  " + 
                            "address1=?,  " + 
                            "tel_number1=?,  " + 
                            "rep_name1=?,  " + 
                            "rep_name2=?  where sbcr_code=? " +
                            "               and detail_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_detail_unq_num);
      gpstatement.bindColumn(3, idx_chg_dt);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_businessman_number);
      gpstatement.bindColumn(6, idx_corp_no);
      gpstatement.bindColumn(7, idx_zip_number1);
      gpstatement.bindColumn(8, idx_address1);
      gpstatement.bindColumn(9, idx_tel_number1);
      gpstatement.bindColumn(10, idx_rep_name1);
      gpstatement.bindColumn(11, idx_rep_name2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_sbcr_code);
      gpstatement.bindColumn(13, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_sbcr_chg where sbcr_code=? " +
                            "               and detail_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_detail_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>