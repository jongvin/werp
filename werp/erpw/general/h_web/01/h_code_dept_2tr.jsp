<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_dept_2tr"); gpstatement.gp_dataset = dSet;
	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_pyong = dSet.indexOfColumn("pyong");
	int idx_opt_name = dSet.indexOfColumn("opt_name");
	int idx_opt_base = dSet.indexOfColumn("opt_base");
	int idx_opt_finish = dSet.indexOfColumn("opt_finish");
	int idx_opt_ref = dSet.indexOfColumn("opt_ref");
	int idx_old_pyong = dSet.indexOfColumn("old_pyong");
	int idx_old_opt_name = dSet.indexOfColumn("old_opt_name");
	int idx_old_opt_base = dSet.indexOfColumn("old_opt_base");
	int idx_old_opt_finish = dSet.indexOfColumn("old_opt_finish");
	int idx_old_opt_ref = dSet.indexOfColumn("old_opt_ref");
	int idx_amt_norm = dSet.indexOfColumn("amt_norm");
	int idx_amt_norm_vat = dSet.indexOfColumn("amt_norm_vat");
	int idx_amt_prem = dSet.indexOfColumn("amt_prem");
	int idx_amt_prem_vat = dSet.indexOfColumn("amt_prem_vat");
	int idx_note = dSet.indexOfColumn("note");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BASE_ONTIME_ITEM ( dept_code," + 
	                " pyong," + 
                    " opt_name," + 
                    " opt_base," + 
                    " opt_finish," + 
                    " opt_ref," + 
			        " amt_norm," +
			        " amt_norm_vat," +
			" amt_prem," +
			" amt_prem_vat," +
                    " note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9,:10, :11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
	  gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_pyong);
      gpstatement.bindColumn(3, idx_opt_name);
      gpstatement.bindColumn(4, idx_opt_base);
      gpstatement.bindColumn(5, idx_opt_finish);
      gpstatement.bindColumn(6, idx_opt_ref);
      gpstatement.bindColumn(7, idx_amt_norm);
	  gpstatement.bindColumn(8, idx_amt_norm_vat);
	  gpstatement.bindColumn(9, idx_amt_prem);
	  gpstatement.bindColumn(10, idx_amt_prem_vat);
	  gpstatement.bindColumn(11, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_ontime_item set " + 
                            "dept_code=?,  " + 
                            " pyong=?," + 
							" opt_name=?," + 
							" opt_base=?," + 
							" opt_finish=?," + 
							" opt_ref=?," + 
							" amt_norm=?," +
	                        " amt_norm_vat=?," +
					" amt_prem=?," +
					" amt_prem_vat=?," +
							" note=? where dept_code=? " +
                            " and pyong=? and  opt_name=? and opt_base=? and opt_finish=? and  opt_ref=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
	   gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_pyong);
      gpstatement.bindColumn(3, idx_opt_name);
      gpstatement.bindColumn(4, idx_opt_base);
      gpstatement.bindColumn(5, idx_opt_finish);
      gpstatement.bindColumn(6, idx_opt_ref);
      gpstatement.bindColumn(7, idx_amt_norm);
	  gpstatement.bindColumn(8, idx_amt_norm_vat);
	  gpstatement.bindColumn(9, idx_amt_prem);
	  gpstatement.bindColumn(10, idx_amt_prem_vat);
	  gpstatement.bindColumn(11, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_old_pyong);
      gpstatement.bindColumn(14, idx_old_opt_name);
      gpstatement.bindColumn(15, idx_old_opt_base);
      gpstatement.bindColumn(16, idx_old_opt_finish);
      gpstatement.bindColumn(17, idx_old_opt_ref);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_ontime_item where dept_code=? " +
               " and pyong=? and   opt_name=? and opt_base=? and opt_finish=? and  opt_ref=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_old_pyong);
      gpstatement.bindColumn(3, idx_old_opt_name);
      gpstatement.bindColumn(4, idx_old_opt_base);
      gpstatement.bindColumn(5, idx_old_opt_finish);
      gpstatement.bindColumn(6, idx_old_opt_ref);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>