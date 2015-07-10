<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_mat_request_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_acnt_code = dSet.indexOfColumn("acnt_code");
   	int idx_vatcode = dSet.indexOfColumn("vatcode");
   	int idx_yyyymmdd = dSet.indexOfColumn("yyyymmdd");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamount = dSet.indexOfColumn("vatamount");
   	int idx_codetag = dSet.indexOfColumn("codetag");
   	int idx_cont = dSet.indexOfColumn("cont");
   	int idx_acnt_status = dSet.indexOfColumn("acnt_status");
   	int idx_acnt_workdate = dSet.indexOfColumn("acnt_workdate");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_paycondition = dSet.indexOfColumn("paycondition");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_cash_amt = dSet.indexOfColumn("cash_amt");
   	int idx_bill_amt = dSet.indexOfColumn("bill_amt");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_work_process = dSet.indexOfColumn("work_process");
   	int idx_inv_id = dSet.indexOfColumn("inv_id");
   	int idx_bill_day = dSet.indexOfColumn("bill_day");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_process_tag = dSet.indexOfColumn("process_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_VAT ( dept_code," + 
                    "sbcr_code," + 
                    "vat_unq_num," + 
                    "work_dt," + 
                    "acnt_code," + 
                    "vatcode," + 
                    "yyyymmdd," + 
                    "amt," + 
                    "vatamount," + 
                    "codetag," + 
                    "cont," + 
                    "acnt_status," + 
                    "acnt_workdate," + 
                    "wbs_code," + 
                    "paycondition," + 
                    "spec_unq_num," + 
                    "cash_amt," + 
                    "bill_amt," + 
                    "approym," + 
                    "approseq," + 
                    "chg_cnt," + 
                    "invoice_num," + 
                    "work_process,inv_id,bill_day,ditag,process_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23,:24 ,:25,:26,:27) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_vat_unq_num);
      gpstatement.bindColumn(4, idx_work_dt);
      gpstatement.bindColumn(5, idx_acnt_code);
      gpstatement.bindColumn(6, idx_vatcode);
      gpstatement.bindColumn(7, idx_yyyymmdd);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vatamount);
      gpstatement.bindColumn(10, idx_codetag);
      gpstatement.bindColumn(11, idx_cont);
      gpstatement.bindColumn(12, idx_acnt_status);
      gpstatement.bindColumn(13, idx_acnt_workdate);
      gpstatement.bindColumn(14, idx_wbs_code);
      gpstatement.bindColumn(15, idx_paycondition);
      gpstatement.bindColumn(16, idx_spec_unq_num);
      gpstatement.bindColumn(17, idx_cash_amt);
      gpstatement.bindColumn(18, idx_bill_amt);
      gpstatement.bindColumn(19, idx_approym);
      gpstatement.bindColumn(20, idx_approseq);
      gpstatement.bindColumn(21, idx_chg_cnt);
      gpstatement.bindColumn(22, idx_invoice_num);
      gpstatement.bindColumn(23, idx_work_process);
      gpstatement.bindColumn(24, idx_inv_id);
      gpstatement.bindColumn(25, idx_bill_day);
      gpstatement.bindColumn(26, idx_ditag);
      gpstatement.bindColumn(27, idx_process_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_vat set " + 
                            "dept_code=?,  " + 
                            "sbcr_code=?,  " + 
                            "vat_unq_num=?,  " + 
                            "work_dt=?,  " + 
                            "acnt_code=?,  " + 
                            "vatcode=?,  " + 
                            "yyyymmdd=?,  " + 
                            "amt=?,  " + 
                            "vatamount=?,  " + 
                            "codetag=?,  " + 
                            "cont=?,  " + 
                            "acnt_status=?,  " + 
                            "acnt_workdate=?,  " + 
                            "wbs_code=?,  " + 
                            "paycondition=?,  " + 
                            "spec_unq_num=?,  " + 
                            "cash_amt=?,  " + 
                            "bill_amt=?,  " + 
                            "approym=?,  " + 
                            "approseq=?,  " + 
                            "chg_cnt=?,  " + 
                            "invoice_num=?,  " + 
                            "work_process=?,inv_id=?,bill_day=? ,ditag=?,process_tag=? where dept_code=? " +
                            "                  and sbcr_code=? " +
                            "                  and vat_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_vat_unq_num);
      gpstatement.bindColumn(4, idx_work_dt);
      gpstatement.bindColumn(5, idx_acnt_code);
      gpstatement.bindColumn(6, idx_vatcode);
      gpstatement.bindColumn(7, idx_yyyymmdd);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_vatamount);
      gpstatement.bindColumn(10, idx_codetag);
      gpstatement.bindColumn(11, idx_cont);
      gpstatement.bindColumn(12, idx_acnt_status);
      gpstatement.bindColumn(13, idx_acnt_workdate);
      gpstatement.bindColumn(14, idx_wbs_code);
      gpstatement.bindColumn(15, idx_paycondition);
      gpstatement.bindColumn(16, idx_spec_unq_num);
      gpstatement.bindColumn(17, idx_cash_amt);
      gpstatement.bindColumn(18, idx_bill_amt);
      gpstatement.bindColumn(19, idx_approym);
      gpstatement.bindColumn(20, idx_approseq);
      gpstatement.bindColumn(21, idx_chg_cnt);
      gpstatement.bindColumn(22, idx_invoice_num);
      gpstatement.bindColumn(23, idx_work_process);
      gpstatement.bindColumn(24, idx_inv_id);
      gpstatement.bindColumn(25, idx_bill_day);
      gpstatement.bindColumn(26, idx_ditag);
      gpstatement.bindColumn(27, idx_process_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(28, idx_dept_code);
      gpstatement.bindColumn(29, idx_sbcr_code);
      gpstatement.bindColumn(30, idx_vat_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_vat where dept_code=? " +
                            "                  and sbcr_code=? " +
                            "                  and vat_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_vat_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>