<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_cond_item_result_content_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_left_1 = dSet.indexOfColumn("left_1");
   	int idx_left_2 = dSet.indexOfColumn("left_2");
   	int idx_item_name = dSet.indexOfColumn("item_name");
   	int idx_item_compute = dSet.indexOfColumn("item_compute");
   	int idx_item_cond = dSet.indexOfColumn("item_cond");
   	int idx_item_cond_code = dSet.indexOfColumn("item_cond_code");
   	int idx_right_1 = dSet.indexOfColumn("right_1");
   	int idx_right_2 = dSet.indexOfColumn("right_2");
   	int idx_item_logic = dSet.indexOfColumn("item_logic");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_cond_item_result_content ( no_seq," + 
                    "seq," + 
                    "left_1," + 
                    "left_2," + 
                    "item_name," + 
                    "item_compute," + 
                    "item_cond," + 
                    "item_cond_code," + 
                    "right_1," + 
                    "right_2," + 
                    "item_logic )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_left_1);
      gpstatement.bindColumn(4, idx_left_2);
      gpstatement.bindColumn(5, idx_item_name);
      gpstatement.bindColumn(6, idx_item_compute);
      gpstatement.bindColumn(7, idx_item_cond);
      gpstatement.bindColumn(8, idx_item_cond_code);
      gpstatement.bindColumn(9, idx_right_1);
      gpstatement.bindColumn(10, idx_right_2);
      gpstatement.bindColumn(11, idx_item_logic);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_cond_item_result_content set " + 
                            "no_seq=?,  " + 
                            "seq=?,  " + 
                            "left_1=?,  " + 
                            "left_2=?,  " + 
                            "item_name=?,  " + 
                            "item_compute=?,  " + 
                            "item_cond=?,  " + 
                            "item_cond_code=?,  " + 
                            "right_1=?,  " + 
                            "right_2=?,  " + 
                            "item_logic=?  where no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_left_1);
      gpstatement.bindColumn(4, idx_left_2);
      gpstatement.bindColumn(5, idx_item_name);
      gpstatement.bindColumn(6, idx_item_compute);
      gpstatement.bindColumn(7, idx_item_cond);
      gpstatement.bindColumn(8, idx_item_cond_code);
      gpstatement.bindColumn(9, idx_right_1);
      gpstatement.bindColumn(10, idx_right_2);
      gpstatement.bindColumn(11, idx_item_logic);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_cond_item_result_content where no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>