<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%>
<%
    GauceDataSet dSet = req.getGauceDataSet("E_sa_amt_input_2tr"); 
	gpstatement.gp_dataset = dSet;
   	int idx_item_code = dSet.indexOfColumn("item_code");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_nullcheck = dSet.indexOfColumn("nullcheck");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	 String sSql = " INSERT INTO  e_safty_budget_detail					" +
				   "	 (dept_code,													" + 
				   "	  item_code,													" + 
				   "	  item_name,													" + 
				   "	  amt,															" + 
				   "	  remark )														" ; 
      sSql = sSql + "  VALUES ( :1 ,:2 ,										" +
				  	"  ( select child_name from e_safety_code_child			" +
				    "   where class_tag = '033' and safety_code = :2 ),  " +
				  	"  :3 ,:4  )										" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_item_code );
      gpstatement.bindColumn(3, idx_amt);
      gpstatement.bindColumn(4, idx_remark);

	  stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){

 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
    String ls_nullcheck = rows.getString(idx_nullcheck);
    String ls_dept_code = rows.getString(idx_dept_code);
	if ( ls_nullcheck.equals("1") )
	   {
		String sSql = " update e_safty_budget_detail set										" + 
						"       item_code=?,																" + 
						"       item_name=																" +
						"		( select child_name from z_code_etc_child							" +
						"		where class_tag = '033' and etc_code =?		),					" + 
						"		amt=? ,																		" + 
						"		remark=?																		" + 
						" where dept_code ='"+ls_dept_code+"'  and								" +
						"       item_code =?																" ;
		stmt = conn.prepareStatement(sSql); 
		gpstatement.gp_stmt = stmt;
		gpstatement.bindColumn(1, idx_item_code );
		gpstatement.bindColumn(2, idx_item_code );
		gpstatement.bindColumn(3, idx_amt);
		gpstatement.bindColumn(4, idx_remark);
	 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(5, idx_item_code);
		stmt.executeUpdate();
		stmt.close();				 
	   } else if ( ls_nullcheck.equals("0") ) {
	    String ls_item_code = rows.getString(idx_item_code);
		 String ls_amt = rows.getString(idx_amt);
	    String ls_remark = rows.getString(idx_remark);
	
		String sSql = " INSERT INTO  e_safty_budget_detail									" +
					  "				 (dept_code,													" + 
					  "				  item_code,													" + 
					  "				  item_name,													" + 
					  "				  amt,															" + 
					  "				  remark )														" ; 
		sSql = sSql + "  VALUES (																	" +
					  "	 '" + ls_dept_code + "',												" +
					  "	 '" + ls_item_code + "',												" +
					  "  ( select child_name from z_code_etc_child							" +
					  "   where class_tag = '033' and etc_code = '" + ls_dept_code + "') ,  " +
		              "	 '" + ls_amt + "' ,													" +
					  "  '" + ls_remark + "' )														" ;	
		stmt = conn.prepareStatement(sSql);
		gpstatement.gp_stmt = stmt;
		stmt.executeUpdate();
		stmt.close();
	   }
  } else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "delete from e_safty_budget_detail where dept_code =? and item_code =? "; 
     stmt = conn.prepareStatement(sSql); 
     gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼)  */
     gpstatement.bindColumn(1, idx_dept_code);
     gpstatement.bindColumn(2, idx_item_code );
     stmt.executeUpdate();
     stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>