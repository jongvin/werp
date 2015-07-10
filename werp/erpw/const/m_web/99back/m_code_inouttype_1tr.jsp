<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_code_inouttype_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_inouttypecode = dSet.indexOfColumn("inouttypecode");
   	int idx_old_inouttypecode = dSet.indexOfColumn("old_inouttypecode");
   	int idx_inouttypename = dSet.indexOfColumn("inouttypename");
   	int idx_usetag = dSet.indexOfColumn("usetag");
   	int idx_typecode = dSet.indexOfColumn("typecode");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_CODE_INOUTTYPE ( inouttypecode," + 
                    "inouttypename," + 
                    "usetag," + 
                    "typecode )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_inouttypecode);
      gpstatement.bindColumn(2, idx_inouttypename);
      gpstatement.bindColumn(3, idx_usetag);
      gpstatement.bindColumn(4, idx_typecode);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_code_inouttype set " + 
                            "inouttypecode=?,  " + 
                            "inouttypename=?,  " + 
                            "usetag=?,  " + 
                            "typecode=?  where inouttypecode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_inouttypecode);
      gpstatement.bindColumn(2, idx_inouttypename);
      gpstatement.bindColumn(3, idx_usetag);
      gpstatement.bindColumn(4, idx_typecode);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_old_inouttypecode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_code_inouttype where inouttypecode=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_old_inouttypecode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>