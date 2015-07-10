<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr.jsp"%><%
     conn.setAutoCommit(false);
     GauceDataSet dSet = req.getGauceDataSet("f_request_detail_1tr"); 
     gpstatement.gp_dataset = dSet;                                    // 이문장을 추가 
   	int idx_dept_code    = dSet.indexOfColumn("dept_code");
   	int idx_yymm         = dSet.indexOfColumn("yymm");
   	int idx_code         = dSet.indexOfColumn("code");
   	int idx_det_code     = dSet.indexOfColumn("det_code");
   	int idx_seq          = dSet.indexOfColumn("seq");
   	int idx_spec_no_seq  = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_name = dSet.indexOfColumn("request_name");
   	int idx_request_amt  = dSet.indexOfColumn("request_amt");
   	int idx_adjust_amt   = dSet.indexOfColumn("adjust_amt");
   	int idx_decision_amt = dSet.indexOfColumn("decision_amt");
   	int idx_note         = dSet.indexOfColumn("note");
   	int idx_key_value1   = dSet.indexOfColumn("key_value1");
   	int idx_key_value2   = dSet.indexOfColumn("key_value2");
   	int idx_key_value3   = dSet.indexOfColumn("key_value3");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); 
      gpstatement.gp_row = i;                                         // 이문장 추가
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO f_request_detail ( dept_code," + 
                    "yymm,         " + 
                    "code,         " +
                    "det_code,     " +
                    "seq,          " +
                    "spec_no_seq,  " +
                    "spec_unq_num, " +
                    "request_name, " +
                    "request_amt,  " +
                    "adjust_amt,   " +
                    "decision_amt, " +
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_code);
      gpstatement.bindColumn(4, idx_det_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_spec_no_seq);
      gpstatement.bindColumn(7, idx_spec_unq_num);
      gpstatement.bindColumn(8, idx_request_name);
      gpstatement.bindColumn(9, idx_request_amt);
      gpstatement.bindColumn(10, idx_adjust_amt);
      gpstatement.bindColumn(11, idx_decision_amt);
      gpstatement.bindColumn(12, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_request_detail set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "code=?, " +
                            "det_code=?, " +
                            "seq=?, " +
                            "spec_no_seq=?,  " +
                            "spec_unq_num=?, " +
                            "request_name=?, " +
                            "request_amt=?,  " +
                            "adjust_amt=?,   " +
                            "decision_amt=?, " +
                            "note=? where dept_code=? and yymm=? and code=? and det_code=? and seq=?";  
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_code);
      gpstatement.bindColumn(4, idx_det_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_spec_no_seq);
      gpstatement.bindColumn(7, idx_spec_unq_num);
      gpstatement.bindColumn(8, idx_request_name);
      gpstatement.bindColumn(9, idx_request_amt);
      gpstatement.bindColumn(10, idx_adjust_amt);
      gpstatement.bindColumn(11, idx_decision_amt);
      gpstatement.bindColumn(12, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_yymm);
      gpstatement.bindColumn(15, idx_key_value1);
      gpstatement.bindColumn(16, idx_key_value2);
      gpstatement.bindColumn(17, idx_key_value3);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_request_detail where dept_code=? and yymm=? and code=? and det_code=? and seq=?"; 
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_key_value1);
      gpstatement.bindColumn(4, idx_key_value2);
      gpstatement.bindColumn(5, idx_key_value3);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>