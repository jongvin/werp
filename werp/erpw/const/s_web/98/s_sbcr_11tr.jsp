<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_11tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_imp_class = dSet.indexOfColumn("imp_class");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_IMP_MATERIAL ( sbcr_code," + 
                    "mtrcode," + 
                    "name," + 
                    "imp_class," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_imp_class);
      gpstatement.bindColumn(5, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_imp_material set " + 
                            "sbcr_code=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "imp_class=?,  " + 
                            "remark=?  where sbcr_code=? " +
                            "            and mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_imp_class);
      gpstatement.bindColumn(5, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_sbcr_code);
      gpstatement.bindColumn(7, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_imp_material where sbcr_code=? " +
                                                " and mtrcode=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>