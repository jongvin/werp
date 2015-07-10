<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_code_insert_evl_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_spec_seq = dSet.indexOfColumn("spec_seq");
   	int idx_code_name = dSet.indexOfColumn("code_name");
   	int idx_score = dSet.indexOfColumn("score");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CODE_EVL_CHILD ( class," + 
                    "seq," + 
                    "spec_seq," + 
                    "code_name," + 
                    "score," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_spec_seq);
      gpstatement.bindColumn(4, idx_code_name);
      gpstatement.bindColumn(5, idx_score);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_code_evl_child set " + 
                            "class=?,  " + 
                            "seq=?,  " + 
                            "spec_seq=?,  " + 
                            "code_name=?,  " + 
                            "score=?,  " + 
                            "remark=?  where class=? " +
                            "            and seq=? " +
                            "            and spec_seq=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_spec_seq);
      gpstatement.bindColumn(4, idx_code_name);
      gpstatement.bindColumn(5, idx_score);
      gpstatement.bindColumn(6, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_class);
      gpstatement.bindColumn(8, idx_seq);
      gpstatement.bindColumn(9, idx_spec_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_code_evl_child where class=? " +
                            "            and seq=? " +
                            "            and spec_seq=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_spec_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>