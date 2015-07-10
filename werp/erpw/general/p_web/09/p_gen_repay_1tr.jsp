<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_repay_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_repay_date = dSet.indexOfColumn("repay_date");
   	int idx_repay_amt = dSet.indexOfColumn("repay_amt");
   	int idx_interest_amt = dSet.indexOfColumn("interest_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_repay ( " + 
                    "spec_no_seq," + 
                    "repay_date," + 
                    "repay_amt," + 
                    "interest_amt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_repay_date);
      gpstatement.bindColumn(3, idx_repay_amt);
      gpstatement.bindColumn(4, idx_interest_amt);
      gpstatement.bindColumn(5, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_repay set " + 
                            "spec_no_seq=?,  " + 
                            "repay_date=?,  " + 
                            "repay_amt=?,  " + 
                            "interest_amt=?,  " + 
                            "remark=?  where  spec_no_seq=? and repay_date=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_repay_date);
      gpstatement.bindColumn(3, idx_repay_amt);
      gpstatement.bindColumn(4, idx_interest_amt);
      gpstatement.bindColumn(5, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_spec_no_seq);
      gpstatement.bindColumn(7, idx_repay_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_repay where  spec_no_seq=? and repay_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_repay_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>