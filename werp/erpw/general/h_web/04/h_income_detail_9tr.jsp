<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_income_detail_9tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_key_input_date = dSet.indexOfColumn("key_input_date");
   	int idx_input_seq = dSet.indexOfColumn("input_seq");
   	int idx_key_input_seq = dSet.indexOfColumn("key_input_seq");
   	int idx_title = dSet.indexOfColumn("title");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_record_duty_id = dSet.indexOfColumn("record_duty_id");
   	int idx_identify_date = dSet.indexOfColumn("identify_date");
   	int idx_finish_yn = dSet.indexOfColumn("finish_yn");
	int idx_memo_code = dSet.indexOfColumn("memo_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_MEMO ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "input_date," + 
                    "input_seq," + 
                    "title," + 
                    "contents," + 
                    "record_duty_id," + 
                    "identify_date," + 
                    "finish_yn,"+
			        "memo_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_input_date);
      gpstatement.bindColumn(6, idx_input_seq);
      gpstatement.bindColumn(7, idx_title);
      gpstatement.bindColumn(8, idx_contents);
      gpstatement.bindColumn(9, idx_record_duty_id);
      gpstatement.bindColumn(10, idx_identify_date);
      gpstatement.bindColumn(11, idx_finish_yn);
	  gpstatement.bindColumn(12, idx_memo_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_memo set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "input_date=?,  " + 
                            "input_seq=?,  " + 
                            "title=?,  " + 
                            "contents=?,  " + 
                            "record_duty_id=?,  " + 
                            "identify_date=?,  " + 
                            "finish_yn=?,"+
	                        "memo_code=? where dept_code=? " +
                            "               and sell_code=? " +
                            "               and dongho=? " +
                            "               and seq=? " +
                            "               and input_date=? " +
                            "               and input_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_input_date);
      gpstatement.bindColumn(6, idx_input_seq);
      gpstatement.bindColumn(7, idx_title);
      gpstatement.bindColumn(8, idx_contents);
      gpstatement.bindColumn(9, idx_record_duty_id);
      gpstatement.bindColumn(10, idx_identify_date);
      gpstatement.bindColumn(11, idx_finish_yn);
	  gpstatement.bindColumn(12, idx_memo_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_sell_code);
      gpstatement.bindColumn(15, idx_dongho);
      gpstatement.bindColumn(16, idx_seq);
      gpstatement.bindColumn(17, idx_key_input_date);
      gpstatement.bindColumn(18, idx_key_input_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_memo where dept_code=? " + 
                            "               and sell_code=? " +
                            "               and dongho=? " +
                            "               and seq=? " +
                            "               and input_date=? " +
                            "               and input_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_key_input_date);
      gpstatement.bindColumn(6, idx_key_input_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>