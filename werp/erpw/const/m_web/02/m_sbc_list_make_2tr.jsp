<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_sbc_list_make_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_guarantee_class = dSet.indexOfColumn("guarantee_class");
   	int idx_accept_dt = dSet.indexOfColumn("accept_dt");
   	int idx_guarantee_number = dSet.indexOfColumn("guarantee_number");
   	int idx_guarantee_amt = dSet.indexOfColumn("guarantee_amt");
   	int idx_guarantee_vat = dSet.indexOfColumn("guarantee_vat");
   	int idx_guarantee_issueday = dSet.indexOfColumn("guarantee_issueday");
   	int idx_guarantee_start_dt = dSet.indexOfColumn("guarantee_start_dt");
   	int idx_guarantee_end_dt = dSet.indexOfColumn("guarantee_end_dt");
   	int idx_guarantee_kind = dSet.indexOfColumn("guarantee_kind");
   	int idx_guarantee_sbcr = dSet.indexOfColumn("guarantee_sbcr");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_send_yn = dSet.indexOfColumn("send_yn");
   	int idx_nosend_reson = dSet.indexOfColumn("nosend_reson");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_GUARANTEE ( dept_code," + 
                    "approym," + 
                    "approseq," + 
                    "chg_cnt," + 
                    "sbcr_code," + 
                    "seq," + 
                    "guarantee_class," + 
                    "accept_dt," + 
                    "guarantee_number," + 
                    "guarantee_amt," + 
                    "guarantee_vat," + 
                    "guarantee_issueday," + 
                    "guarantee_start_dt," + 
                    "guarantee_end_dt," + 
                    "guarantee_kind," + 
                    "guarantee_sbcr," + 
                    "note," + 
                    "invoice_num," + 
                    "send_yn," + 
                    "nosend_reson )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_guarantee_class);
      gpstatement.bindColumn(8, idx_accept_dt);
      gpstatement.bindColumn(9, idx_guarantee_number);
      gpstatement.bindColumn(10, idx_guarantee_amt);
      gpstatement.bindColumn(11, idx_guarantee_vat);
      gpstatement.bindColumn(12, idx_guarantee_issueday);
      gpstatement.bindColumn(13, idx_guarantee_start_dt);
      gpstatement.bindColumn(14, idx_guarantee_end_dt);
      gpstatement.bindColumn(15, idx_guarantee_kind);
      gpstatement.bindColumn(16, idx_guarantee_sbcr);
      gpstatement.bindColumn(17, idx_note);
      gpstatement.bindColumn(18, idx_invoice_num);
      gpstatement.bindColumn(19, idx_send_yn);
      gpstatement.bindColumn(20, idx_nosend_reson);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_guarantee set " + 
                            "dept_code=?,  " + 
                            "approym=?,  " + 
                            "approseq=?,  " + 
                            "chg_cnt=?,  " + 
                            "sbcr_code=?,  " + 
                            "seq=?,  " + 
                            "guarantee_class=?,  " + 
                            "accept_dt=?,  " + 
                            "guarantee_number=?,  " + 
                            "guarantee_amt=?,  " + 
                            "guarantee_vat=?,  " + 
                            "guarantee_issueday=?,  " + 
                            "guarantee_start_dt=?,  " + 
                            "guarantee_end_dt=?,  " + 
                            "guarantee_kind=?,  " + 
                            "guarantee_sbcr=?,  " + 
                            "note=?,  " + 
                            "invoice_num=?,  " + 
                            "send_yn=?,  " + 
                            "nosend_reson=?  where dept_code=? " +
                            "                  and approym=? " +
                            "                  and approseq=? " +
                            "                  and chg_cnt=? " +
                            "                  and sbcr_code=? " +
                            "                  and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_guarantee_class);
      gpstatement.bindColumn(8, idx_accept_dt);
      gpstatement.bindColumn(9, idx_guarantee_number);
      gpstatement.bindColumn(10, idx_guarantee_amt);
      gpstatement.bindColumn(11, idx_guarantee_vat);
      gpstatement.bindColumn(12, idx_guarantee_issueday);
      gpstatement.bindColumn(13, idx_guarantee_start_dt);
      gpstatement.bindColumn(14, idx_guarantee_end_dt);
      gpstatement.bindColumn(15, idx_guarantee_kind);
      gpstatement.bindColumn(16, idx_guarantee_sbcr);
      gpstatement.bindColumn(17, idx_note);
      gpstatement.bindColumn(18, idx_invoice_num);
      gpstatement.bindColumn(19, idx_send_yn);
      gpstatement.bindColumn(20, idx_nosend_reson);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_dept_code);
      gpstatement.bindColumn(22, idx_approym);
      gpstatement.bindColumn(23, idx_approseq);
      gpstatement.bindColumn(24, idx_chg_cnt);
      gpstatement.bindColumn(25, idx_sbcr_code);
      gpstatement.bindColumn(26, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_guarantee where dept_code=? " +
                            "                  and approym=? " +
                            "                  and approseq=? " +
                            "                  and chg_cnt=? " +
                            "                  and sbcr_code=? " +
                            "                  and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>