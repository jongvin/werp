<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_family_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_relation_code = dSet.indexOfColumn("relation_code");
   	int idx_family_name = dSet.indexOfColumn("family_name");
   	int idx_family_resi_no = dSet.indexOfColumn("family_resi_no");
   	int idx_offical_name = dSet.indexOfColumn("offical_name");
   	int idx_school_car_code = dSet.indexOfColumn("school_car_code");
   	int idx_official = dSet.indexOfColumn("official");
   	int idx_together_yn = dSet.indexOfColumn("together_yn");
   	int idx_family_amt = dSet.indexOfColumn("family_amt");
   	int idx_surport_yn = dSet.indexOfColumn("surport_yn");
   	int idx_sex_div = dSet.indexOfColumn("sex_div");
   	int idx_family_birthday = dSet.indexOfColumn("family_birthday");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_family ( resident_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "relation_code," + 
                    "family_name," + 
                    "family_resi_no," + 
                    "offical_name," + 
                    "school_car_code," + 
                    "official," + 
                    "together_yn," + 
                    "family_amt," + 
                    "surport_yn," + 
                    "sex_div," + 
                    "family_birthday )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_relation_code);
      gpstatement.bindColumn(5, idx_family_name);
      gpstatement.bindColumn(6, idx_family_resi_no);
      gpstatement.bindColumn(7, idx_offical_name);
      gpstatement.bindColumn(8, idx_school_car_code);
      gpstatement.bindColumn(9, idx_official);
      gpstatement.bindColumn(10, idx_together_yn);
      gpstatement.bindColumn(11, idx_family_amt);
      gpstatement.bindColumn(12, idx_surport_yn);
      gpstatement.bindColumn(13, idx_sex_div);
      gpstatement.bindColumn(14, idx_family_birthday);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_family set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "relation_code=?,  " + 
                            "family_name=?,  " + 
                            "family_resi_no=?,  " + 
                            "offical_name=?,  " + 
                            "school_car_code=?,  " + 
                            "official=?,  " + 
                            "together_yn=?,  " + 
                            "family_amt=?,  " + 
                            "surport_yn=?,  " + 
                            "sex_div=?,  " + 
                            "family_birthday=?  where resident_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_relation_code);
      gpstatement.bindColumn(5, idx_family_name);
      gpstatement.bindColumn(6, idx_family_resi_no);
      gpstatement.bindColumn(7, idx_offical_name);
      gpstatement.bindColumn(8, idx_school_car_code);
      gpstatement.bindColumn(9, idx_official);
      gpstatement.bindColumn(10, idx_together_yn);
      gpstatement.bindColumn(11, idx_family_amt);
      gpstatement.bindColumn(12, idx_surport_yn);
      gpstatement.bindColumn(13, idx_sex_div);
      gpstatement.bindColumn(14, idx_family_birthday);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_resident_no);
      gpstatement.bindColumn(16, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_family where resident_no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>