<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_output_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_key_yymmdd = dSet.indexOfColumn("key_yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_outputtitle = dSet.indexOfColumn("outputtitle");
   	int idx_relative_proj_code = dSet.indexOfColumn("relative_proj_code");
   	int idx_input_yymmdd = dSet.indexOfColumn("input_yymmdd");
   	int idx_relative_seq = dSet.indexOfColumn("relative_seq");
   	int idx_inouttypecode = dSet.indexOfColumn("inouttypecode");
   	int idx_paymethod = dSet.indexOfColumn("paymethod");
   	int idx_total_amt = dSet.indexOfColumn("total_amt");
   	int idx_trans_tag = dSet.indexOfColumn("trans_tag");
   	int idx_memo = dSet.indexOfColumn("memo");
	int idx_sale_amt = dSet.indexOfColumn("sale_amt");
    int idx_sale_vat = dSet.indexOfColumn("sale_vat");
	int idx_rqst_date = dSet.indexOfColumn("rqst_date");
	int idx_cust_code = dSet.indexOfColumn("cust_code");
	int idx_cust_name = dSet.indexOfColumn("cust_name");
	int idx_slip_unq_num = dSet.indexOfColumn("slip_unq_num");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO m_output ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "outputtitle," + 
                    "relative_proj_code," + 
                    "input_yymmdd," + 
                    "relative_seq," + 
                    "inouttypecode," + 
                    "paymethod," + 
                    "total_amt," + 
                    "trans_tag," + 
                    "memo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_outputtitle);
      gpstatement.bindColumn(5, idx_relative_proj_code);
      gpstatement.bindColumn(6, idx_input_yymmdd);
      gpstatement.bindColumn(7, idx_relative_seq);
      gpstatement.bindColumn(8, idx_inouttypecode);
      gpstatement.bindColumn(9, idx_paymethod);
      gpstatement.bindColumn(10, idx_total_amt);
      gpstatement.bindColumn(11, idx_trans_tag);
      gpstatement.bindColumn(12, idx_memo);
      stmt.executeUpdate();
      stmt.close();

	  sSql = " INSERT INTO m_output_sale ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "sale_amt,sale_vat,rqst_date,cust_code,cust_name,invoice_num) " ;
	  sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, '0') ";
	  stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_sale_amt);
	  gpstatement.bindColumn(5, idx_sale_vat);
	  gpstatement.bindColumn(6, idx_rqst_date);
	  gpstatement.bindColumn(7, idx_cust_code);
	  gpstatement.bindColumn(8, idx_cust_name);
	  stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update m_output set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "outputtitle=?,  " + 
                            "relative_proj_code=?,  " + 
                            "input_yymmdd=?,  " + 
                            "relative_seq=?,  " + 
                            "inouttypecode=?,  " + 
                            "paymethod=?,  " + 
                            "total_amt=?,  " + 
                            "trans_tag=?,  " + 
                            "memo=?  where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_outputtitle);
      gpstatement.bindColumn(5, idx_relative_proj_code);
      gpstatement.bindColumn(6, idx_input_yymmdd);
      gpstatement.bindColumn(7, idx_relative_seq);
      gpstatement.bindColumn(8, idx_inouttypecode);
      gpstatement.bindColumn(9, idx_paymethod);
      gpstatement.bindColumn(10, idx_total_amt);
      gpstatement.bindColumn(11, idx_trans_tag);
      gpstatement.bindColumn(12, idx_memo);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_key_yymmdd);
      gpstatement.bindColumn(15, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();

	  sSql = "update m_output_sale set " + 
                            " sale_amt=?,  " + 
				            " sale_vat=?,  " + 
		                    " rqst_date=?,  " + 
                            " cust_code=?,  " + 
		                    " cust_name=?  " + 
                            " where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  "; 
	  stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
	  gpstatement.bindColumn(1, idx_sale_amt);
	  gpstatement.bindColumn(2, idx_sale_vat);
	  gpstatement.bindColumn(3, idx_rqst_date);
	  gpstatement.bindColumn(4, idx_cust_code);
	  gpstatement.bindColumn(5, idx_cust_name);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_key_yymmdd);
      gpstatement.bindColumn(8, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
      String sSql = "delete from m_output where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  ";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymmdd);
      gpstatement.bindColumn(3, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();

    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>