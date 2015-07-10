<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("E_sa_amt_monthly_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
	   int idx_item_code = dSet.indexOfColumn("item_code");
   	int idx_biz = dSet.indexOfColumn("biz_code");
   	int idx_usememo = dSet.indexOfColumn("usememo");
  	   int idx_amt = dSet.indexOfColumn("amt");
    	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_use_date = dSet.indexOfColumn("use_date");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
	for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	 String sSql = " INSERT INTO  E_SAFTY_COST_TOTAL							" +
				   "	 (dept_code,														" + 
				   "	  yymm,																" + 
				   "	  unq_num,															" + 
				   "	  item_code,														" + 
				   "	  biz,																" + 
				   "	  usememo,															" + 
				   "	  amt,																" + 
				   "	  vat,																" + 
				   "	  use_date,															" + 
				   "	  remark )															" ; 
	  sSql = sSql + "  VALUES ( :1 ,:2 , e_sc_unq_seq.nextval ,:3 ,:4 ,:5 ,:6 ,:7 ,:8 ,:9)	" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm );
      gpstatement.bindColumn(3, idx_item_code);
      gpstatement.bindColumn(4, idx_biz);
      gpstatement.bindColumn(5, idx_usememo );
      gpstatement.bindColumn(6, idx_amt);
      gpstatement.bindColumn(7, idx_vat);
	   gpstatement.bindColumn(8, idx_use_date);
      gpstatement.bindColumn(9, idx_remark);
	  stmt.executeUpdate();
      stmt.close();		
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
		String sSql = " update E_SAFTY_COST_TOTAL set	" + 
				     "	  item_code=?,							" + 
				     "	  biz=?,									" + 
				     "	  usememo=?,							" + 
				     "	  amt=?,									" + 
				     "	  vat=?,									" + 		
					  "       use_date=?,						" + 
					  "       remark=?							" +
					  " where unq_num=?							" ;
		stmt = conn.prepareStatement(sSql); 
		gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_item_code);
      gpstatement.bindColumn(2, idx_biz);
      gpstatement.bindColumn(3, idx_usememo );
      gpstatement.bindColumn(4, idx_amt);
      gpstatement.bindColumn(5, idx_vat);
	   gpstatement.bindColumn(6, idx_use_date);
      gpstatement.bindColumn(7, idx_remark);
	 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(8, idx_unq_num);
		stmt.executeUpdate();
		stmt.close();	
 } else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "delete from E_SAFTY_COST_TOTAL where unq_num=? "; 
	 stmt = conn.prepareStatement(sSql); 
     gpstatement.gp_stmt = stmt; 
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼)  */
	 gpstatement.bindColumn(1, idx_unq_num);
     stmt.executeUpdate();
     stmt.close(); 
	}
     }


%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>