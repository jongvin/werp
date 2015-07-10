<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_dept_4tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_kind = dSet.indexOfColumn("kind");
   	int idx_issue_date = dSet.indexOfColumn("issue_date");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_commission = dSet.indexOfColumn("commission");
   	int idx_inspect_date = dSet.indexOfColumn("inspect_date");
   	int idx_creditor = dSet.indexOfColumn("creditor");
   	int idx_status = dSet.indexOfColumn("status");
   	int idx_cancel_date = dSet.indexOfColumn("cancel_date");
   	int idx_refund_amt = dSet.indexOfColumn("refund_amt");
   	int idx_duty_id = dSet.indexOfColumn("duty_id");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_DEPT_GUARANTEE ( dept_code," + 
                    "seq," + 
                    "kind," + 
                    "issue_date," + 
                    "amt," + 
                    "commission," + 
                    "inspect_date," + 
                    "creditor," + 
                    "status," + 
                    "cancel_date," + 
                    "refund_amt," + 
                    "duty_id )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_kind);
      gpstatement.bindColumn(4, idx_issue_date);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_commission);
      gpstatement.bindColumn(7, idx_inspect_date);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_status);
      gpstatement.bindColumn(10, idx_cancel_date);
      gpstatement.bindColumn(11, idx_refund_amt);
      gpstatement.bindColumn(12, idx_duty_id);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_dept_guarantee set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "kind=?,  " + 
                            "issue_date=?,  " + 
                            "amt=?,  " + 
                            "commission=?,  " + 
                            "inspect_date=?,  " + 
                            "creditor=?,  " + 
                            "status=?,  " + 
                            "cancel_date=?,  " + 
                            "refund_amt=?,  " + 
                            "duty_id=?  where dept_code=? " +
                            "             and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_kind);
      gpstatement.bindColumn(4, idx_issue_date);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_commission);
      gpstatement.bindColumn(7, idx_inspect_date);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_status);
      gpstatement.bindColumn(10, idx_cancel_date);
      gpstatement.bindColumn(11, idx_refund_amt);
      gpstatement.bindColumn(12, idx_duty_id);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_dept_guarantee where dept_code=? " +
                                              "  and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>