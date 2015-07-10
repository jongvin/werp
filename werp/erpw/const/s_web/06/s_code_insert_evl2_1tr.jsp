<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_code_insert_evl2_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_proj_class = dSet.indexOfColumn("proj_class");
   	int idx_class1 = dSet.indexOfColumn("class1");
   	int idx_mng_class = dSet.indexOfColumn("mng_class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_proj_class = dSet.indexOfColumn("key_proj_class");
   	int idx_key_class1 = dSet.indexOfColumn("key_class1");
   	int idx_key_mng_class = dSet.indexOfColumn("key_mng_class");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_b_score = dSet.indexOfColumn("b_score");
   	int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_COMM_EVLCODE ( evl_year , " +
						  "degree, " +
						  "evl_class, " +
						  "proj_class," + 
                    "class1," + 
                    "mng_class," + 
                    "seq," +
                    "name," + 
                    "b_score," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 , :8, :9, :10) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_proj_class);
      gpstatement.bindColumn(5, idx_class1);
      gpstatement.bindColumn(6, idx_mng_class);
      gpstatement.bindColumn(7, idx_seq);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_b_score);
      gpstatement.bindColumn(10, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_comm_evlcode set " + 
      							 "evl_year=?, " +
      							 "degree=?," +
      							 "evl_class=?," +
                            "proj_class=?,  " + 
                            "class1=?,  " + 
                            "mng_class=?,  " + 
                            "seq=? , " +
                            "name=?,  " + 
                            "b_score=?,  " + 
                            "note=?  where evl_year=? " +
                            "          and degree=? " +
                            "          and evl_class=? " +
                            "          and proj_class=? " +
                            "          and class1=? " +
                            "          and mng_class=? " +
                            "          and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_proj_class);
      gpstatement.bindColumn(5, idx_class1);
      gpstatement.bindColumn(6, idx_mng_class);
      gpstatement.bindColumn(7, idx_seq);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_b_score);
      gpstatement.bindColumn(10, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_evl_year);
      gpstatement.bindColumn(12, idx_degree);
      gpstatement.bindColumn(13, idx_evl_class);
      gpstatement.bindColumn(14, idx_key_proj_class);
      gpstatement.bindColumn(15, idx_key_class1);
      gpstatement.bindColumn(16,idx_key_mng_class);
      gpstatement.bindColumn(17,idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_comm_evlcode where evl_year=? " +
      							 "          and degree=? " +
      							 "          and evl_class=? " +
      							 "          and proj_class=? " +
                            "          and class1=? " +
                            "          and mng_class=? " +
                            "          and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_degree);
      gpstatement.bindColumn(3, idx_evl_class);
      gpstatement.bindColumn(4, idx_proj_class);
      gpstatement.bindColumn(5, idx_class1);
      gpstatement.bindColumn(6, idx_mng_class);
      gpstatement.bindColumn(7, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>