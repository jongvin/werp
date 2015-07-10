<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_dept_5tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_input_seq = dSet.indexOfColumn("input_seq");
   	int idx_key_input_date = dSet.indexOfColumn("key_input_date");
   	int idx_key_input_seq = dSet.indexOfColumn("key_input_seq");
   	int idx_title = dSet.indexOfColumn("title");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_record_duty_id = dSet.indexOfColumn("record_duty_id");
   	int idx_identify_date = dSet.indexOfColumn("identify_date");
   	int idx_finish_yn = dSet.indexOfColumn("finish_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_CODE_DEPT_MEMO ( dept_code," + 
                    "input_date," + 
                    "input_seq," + 
                    "title," + 
                    "contents," + 
                    "record_duty_id," + 
                    "identify_date," + 
                    "finish_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_input_date);
      gpstatement.bindColumn(3, idx_input_seq);
      gpstatement.bindColumn(4, idx_title);
      gpstatement.bindColumn(5, idx_contents);
      gpstatement.bindColumn(6, idx_record_duty_id);
      gpstatement.bindColumn(7, idx_identify_date);
      gpstatement.bindColumn(8, idx_finish_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_code_dept_memo set " + 
                            "dept_code=?,  " + 
                            "input_date=?,  " + 
                            "input_seq=?,  " + 
                            "title=?,  " + 
                            "contents=?,  " + 
                            "record_duty_id=?,  " + 
                            "identify_date=?,  " + 
                            "finish_yn=?  where dept_code=? " +
                            " and input_date=? " +
                            " and input_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_input_date);
      gpstatement.bindColumn(3, idx_input_seq);
      gpstatement.bindColumn(4, idx_title);
      gpstatement.bindColumn(5, idx_contents);
      gpstatement.bindColumn(6, idx_record_duty_id);
      gpstatement.bindColumn(7, idx_identify_date);
      gpstatement.bindColumn(8, idx_finish_yn);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_key_input_date);
      gpstatement.bindColumn(11, idx_key_input_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_code_dept_memo where dept_code=? " + 
                            " and input_date=? " +
                            " and input_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_input_date);
      gpstatement.bindColumn(3, idx_key_input_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>