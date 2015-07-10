<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_mat_request_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_tmat_unq_num = dSet.indexOfColumn("tmat_unq_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
   if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_input_detail set " + 
                            "vatamt=?,  " + 
                            "vat_unq_num=?,vattag=?  " + 
                            " where dept_code=? " +  
                            " and yymmdd=?  " + 
                            " and seq=?  " + 
                            " and input_unq_num=?  " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_vatamt);
      gpstatement.bindColumn(2, idx_vat_unq_num);
      gpstatement.bindColumn(3, idx_vattag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_yymmdd);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
	   double ls_class = rows.getDouble(idx_vat_unq_num);
	   double ls_mat = rows.getDouble(idx_tmat_unq_num);
	   String ls_ditag = rows.getString(idx_ditag);


	   if (ls_class == 0 && ls_ditag.equals("2") ) {
		     //손료처리후 손료를 삭제한후 내역을 삭제할수 있음 따라서 손료내역은 손료 처리 화면에서 삭제함 이곳에서 삭제불필요
		     //sSql = "delete from m_tmat_proj_rent " + 
		     //                      " where dept_code=? " +  
		     //                       " and input_unq_num=?  " ;
		     // stmt = conn.prepareStatement(sSql); 
		     // gpstatement.gp_stmt = stmt;
		     // gpstatement.bindColumn(1, idx_dept_code);
		     // gpstatement.bindColumn(2, idx_input_unq_num);
		     // stmt.executeUpdate();
		     // stmt.close();
		      
		      
		     sSql = "delete from m_tmat_stock " + 
		                            " where dept_code=? " +  
		                            " and input_unq_num=?  " ;
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_dept_code);
		      gpstatement.bindColumn(2, idx_input_unq_num);
		      stmt.executeUpdate();
		      stmt.close();
		    if (ls_mat != 0 ) {
		     sSql = "delete from m_tmat_rent " + 
		                            " where tmat_unq_num=?  " ;
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_tmat_unq_num);
		      stmt.executeUpdate();
		      stmt.close();
		      
		      
		     sSql = "delete from m_tmat_master" + 
		                            " where tmat_unq_num=?  " ;
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_tmat_unq_num);
		      stmt.executeUpdate();
		      stmt.close();

		     sSql = "update m_input_detail set " + 
                            "tmat_unq_num=0  " + 
                            " where dept_code=? " +  
                            " and yymmdd=?  " + 
                            " and seq=?  " + 
                            " and input_unq_num=?  " ;
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		      gpstatement.bindColumn(1, idx_dept_code);
		      gpstatement.bindColumn(2, idx_yymmdd);
		      gpstatement.bindColumn(3, idx_seq);
		      gpstatement.bindColumn(4, idx_input_unq_num);
		      stmt.executeUpdate();
		      stmt.close();
		    }
	    }
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>