<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_sms_detail_seq_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_h_sms_unq_num = dSet.indexOfColumn("h_sms_unq_num");
   	int idx_tag = dSet.indexOfColumn("tag");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_sms_yn = dSet.indexOfColumn("sms_yn");
   	int idx_cell_phone = dSet.indexOfColumn("cell_phone");
   	int idx_email_yn = dSet.indexOfColumn("email_yn");
   	int idx_e_mail = dSet.indexOfColumn("e_mail");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sms_detail ( no_seq," + 
                    "h_sms_unq_num," + 
                    "tag," + 
                    "dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "pyong," + 
                    "cust_code," + 
                    "cust_name," + 
                    "contract_date," + 
                    "sms_yn," + 
                    "cell_phone," + 
                    "email_yn," + 
                    "e_mail )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_h_sms_unq_num);
      gpstatement.bindColumn(3, idx_tag);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_sell_code);
      gpstatement.bindColumn(6, idx_dongho);
      gpstatement.bindColumn(7, idx_pyong);
      gpstatement.bindColumn(8, idx_cust_code);
      gpstatement.bindColumn(9, idx_cust_name);
      gpstatement.bindColumn(10, idx_contract_date);
      gpstatement.bindColumn(11, idx_sms_yn);
      gpstatement.bindColumn(12, idx_cell_phone);
      gpstatement.bindColumn(13, idx_email_yn);
      gpstatement.bindColumn(14, idx_e_mail);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sms_detail set " + 
                            "no_seq=?,  " + 
                            "h_sms_unq_num=?,  " + 
                            "tag=?,  " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "pyong=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "contract_date=?,  " + 
                            "sms_yn=?,  " + 
                            "cell_phone=?,  " + 
                            "email_yn=?,  " + 
                            "e_mail=?  where no_seq=? and h_sms_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_h_sms_unq_num);
      gpstatement.bindColumn(3, idx_tag);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_sell_code);
      gpstatement.bindColumn(6, idx_dongho);
      gpstatement.bindColumn(7, idx_pyong);
      gpstatement.bindColumn(8, idx_cust_code);
      gpstatement.bindColumn(9, idx_cust_name);
      gpstatement.bindColumn(10, idx_contract_date);
      gpstatement.bindColumn(11, idx_sms_yn);
      gpstatement.bindColumn(12, idx_cell_phone);
      gpstatement.bindColumn(13, idx_email_yn);
      gpstatement.bindColumn(14, idx_e_mail);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_no_seq);
      gpstatement.bindColumn(16, idx_h_sms_unq_num);

      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sms_detail where no_seq=? and h_sms_unq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_h_sms_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>