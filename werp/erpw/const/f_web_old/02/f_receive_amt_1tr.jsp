<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_receive_amt_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_receive_date = dSet.indexOfColumn("receive_date");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_cash_amt = dSet.indexOfColumn("cash_amt");
   	int idx_bill_amt = dSet.indexOfColumn("bill_amt");
   	int idx_check_amt = dSet.indexOfColumn("check_amt");
   	int idx_bank_amt = dSet.indexOfColumn("bank_amt");
   	int idx_etc_amt = dSet.indexOfColumn("etc_amt");
   	int idx_rqst_detail = dSet.indexOfColumn("rqst_detail");
   	int idx_key_receive_date = dSet.indexOfColumn("key_receive_date");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_RECEIVE_AMT ( dept_code," + 
                    "receive_date," + 
                    "seq," + 
                    "cash_amt," + 
                    "bill_amt," + 
                    "check_amt," + 
                    "bank_amt," + 
                    "etc_amt," + 
                    "rqst_detail )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receive_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_cash_amt);
      gpstatement.bindColumn(5, idx_bill_amt);
      gpstatement.bindColumn(6, idx_check_amt);
      gpstatement.bindColumn(7, idx_bank_amt);
      gpstatement.bindColumn(8, idx_etc_amt);
      gpstatement.bindColumn(9, idx_rqst_detail);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_receive_amt set " + 
                            "dept_code=?,  " + 
                            "receive_date=?,  " + 
                            "seq=?,  " + 
                            "cash_amt=?,  " + 
                            "bill_amt=?,  " + 
                            "check_amt=?,  " + 
                            "bank_amt=?,  " + 
                            "etc_amt=?,  " + 
                            "rqst_detail=?  where dept_code=? " +
                            " and receive_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receive_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_cash_amt);
      gpstatement.bindColumn(5, idx_bill_amt);
      gpstatement.bindColumn(6, idx_check_amt);
      gpstatement.bindColumn(7, idx_bank_amt);
      gpstatement.bindColumn(8, idx_etc_amt);
      gpstatement.bindColumn(9, idx_rqst_detail);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_key_receive_date);
      gpstatement.bindColumn(12, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_receive_amt where dept_code=? " + 
                            " and receive_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receive_date);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>