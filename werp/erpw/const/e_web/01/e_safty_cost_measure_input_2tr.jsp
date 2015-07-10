<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_safty_cost_measure_input_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
	   int idx_remark = dSet.indexOfColumn("remark");
	   int idx_nullchk = dSet.indexOfColumn("nullchk");

    int  rowCnt = dSet.getDataRowCnt();
	for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	 String sSql = " INSERT INTO  E_SAFTY_COST_MEASURE_DETAIL			" +
				   "	 (yymm,															" + 
				   "	  dept_code,													" + 
				   "	  remark )														" ; 
	  sSql = sSql + "  VALUES ( :1 ,:2, :3  )	" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm );
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_remark);
	   stmt.executeUpdate();
      stmt.close();		
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
    String ls_nullcheck = rows.getString(idx_nullchk);		
		 if ( ls_nullcheck.equals("1") )
	   {
		String sSql = " update E_SAFTY_COST_MEASURE_DETAIL set	" + 
				     "	    yymm=?,											" + 
				     "	    dept_code=?,									" + 
					  "       remark=?										" +
					  "    where yymm=? and dept_code=?					" ;
		stmt = conn.prepareStatement(sSql); 
		gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm );
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_remark);
	 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_yymm );
      gpstatement.bindColumn(5, idx_dept_code );
		stmt.executeUpdate();
		stmt.close();	
	   } else if ( ls_nullcheck.equals("0") ) {
	 String sSql = " INSERT INTO  E_SAFTY_COST_MEASURE_DETAIL			" +
				   "	 (yymm,															" + 
				   "	  dept_code,													" + 
				   "	  remark )														" ; 
	  sSql = sSql + "  VALUES ( :1 ,:2, :3  )	" ;
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm );
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_remark);
	   stmt.executeUpdate();
      stmt.close();	
		}
 } else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "delete from E_SAFTY_COST_MEASURE_DETAIL where yymm=? and dept_code=?		" ;
	 stmt = conn.prepareStatement(sSql); 
     gpstatement.gp_stmt = stmt; 
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼)  */
     gpstatement.bindColumn(1, idx_yymm );
     gpstatement.bindColumn(2, idx_dept_code );
	  stmt.executeUpdate();
     stmt.close(); 
	}
     }


%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>