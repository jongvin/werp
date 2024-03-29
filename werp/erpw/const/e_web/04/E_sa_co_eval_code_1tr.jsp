<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_co_eval_code_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_opinion_type = dSet.indexOfColumn("opinion_type");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_part = dSet.indexOfColumn("part_code");
   	int idx_item = dSet.indexOfColumn("item_code");
   	int idx_key_item = dSet.indexOfColumn("key_item");
   	int idx_or_item = dSet.indexOfColumn("or_item");
   	int idx_or_point = dSet.indexOfColumn("or_point");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_opinion_register ( opinion_type," + 
                    "seq," + 
                    "part_code," + 
                    "item_code," + 
                    "or_item," + 
                    "or_point )      ";
      sSql = sSql + " VALUES ( '2', :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
//      gpstatement.bindColumn(1, idx_opinion_type);
      gpstatement.bindColumn(1, idx_seq);
      gpstatement.bindColumn(2, idx_part);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_or_item);
      gpstatement.bindColumn(5, idx_or_point);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_opinion_register set " + 
                            "opinion_type='2',  " + 
                            "seq=?,  " + 
                            "part_code=?,  " + 
                            "item_code=?,  " + 
                            "or_item=?,  " + 
                            "or_point=?  where opinion_type=? and item_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_seq);
      gpstatement.bindColumn(2, idx_part);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_or_item);
      gpstatement.bindColumn(5, idx_or_point);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_opinion_type);
      gpstatement.bindColumn(7, idx_key_item);
      gpstatement.bindColumn(8, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_opinion_register where opinion_type=? and item_code=? and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_opinion_type);
      gpstatement.bindColumn(2, idx_key_item);
      gpstatement.bindColumn(3, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>