<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_v_account_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
	   int idx_sell_code = dSet.indexOfColumn("sell_code");
		int idx_deposit_no = dSet.indexOfColumn("deposit_no");
		int idx_v_account_no = dSet.indexOfColumn("v_account_no");
		int idx_v_account_no_key = dSet.indexOfColumn("v_account_no_key");
		int idx_reg_date = dSet.indexOfColumn("reg_date");
		int idx_use_tag = dSet.indexOfColumn("use_tag");
		int idx_dongho = dSet.indexOfColumn("dongho");
		int idx_seq = dSet.indexOfColumn("seq");
		int idx_apply_date = dSet.indexOfColumn("apply_date");
		int idx_col1 = dSet.indexOfColumn("col1");
		int idx_col2 = dSet.indexOfColumn("col2");
		int idx_col3 = dSet.indexOfColumn("col3");
		int idx_col4 = dSet.indexOfColumn("col4");
		int idx_col5 = dSet.indexOfColumn("col5");
		
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_CODE_V_ACCOUNT ( "+
		              " DEPT_CODE, "+
						  " SELL_CODE, "+
						  " DEPOSIT_NO, "+
						  " V_ACCOUNT_NO, "+
                    " REG_DATE, "+
						  " USE_TAG, "+
						  " DONGHO, "+
						  " SEQ, "+
						  " APPLY_DATE, "+
						  " COL1, "+
						  " COL2, "+
							" COL3, "+
							" COL4, "+
							" COL5 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_deposit_no);
      gpstatement.bindColumn(4, idx_v_account_no);
      gpstatement.bindColumn(5, idx_reg_date);
      gpstatement.bindColumn(6, idx_use_tag);
      gpstatement.bindColumn(7, idx_dongho);
      gpstatement.bindColumn(8, idx_seq);
      gpstatement.bindColumn(9, idx_apply_date);
      gpstatement.bindColumn(10, idx_col1);
      gpstatement.bindColumn(11, idx_col2);
      gpstatement.bindColumn(12, idx_col3);
		gpstatement.bindColumn(13, idx_col4);
		gpstatement.bindColumn(14, idx_col5);
		 stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_v_account  set " + 
                            " v_account_no=?,  " + 
                            " reg_date=?,  " + 
                            " use_tag=?,  " + 
                            " dongho=?,  " + 
                            " seq=?,  " + 
                            " apply_date=?,  " + 
                            " col1=?,  " + 
	                         " col2=?,  " + 
	                         " col3=?,  " + 
	                         " col4=?,  " + 
	                         " col5=? where dept_code=? "+
	                         " and sell_code=? "+
	                         " and deposit_no=?"+
	                         " and v_account_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_v_account_no);
      gpstatement.bindColumn(2, idx_reg_date);
      gpstatement.bindColumn(3, idx_use_tag);
      gpstatement.bindColumn(4, idx_dongho);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_apply_date);
      gpstatement.bindColumn(7, idx_col1);
      gpstatement.bindColumn(8, idx_col2);
      gpstatement.bindColumn(9, idx_col3);
		gpstatement.bindColumn(10, idx_col4);
		gpstatement.bindColumn(11, idx_col5);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_sell_code);
      gpstatement.bindColumn(14, idx_deposit_no);
      gpstatement.bindColumn(15, idx_v_account_no_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_v_account where dept_code=?  and sell_code=? and deposit_no=? and v_account_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_deposit_no);
      gpstatement.bindColumn(4, idx_v_account_no_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>