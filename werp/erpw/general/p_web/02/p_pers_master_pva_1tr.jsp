<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_pva_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_pva_code = dSet.indexOfColumn("pva_code");
   	int idx_mpva_code = dSet.indexOfColumn("mpva_code");
   	int idx_relation_code = dSet.indexOfColumn("relation_code");
   	int idx_mpv_name = dSet.indexOfColumn("mpv_name");
   	int idx_mpv_no = dSet.indexOfColumn("mpv_no");
   	int idx_handicap_code = dSet.indexOfColumn("handicap_code");
   	int idx_handicap_level = dSet.indexOfColumn("handicap_level");
   	int idx_ind_s_date = dSet.indexOfColumn("ind_s_date");
   	int idx_ind_e_date = dSet.indexOfColumn("ind_e_date");
   	int idx_ind_level = dSet.indexOfColumn("ind_level");
   	int idx_pva_remark = dSet.indexOfColumn("pva_remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_pva ( resident_no," + 
                    "pva_code," + 
                    "mpva_code," + 
                    "relation_code," + 
                    "mpv_name," + 
                    "mpv_no," + 
                    "handicap_code," + 
                    "handicap_level," + 
                    "ind_s_date," + 
                    "ind_e_date," + 
                    "ind_level," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_pva_code);
      gpstatement.bindColumn(3, idx_mpva_code);
      gpstatement.bindColumn(4, idx_relation_code);
      gpstatement.bindColumn(5, idx_mpv_name);
      gpstatement.bindColumn(6, idx_mpv_no);
      gpstatement.bindColumn(7, idx_handicap_code);
      gpstatement.bindColumn(8, idx_handicap_level);
      gpstatement.bindColumn(9, idx_ind_s_date);
      gpstatement.bindColumn(10, idx_ind_e_date);
      gpstatement.bindColumn(11, idx_ind_level);
      gpstatement.bindColumn(12, idx_pva_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_pva set " + 
                            "resident_no=?,  " + 
                            "pva_code=?,  " + 
                            "mpva_code=?,  " + 
                            "relation_code=?,  " + 
                            "mpv_name=?,  " + 
                            "mpv_no=?,  " + 
                            "handicap_code=?,  " + 
                            "handicap_level=?,  " + 
                            "ind_s_date=?,  " + 
                            "ind_e_date=?,  " + 
                            "ind_level=?,  " + 
                            "remark=?  where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_pva_code);
      gpstatement.bindColumn(3, idx_mpva_code);
      gpstatement.bindColumn(4, idx_relation_code);
      gpstatement.bindColumn(5, idx_mpv_name);
      gpstatement.bindColumn(6, idx_mpv_no);
      gpstatement.bindColumn(7, idx_handicap_code);
      gpstatement.bindColumn(8, idx_handicap_level);
      gpstatement.bindColumn(9, idx_ind_s_date);
      gpstatement.bindColumn(10, idx_ind_e_date);
      gpstatement.bindColumn(11, idx_ind_level);
      gpstatement.bindColumn(12, idx_pva_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_pva where resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>