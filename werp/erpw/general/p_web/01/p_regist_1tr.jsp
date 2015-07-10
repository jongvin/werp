<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_regist_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_code_name = dSet.indexOfColumn("code_name");
   	int idx_table_name = dSet.indexOfColumn("table_name");
   	int idx_code_pk_no = dSet.indexOfColumn("code_pk_no");
   	int idx_ds_name = dSet.indexOfColumn("ds_name");
   	int idx_ur_authority = dSet.indexOfColumn("ur_authority");
   	int idx_use_yn = dSet.indexOfColumn("use_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_regist ( spec_no_seq," + 
                    "code_name," + 
                    "table_name," + 
                    "code_pk_no," + 
                    "ds_name," + 
                    "ur_authority," + 
                    "use_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_code_name);
      gpstatement.bindColumn(3, idx_table_name);
      gpstatement.bindColumn(4, idx_code_pk_no);
      gpstatement.bindColumn(5, idx_ds_name);
      gpstatement.bindColumn(6, idx_ur_authority);
      gpstatement.bindColumn(7, idx_use_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_regist set " + 
                            "spec_no_seq=?,  " + 
                            "code_name=?,  " + 
                            "table_name=?,  " + 
                            "code_pk_no=?,  " + 
                            "ds_name=?,  " + 
                            "ur_authority=?,  " + 
                            "use_yn=?  where spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_code_name);
      gpstatement.bindColumn(3, idx_table_name);
      gpstatement.bindColumn(4, idx_code_pk_no);
      gpstatement.bindColumn(5, idx_ds_name);
      gpstatement.bindColumn(6, idx_ur_authority);
      gpstatement.bindColumn(7, idx_use_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_regist where spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>