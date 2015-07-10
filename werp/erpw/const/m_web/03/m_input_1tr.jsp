<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_key_yymmdd = dSet.indexOfColumn("key_yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_inputtitle = dSet.indexOfColumn("inputtitle");
   	int idx_relative_proj_code = dSet.indexOfColumn("relative_proj_code");
   	int idx_output_yymmdd = dSet.indexOfColumn("output_yymmdd");
   	int idx_relative_seq = dSet.indexOfColumn("relative_seq");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_inouttypecode = dSet.indexOfColumn("inouttypecode");
   	int idx_paymethod = dSet.indexOfColumn("paymethod");
   	int idx_total_amt = dSet.indexOfColumn("total_amt");
   	int idx_memo = dSet.indexOfColumn("memo");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_INPUT ( dept_code," + 
                    "yymmdd," + 
                    "seq," + 
                    "inputtitle," + 
                    "relative_proj_code," + 
                    "output_yymmdd," +
                    "relative_seq," + 
                    "sbcr_code," + 
                    "inouttypecode," + 
                    "paymethod," + 
                    "total_amt," + 
                    "memo,invoice_num )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_inputtitle);
      gpstatement.bindColumn(5, idx_relative_proj_code);
      gpstatement.bindColumn(6, idx_output_yymmdd);
      gpstatement.bindColumn(7, idx_relative_seq);
      gpstatement.bindColumn(8, idx_sbcr_code);
      gpstatement.bindColumn(9, idx_inouttypecode);
      gpstatement.bindColumn(10, idx_paymethod);
      gpstatement.bindColumn(11, idx_total_amt);
      gpstatement.bindColumn(12, idx_memo);
      gpstatement.bindColumn(13, idx_invoice_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_input set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "inputtitle=?,  " + 
                            "relative_proj_code=?,  " + 
                            "output_yymmdd=?,  " +
                            "relative_seq=?,  " + 
                            "sbcr_code=?,  " + 
                            "inouttypecode=?,  " + 
                            "paymethod=?,  " + 
                            "total_amt=?,  " + 
                            "memo=? ,invoice_num=? where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_inputtitle);
      gpstatement.bindColumn(5, idx_relative_proj_code);
      gpstatement.bindColumn(6, idx_output_yymmdd);
      gpstatement.bindColumn(7, idx_relative_seq);
      gpstatement.bindColumn(8, idx_sbcr_code);
      gpstatement.bindColumn(9, idx_inouttypecode);
      gpstatement.bindColumn(10, idx_paymethod);
      gpstatement.bindColumn(11, idx_total_amt);
      gpstatement.bindColumn(12, idx_memo);
      gpstatement.bindColumn(13, idx_invoice_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_key_yymmdd);
      gpstatement.bindColumn(16, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_input where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>