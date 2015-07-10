<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_code_insert_evl_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_tot_score = dSet.indexOfColumn("tot_score");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_detail = dSet.indexOfColumn("detail");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CODE_EVL_PARENT ( class," + 
                    "seq," + 
                    "name," + 
                    "tot_score," + 
                    "evl_class," + 
                    "remark ,detail)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6,:7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_tot_score);
      gpstatement.bindColumn(5, idx_evl_class);
      gpstatement.bindColumn(6, idx_remark);
      gpstatement.bindColumn(7, idx_detail);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_code_evl_parent set " + 
                            "class=?,  " + 
                            "seq=?,  " + 
                            "name=?,  " + 
                            "tot_score=?,  " + 
                            "evl_class=?,  " + 
                            "remark=?,detail=?  where class=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_tot_score);
      gpstatement.bindColumn(5, idx_evl_class);
      gpstatement.bindColumn(6, idx_remark);
      gpstatement.bindColumn(7, idx_detail);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_class);
      gpstatement.bindColumn(9, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_code_evl_parent where class=? " +
                                   "                 and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>