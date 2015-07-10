<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_input_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_detailseq = dSet.indexOfColumn("detailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_org_qty = dSet.indexOfColumn("org_qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_deliverytag = dSet.indexOfColumn("deliverytag");
   	int idx_inouttypecode = dSet.indexOfColumn("inouttypecode");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_unq_num = dSet.indexOfColumn("request_unq_num");
   	int idx_est_unq_num = dSet.indexOfColumn("est_unq_num");
   	int idx_approval_unq_num = dSet.indexOfColumn("approval_unq_num");
   	int idx_bigo = dSet.indexOfColumn("bigo");
   	int idx_noout_qty = dSet.indexOfColumn("noout_qty");
   	int idx_comp_qty = dSet.indexOfColumn("comp_qty");
   	int idx_rcomp_qty = dSet.indexOfColumn("rcomp_qty");
   	int idx_tmat_unq_num = dSet.indexOfColumn("tmat_unq_num");
   	int idx_price_class = dSet.indexOfColumn("price_class");
   	int idx_item_code = dSet.indexOfColumn("item_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_INPUT_DETAIL ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "input_unq_num," + 
                    "detailseq," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "ditag," + 
                    "qty," + 
                    "unitprice," + 
                    "amt," + 
                    "vatamt," + 
                    "deliverytag," + 
                    "inouttypecode," + 
                    "sbcr_code," + 
                    "vattag," + 
                    "vat_unq_num," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "request_unq_num," + 
                    "est_unq_num," + 
                    "approval_unq_num," + 
                    "bigo,noout_qty,tmat_unq_num ,item_code)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25,:26,:27,:28 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_detailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_ditag);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_unitprice);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_vatamt);
      gpstatement.bindColumn(15, idx_deliverytag);
      gpstatement.bindColumn(16, idx_inouttypecode);
      gpstatement.bindColumn(17, idx_sbcr_code);
      gpstatement.bindColumn(18, idx_vattag);
      gpstatement.bindColumn(19, idx_vat_unq_num);
      gpstatement.bindColumn(20, idx_spec_no_seq);
      gpstatement.bindColumn(21, idx_spec_unq_num);
      gpstatement.bindColumn(22, idx_request_unq_num);
      gpstatement.bindColumn(23, idx_est_unq_num);
      gpstatement.bindColumn(24, idx_approval_unq_num);
      gpstatement.bindColumn(25, idx_bigo);
      gpstatement.bindColumn(26, idx_noout_qty);
      gpstatement.bindColumn(27, idx_tmat_unq_num);
      gpstatement.bindColumn(28, idx_item_code);
      stmt.executeUpdate();
      stmt.close();
 
}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_input_detail set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "input_unq_num=?,  " + 
                            "detailseq=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "ditag=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "vatamt=?,  " + 
                            "deliverytag=?,  " + 
                            "inouttypecode=?,  " + 
                            "sbcr_code=?,  " + 
                            "vattag=?,  " + 
                            "vat_unq_num=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "request_unq_num=?,  " + 
                            "est_unq_num=?,  " + 
                            "approval_unq_num=?,  " + 
                            "bigo=?,noout_qty=?,tmat_unq_num=? ,item_code=? where dept_code=? " +  
                            " and yymmdd=?  " + 
                            " and seq=?  " + 
                            " and input_unq_num=?  " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      gpstatement.bindColumn(5, idx_detailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_ditag);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_unitprice);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_vatamt);
      gpstatement.bindColumn(15, idx_deliverytag);
      gpstatement.bindColumn(16, idx_inouttypecode);
      gpstatement.bindColumn(17, idx_sbcr_code);
      gpstatement.bindColumn(18, idx_vattag);
      gpstatement.bindColumn(19, idx_vat_unq_num);
      gpstatement.bindColumn(20, idx_spec_no_seq);
      gpstatement.bindColumn(21, idx_spec_unq_num);
      gpstatement.bindColumn(22, idx_request_unq_num);
      gpstatement.bindColumn(23, idx_est_unq_num);
      gpstatement.bindColumn(24, idx_approval_unq_num);
      gpstatement.bindColumn(25, idx_bigo);
      gpstatement.bindColumn(26, idx_noout_qty);
      gpstatement.bindColumn(27, idx_tmat_unq_num);
      gpstatement.bindColumn(28, idx_item_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(29, idx_dept_code);
      gpstatement.bindColumn(30, idx_yymmdd);
      gpstatement.bindColumn(31, idx_seq);
      gpstatement.bindColumn(32, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
	   String ls_class = rows.getString(idx_price_class);
	   if (ls_class.equals("0")) {
	     sSql = "update m_approval_detail set " + 
	                            "noinput_qty=noinput_qty + ? - ? " + 
	                            " where dept_code=? " +  
	                            " and approval_unq_num=?  " ;
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_org_qty);
	      gpstatement.bindColumn(2, idx_qty);
	      gpstatement.bindColumn(3, idx_dept_code);
	      gpstatement.bindColumn(4, idx_approval_unq_num);
	      stmt.executeUpdate();
	      stmt.close();
	    }
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_input_price  " + 
                            " where dept_code=? " +  
                            " and yymmdd=? " +
                            " and seq=? " +
                            " and input_unq_num=?  " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
      sSql = "delete from m_input_detail where dept_code=? " +
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
	   String ls_class = rows.getString(idx_price_class);
	   if (ls_class.equals("0")) {
	      sSql = "update m_approval_detail set " + 
	                            "noinput_qty=noinput_qty + ?  " + 
	                            " where dept_code=? " +  
	                            " and approval_unq_num=?  " ;
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_qty);
	      gpstatement.bindColumn(2, idx_dept_code);
	      gpstatement.bindColumn(3, idx_approval_unq_num);
	      stmt.executeUpdate();
	      stmt.close();
	   }
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>