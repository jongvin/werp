<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_trans_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_outputtitle = dSet.indexOfColumn("outputtitle");
   	int idx_relative_proj_code = dSet.indexOfColumn("relative_proj_code");
   	int idx_input_yymmdd = dSet.indexOfColumn("input_yymmdd");
   	int idx_relative_seq = dSet.indexOfColumn("relative_seq");
   	int idx_total_amt = dSet.indexOfColumn("total_amt");
   	int idx_trans_tag = dSet.indexOfColumn("trans_tag");
   	int idx_memo = dSet.indexOfColumn("memo");
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
                    "total_amt," + 
                    "trans_tag," + 
                    "memo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_outputtitle);
      gpstatement.bindColumn(5, idx_relative_proj_code);
      gpstatement.bindColumn(6, idx_input_yymmdd);
      gpstatement.bindColumn(7, idx_relative_seq);
      gpstatement.bindColumn(8, idx_total_amt);
      gpstatement.bindColumn(9, idx_trans_tag);
      gpstatement.bindColumn(10, idx_memo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_output set " + 
                            "dept_code=?,  " + 
                            "yymmdd=?,  " + 
                            "seq=?,  " + 
                            "outputtitle=?,  " + 
                            "relative_proj_code=?,  " + 
                            "input_yymmdd=?,  " + 
                            "relative_seq=?,  " + 
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
      gpstatement.bindColumn(8, idx_total_amt);
      gpstatement.bindColumn(9, idx_trans_tag);
      gpstatement.bindColumn(10, idx_memo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_yymmdd);
      gpstatement.bindColumn(13, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_output where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>