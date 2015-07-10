<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("bm_account_status_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_inv_id = dSet.indexOfColumn("inv_id");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cst_doc_no = dSet.indexOfColumn("cst_doc_no");
   	int idx_corp_reg_no = dSet.indexOfColumn("corp_reg_no");
   	int idx_pub_date = dSet.indexOfColumn("pub_date");
   	int idx_sup_tamt = dSet.indexOfColumn("sup_tamt");
   	int idx_sup_ttax = dSet.indexOfColumn("sup_ttax");
   	int idx_iss_gb = dSet.indexOfColumn("iss_gb");
   	int idx_proc_gb = dSet.indexOfColumn("proc_gb");
   	int idx_tax_gb = dSet.indexOfColumn("tax_gb");
   	int idx_off_gb = dSet.indexOfColumn("off_gb");
   	int idx_prepay_gb = dSet.indexOfColumn("prepay_gb");
   	int idx_biz_id = dSet.indexOfColumn("biz_id");
   	int idx_cst_info_id = dSet.indexOfColumn("cst_info_id");
   	int idx_cord_id = dSet.indexOfColumn("cord_id");
   	int idx_iss_by = dSet.indexOfColumn("iss_by");
   	int idx_iss_date = dSet.indexOfColumn("iss_date");
   	int idx_snd_by = dSet.indexOfColumn("snd_by");
   	int idx_snd_date = dSet.indexOfColumn("snd_date");
   	int idx_rjt_by = dSet.indexOfColumn("rjt_by");
   	int idx_rjt_date = dSet.indexOfColumn("rjt_date");
   	int idx_rjt_desc = dSet.indexOfColumn("rjt_desc");
   	int idx_cert_dn = dSet.indexOfColumn("cert_dn");
   	int idx_sign = dSet.indexOfColumn("sign");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_ACCOUNT_PROCESS ( inv_id," + 
                    "dept_code," + 
                    "cst_doc_no," + 
                    "corp_reg_no," + 
                    "pub_date," + 
                    "sup_tamt," + 
                    "sup_ttax," + 
                    "iss_gb," + 
                    "proc_gb," + 
                    "tax_gb," + 
                    "off_gb," + 
                    "prepay_gb," + 
                    "biz_id," + 
                    "cst_info_id," + 
                    "cord_id," + 
                    "iss_by," + 
                    "iss_date," + 
                    "snd_by," + 
                    "snd_date," + 
                    "rjt_by," + 
                    "rjt_date," + 
                    "rjt_desc," + 
                    "cert_dn," + 
                    "sign )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_inv_id);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_cst_doc_no);
      gpstatement.bindColumn(4, idx_corp_reg_no);
      gpstatement.bindColumn(5, idx_pub_date);
      gpstatement.bindColumn(6, idx_sup_tamt);
      gpstatement.bindColumn(7, idx_sup_ttax);
      gpstatement.bindColumn(8, idx_iss_gb);
      gpstatement.bindColumn(9, idx_proc_gb);
      gpstatement.bindColumn(10, idx_tax_gb);
      gpstatement.bindColumn(11, idx_off_gb);
      gpstatement.bindColumn(12, idx_prepay_gb);
      gpstatement.bindColumn(13, idx_biz_id);
      gpstatement.bindColumn(14, idx_cst_info_id);
      gpstatement.bindColumn(15, idx_cord_id);
      gpstatement.bindColumn(16, idx_iss_by);
      gpstatement.bindColumn(17, idx_iss_date);
      gpstatement.bindColumn(18, idx_snd_by);
      gpstatement.bindColumn(19, idx_snd_date);
      gpstatement.bindColumn(20, idx_rjt_by);
      gpstatement.bindColumn(21, idx_rjt_date);
      gpstatement.bindColumn(22, idx_rjt_desc);
      gpstatement.bindColumn(23, idx_cert_dn);
      gpstatement.bindColumn(24, idx_sign);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_account_process set " + 
                            "inv_id=?,  " + 
                            "dept_code=?,  " + 
                            "cst_doc_no=?,  " + 
                            "corp_reg_no=?,  " + 
                            "pub_date=?,  " + 
                            "sup_tamt=?,  " + 
                            "sup_ttax=?,  " + 
                            "iss_gb=?,  " + 
                            "proc_gb=?,  " + 
                            "tax_gb=?,  " + 
                            "off_gb=?,  " + 
                            "prepay_gb=?,  " + 
                            "biz_id=?,  " + 
                            "cst_info_id=?,  " + 
                            "cord_id=?,  " + 
                            "iss_by=?,  " + 
                            "iss_date=?,  " + 
                            "snd_by=?,  " + 
                            "snd_date=?,  " + 
                            "rjt_by=?,  " + 
                            "rjt_date=?,  " + 
                            "rjt_desc=?,  " + 
                            "cert_dn=?,  " + 
                            "sign=?  where inv_id=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_inv_id);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_cst_doc_no);
      gpstatement.bindColumn(4, idx_corp_reg_no);
      gpstatement.bindColumn(5, idx_pub_date);
      gpstatement.bindColumn(6, idx_sup_tamt);
      gpstatement.bindColumn(7, idx_sup_ttax);
      gpstatement.bindColumn(8, idx_iss_gb);
      gpstatement.bindColumn(9, idx_proc_gb);
      gpstatement.bindColumn(10, idx_tax_gb);
      gpstatement.bindColumn(11, idx_off_gb);
      gpstatement.bindColumn(12, idx_prepay_gb);
      gpstatement.bindColumn(13, idx_biz_id);
      gpstatement.bindColumn(14, idx_cst_info_id);
      gpstatement.bindColumn(15, idx_cord_id);
      gpstatement.bindColumn(16, idx_iss_by);
      gpstatement.bindColumn(17, idx_iss_date);
      gpstatement.bindColumn(18, idx_snd_by);
      gpstatement.bindColumn(19, idx_snd_date);
      gpstatement.bindColumn(20, idx_rjt_by);
      gpstatement.bindColumn(21, idx_rjt_date);
      gpstatement.bindColumn(22, idx_rjt_desc);
      gpstatement.bindColumn(23, idx_cert_dn);
      gpstatement.bindColumn(24, idx_sign);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(25, idx_inv_id);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_account_process where inv_id=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_inv_id);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>