<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_cert_master_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_cert_id = dSet.indexOfColumn("cert_id");
   	int idx_smt_date = dSet.indexOfColumn("smt_date");
   	int idx_app_date = dSet.indexOfColumn("app_date");
   	int idx_exp_date = dSet.indexOfColumn("exp_date");
   	int idx_cert_auth = dSet.indexOfColumn("cert_auth");
   	int idx_cert_authcode = dSet.indexOfColumn("cert_authcode");
   	int idx_cert_dn = dSet.indexOfColumn("cert_dn");
   	int idx_cert_info = dSet.indexOfColumn("cert_info");
   	int idx_cert_hash = dSet.indexOfColumn("cert_hash");
   	int idx_cert_serial = dSet.indexOfColumn("cert_serial");
   	int idx_cert_old = dSet.indexOfColumn("cert_old");
   	int idx_cnf_date = dSet.indexOfColumn("cnf_date");
   	int idx_cnf_gb = dSet.indexOfColumn("cnf_gb");
   	int idx_use_gb = dSet.indexOfColumn("use_gb");
   	int idx_cert_media = dSet.indexOfColumn("cert_media");
   	int idx_corp_id = dSet.indexOfColumn("corp_id");
   	int idx_cre_by = dSet.indexOfColumn("cre_by");
   	int idx_cre_date = dSet.indexOfColumn("cre_date");
   	int idx_upd_by = dSet.indexOfColumn("upd_by");
   	int idx_upd_date = dSet.indexOfColumn("upd_date");
   	int idx_org_value = dSet.indexOfColumn("org_value");
   	int idx_sign_value = dSet.indexOfColumn("sign_value");
   	int idx_verify_value = dSet.indexOfColumn("verify_value");
   	int idx_signer_value = dSet.indexOfColumn("signer_value");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CERT_MASTER ( cert_id," + 
                    "smt_date," + 
                    "app_date," + 
                    "exp_date," + 
                    "cert_auth," + 
                    "cert_authcode," + 
                    "cert_dn," + 
                    "cert_info," + 
                    "cert_hash," + 
                    "cert_serial," + 
                    "cert_old," + 
                    "cnf_date," + 
                    "cnf_gb," + 
                    "use_gb," + 
                    "cert_media," + 
                    "corp_id," + 
                    "cre_by," + 
                    "cre_date," + 
                    "upd_by," + 
                    "upd_date," + 
                    "org_value," + 
                    "sign_value," + 
                    "verify_value," + 
                    "signer_value )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cert_id);
      gpstatement.bindColumn(2, idx_smt_date);
      gpstatement.bindColumn(3, idx_app_date);
      gpstatement.bindColumn(4, idx_exp_date);
      gpstatement.bindColumn(5, idx_cert_auth);
      gpstatement.bindColumn(6, idx_cert_authcode);
      gpstatement.bindColumn(7, idx_cert_dn);
      gpstatement.bindColumn(8, idx_cert_info);
      gpstatement.bindColumn(9, idx_cert_hash);
      gpstatement.bindColumn(10, idx_cert_serial);
      gpstatement.bindColumn(11, idx_cert_old);
      gpstatement.bindColumn(12, idx_cnf_date);
      gpstatement.bindColumn(13, idx_cnf_gb);
      gpstatement.bindColumn(14, idx_use_gb);
      gpstatement.bindColumn(15, idx_cert_media);
      gpstatement.bindColumn(16, idx_corp_id);
      gpstatement.bindColumn(17, idx_cre_by);
      gpstatement.bindColumn(18, idx_cre_date);
      gpstatement.bindColumn(19, idx_upd_by);
      gpstatement.bindColumn(20, idx_upd_date);
      gpstatement.bindColumn(21, idx_org_value);
      gpstatement.bindColumn(22, idx_sign_value);
      gpstatement.bindColumn(23, idx_verify_value);
      gpstatement.bindColumn(24, idx_signer_value);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_cert_master set " + 
                            "cert_id=?,  " + 
                            "smt_date=?,  " + 
                            "app_date=?,  " + 
                            "exp_date=?,  " + 
                            "cert_auth=?,  " + 
                            "cert_authcode=?,  " + 
                            "cert_dn=?,  " + 
                            "cert_info=?,  " + 
                            "cert_hash=?,  " + 
                            "cert_serial=?,  " + 
                            "cert_old=?,  " + 
                            "cnf_date=?,  " + 
                            "cnf_gb=?,  " + 
                            "use_gb=?,  " + 
                            "cert_media=?,  " + 
                            "corp_id=?,  " + 
                            "cre_by=?,  " + 
                            "cre_date=?,  " + 
                            "upd_by=?,  " + 
                            "upd_date=?,  " + 
                            "org_value=?,  " + 
                            "sign_value=?,  " + 
                            "verify_value=?,  " + 
                            "signer_value=?  where cert_id=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cert_id);
      gpstatement.bindColumn(2, idx_smt_date);
      gpstatement.bindColumn(3, idx_app_date);
      gpstatement.bindColumn(4, idx_exp_date);
      gpstatement.bindColumn(5, idx_cert_auth);
      gpstatement.bindColumn(6, idx_cert_authcode);
      gpstatement.bindColumn(7, idx_cert_dn);
      gpstatement.bindColumn(8, idx_cert_info);
      gpstatement.bindColumn(9, idx_cert_hash);
      gpstatement.bindColumn(10, idx_cert_serial);
      gpstatement.bindColumn(11, idx_cert_old);
      gpstatement.bindColumn(12, idx_cnf_date);
      gpstatement.bindColumn(13, idx_cnf_gb);
      gpstatement.bindColumn(14, idx_use_gb);
      gpstatement.bindColumn(15, idx_cert_media);
      gpstatement.bindColumn(16, idx_corp_id);
      gpstatement.bindColumn(17, idx_cre_by);
      gpstatement.bindColumn(18, idx_cre_date);
      gpstatement.bindColumn(19, idx_upd_by);
      gpstatement.bindColumn(20, idx_upd_date);
      gpstatement.bindColumn(21, idx_org_value);
      gpstatement.bindColumn(22, idx_sign_value);
      gpstatement.bindColumn(23, idx_verify_value);
      gpstatement.bindColumn(24, idx_signer_value);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(25, idx_cert_id);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_cert_master where cert_id=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_cert_id);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>