<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_code_tmat_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_tmat_code = dSet.indexOfColumn("tmat_code");
   	int idx_key_tmat_code = dSet.indexOfColumn("key_tmat_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_bigo = dSet.indexOfColumn("bigo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_TMAT_CODE ( tmat_code," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "bigo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_tmat_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_ssize);
      gpstatement.bindColumn(4, idx_unitcode);
      gpstatement.bindColumn(5, idx_bigo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_tmat_code set " + 
                            "tmat_code=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "bigo=?  where tmat_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_tmat_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_ssize);
      gpstatement.bindColumn(4, idx_unitcode);
      gpstatement.bindColumn(5, idx_bigo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_key_tmat_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_tmat_code where tmat_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_tmat_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>