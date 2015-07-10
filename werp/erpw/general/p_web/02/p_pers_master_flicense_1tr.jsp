<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_flicense_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_flicense_code = dSet.indexOfColumn("flicense_code");
   	int idx_test_date = dSet.indexOfColumn("test_date");
   	int idx_gain_score = dSet.indexOfColumn("gain_score");
   	int idx_full_score = dSet.indexOfColumn("full_score");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_lc = dSet.indexOfColumn("lc");
   	int idx_rc = dSet.indexOfColumn("rc");
   	int idx_rank = dSet.indexOfColumn("rank");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_flicense ( resident_no," + 
                    "flicense_code," + 
                    "test_date," + 
                    "gain_score," + 
                    "full_score," + 
                    "remark," + 
                    "lc," + 
                    "rc," + 
                    "rank )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_flicense_code);
      gpstatement.bindColumn(3, idx_test_date);
      gpstatement.bindColumn(4, idx_gain_score);
      gpstatement.bindColumn(5, idx_full_score);
      gpstatement.bindColumn(6, idx_remark);
      gpstatement.bindColumn(7, idx_lc);
      gpstatement.bindColumn(8, idx_rc);
      gpstatement.bindColumn(9, idx_rank);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_flicense set " + 
                            "resident_no=?,  " + 
                            "flicense_code=?,  " + 
                            "test_date=?,  " + 
                            "gain_score=?,  " + 
                            "full_score=?,  " + 
                            "remark=?,  " + 
                            "lc=?,  " + 
                            "rc=?,  " + 
                            "rank=?  where resident_no=? and flicense_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_flicense_code);
      gpstatement.bindColumn(3, idx_test_date);
      gpstatement.bindColumn(4, idx_gain_score);
      gpstatement.bindColumn(5, idx_full_score);
      gpstatement.bindColumn(6, idx_remark);
      gpstatement.bindColumn(7, idx_lc);
      gpstatement.bindColumn(8, idx_rc);
      gpstatement.bindColumn(9, idx_rank);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_resident_no);
      gpstatement.bindColumn(11, idx_flicense_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_flicense where resident_no=? and flicense_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_flicense_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>