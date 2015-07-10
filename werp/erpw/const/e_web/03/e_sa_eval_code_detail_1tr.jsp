<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_eval_code_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_opinion_type = dSet.indexOfColumn("opinion_type");
   	int idx_part = dSet.indexOfColumn("part_code");
   	int idx_item = dSet.indexOfColumn("item_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_or_point = dSet.indexOfColumn("or_point");
   	int idx_max_point = dSet.indexOfColumn("max_point");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_opinion_register_detail ( opinion_type," + 
		              "part_code," +
		              "item_code," +
                    "seq," +
                    "d_seq," + 
                    "contents," + 
                    "or_point )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_opinion_type);
      gpstatement.bindColumn(2, idx_part);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_d_seq);
      gpstatement.bindColumn(6, idx_contents);
      gpstatement.bindColumn(7, idx_or_point);
      stmt.executeUpdate();
      stmt.close();
      
      PreparedStatement stmt2 = null;   
      String sSql2 = "update e_opinion_register set " +
                             "or_point=? where opinion_type=? and item_code=? and seq=? ";
                             
      stmt2 = conn.prepareStatement(sSql2); 
      gpstatement.gp_stmt = stmt2;
      gpstatement.bindColumn(1, idx_max_point);
      gpstatement.bindColumn(2, idx_opinion_type);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_seq);
      stmt2.executeUpdate();
      stmt2.close(); 
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_opinion_register_detail set " + 
                            "opinion_type=?,  " + 
                            "part_code=?, " +
                            "item_code=?, " +
                            "seq=?,  " + 
                            "d_seq=?,  " + 
                            "contents=?,  " + 
                            "or_point=?  where opinion_type=? and item_code=? and seq=? and d_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_opinion_type);
      gpstatement.bindColumn(2, idx_part);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_d_seq);
      gpstatement.bindColumn(6, idx_contents);
      gpstatement.bindColumn(7, idx_or_point);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_opinion_type);
      gpstatement.bindColumn(9, idx_item);
      gpstatement.bindColumn(10, idx_seq);
      gpstatement.bindColumn(11, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
      
      PreparedStatement stmt2 = null;   
      String sSql2 = "update e_opinion_register set " +
                             "or_point=? where opinion_type=? and item_code=? and seq=? ";
                             
      stmt2 = conn.prepareStatement(sSql2); 
      gpstatement.gp_stmt = stmt2;
      gpstatement.bindColumn(1, idx_max_point);
      gpstatement.bindColumn(2, idx_opinion_type);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_seq);
      stmt2.executeUpdate();
      stmt2.close(); 
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_opinion_register_detail  where opinion_type=? and item_code=? and seq=? and d_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_opinion_type);
      gpstatement.bindColumn(2, idx_item);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
      
      PreparedStatement stmt2 = null;   
      String sSql2 = "update e_opinion_register set " +
                             "or_point=? where opinion_type=? and item_code=? and seq=? ";
                             
      stmt2 = conn.prepareStatement(sSql2); 
      gpstatement.gp_stmt = stmt2;
      gpstatement.bindColumn(1, idx_max_point);
      gpstatement.bindColumn(2, idx_opinion_type);
      gpstatement.bindColumn(3, idx_item);
      gpstatement.bindColumn(4, idx_seq);
      stmt2.executeUpdate();
      stmt2.close(); 
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>